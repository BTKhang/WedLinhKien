<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - WedLinhKien</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Lexend -->
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        :root { --primary-blue: #0061ff; --dark-blue: #001d3d; --soft-gray: #f8f9fa; }
        body { font-family: 'Lexend', sans-serif; background-color: var(--soft-gray); color: #334155; }

        /* Navbar */
        .navbar { background-color: var(--dark-blue); border-bottom: 3px solid var(--primary-blue); }
        .navbar-brand { font-size: 1.6rem; color: white !important; letter-spacing: 1px; font-weight: 800; }

        /* Product Detail Layout */
        .product-detail-wrapper { background: white; border-radius: 25px; box-shadow: 0 15px 40px rgba(0,0,0,0.05); overflow: hidden; }

        /* Left Side: Image */
        .product-image-side {
            background: linear-gradient(135deg, #e0e7ff 0%, #c3dafe 100%); /* Light gradient background */
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px;
            position: relative;
        }
        .product-main-img { max-width: 100%; max-height: 450px; transition: 0.5s ease-in-out; cursor: zoom-in; }
        .product-main-img:hover { transform: scale(1.08); }

        /* Right Side: Details */
        .product-details-side { padding: 50px; }
        .product-title { font-size: 2.2rem; font-weight: 800; color: var(--dark-blue); line-height: 1.2; }
        .price-display { font-size: 2.5rem; font-weight: 800; color: #dc3545; margin-top: 20px; margin-bottom: 30px; }

        .btn-add-to-cart {
            background: var(--primary-blue); color: white; border: none;
            padding: 15px 40px; border-radius: 50px; font-weight: 700; font-size: 1.1rem;
            transition: 0.3s; box-shadow: 0 8px 20px rgba(0, 97, 255, 0.2);
        }
        .btn-add-to-cart:hover { background: #0052d9; transform: translateY(-3px); box-shadow: 0 12px 25px rgba(0, 97, 255, 0.3); }

        /* Tabs Styling */
        .nav-tabs .nav-link { color: #64748b; font-weight: 600; border: none; border-bottom: 2px solid transparent; transition: 0.3s; }
        .nav-tabs .nav-link.active { color: var(--primary-blue); border-bottom: 2px solid var(--primary-blue); background-color: transparent; }
        .tab-content { padding-top: 20px; }

        /* Footer */
        footer { background: var(--dark-blue); color: #8e9194; padding: 50px 0 30px; }
    </style>
</head>
<body>

<!-- Header/Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/"><i class="fas fa-microchip me-2 text-info"></i>WEDLINHKIEN</a>
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-info rounded-pill position-relative me-3 border-2 fw-bold">
                <i class="fas fa-shopping-cart"></i>
                <span id="cart-badge" class="badge rounded-pill bg-danger position-absolute top-0 start-100 translate-middle shadow-sm">${cartSize}</span>
            </a>
            <c:choose>
                <c:when test="${not empty user}">
                    <div class="dropdown">
                        <button class="btn btn-info dropdown-toggle rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i> ${user.fullName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/my-orders">Lịch sử đơn hàng</a></li>
                            <c:if test="${user.role == 'ADMIN'}">
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item py-2 text-danger fw-bold" href="${pageContext.request.contextPath}/admin">Quản Trị Viên</a></li>
                            </c:if>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-info rounded-pill px-4 fw-bold shadow-sm">ĐĂNG NHẬP</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container my-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-white p-3 rounded-pill shadow-sm">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Trang chủ</a></li>
            <li class="breadcrumb-item active text-primary" aria-current="page">${product.name}</li>
        </ol>
    </nav>

    <div class="product-detail-wrapper">
        <div class="row g-0">
            <!-- Left Side: Product Image -->
            <div class="col-lg-6 product-image-side">
                <img src="${pageContext.request.contextPath}/resources/images/${product.imageUrl}" class="product-main-img" alt="${product.name}">
            </div>

            <!-- Right Side: Product Details -->
            <div class="col-lg-6 product-details-side">
                <h1 class="product-title">${product.name}</h1>
                <div class="d-flex align-items-center my-3">
                    <div class="text-warning me-3">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="text-muted small">(120 đánh giá)</span>
                    <span class="badge bg-success ms-3 rounded-pill px-3 py-2"><i class="fas fa-check-circle me-1"></i> Còn hàng</span>
                </div>

                <div class="price-display">
                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> ₫
                </div>

                <div class="d-grid gap-3 d-md-flex mb-5">
                    <button onclick="addToCart(${product.id}, '${product.name}')" class="btn btn-add-to-cart flex-grow-1">
                        <i class="fas fa-cart-plus me-2"></i>THÊM VÀO GIỎ HÀNG
                    </button>
                    <button class="btn btn-outline-danger rounded-pill px-4 shadow-sm"><i class="far fa-heart me-2"></i>Yêu thích</button>
                </div>

                <!-- Tabs for Description/Specs -->
                <ul class="nav nav-tabs mb-3" id="productTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab" aria-controls="description" aria-selected="true">Mô tả chi tiết</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="specs-tab" data-bs-toggle="tab" data-bs-target="#specs" type="button" role="tab" aria-controls="specs" aria-selected="false">Thông số kỹ thuật</button>
                    </li>
                </ul>
                <div class="tab-content" id="productTabsContent">
                    <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                        <p class="text-muted">${product.description}</p>
                        <p class="text-muted">Sản phẩm được bảo hành chính hãng 36 tháng, 1 đổi 1 trong 7 ngày đầu nếu có lỗi từ nhà sản xuất.</p>
                    </div>
                    <div class="tab-pane fade" id="specs" role="tabpanel" aria-labelledby="specs-tab">
                        <ul class="list-unstyled text-muted">
                            <li><i class="fas fa-check-circle me-2 text-success"></i>Tình trạng: Mới 100%</li>
                            <li><i class="fas fa-check-circle me-2 text-success"></i>Bảo hành: 36 tháng</li>
                            <li><i class="fas fa-check-circle me-2 text-success"></i>Thương hiệu: ${product.name.split(' ')[0]}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="container text-center text-muted small">
        &copy; 2023 WedLinhKien Team - Chuyên linh kiện PC chất lượng cao. All rights reserved.
    </div>
</footer>

<script>
    function addToCart(productId, productName) {
        fetch('${pageContext.request.contextPath}/addToCart?productId=' + productId)
            .then(() => {
                Swal.fire({
                    title: 'Đã thêm!',
                    text: productName + ' đã nằm trong giỏ hàng của bạn.',
                    icon: 'success',
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000,
                    timerProgressBar: true
                });
                let badge = document.getElementById('cart-badge');
                badge.innerText = parseInt(badge.innerText || 0) + 1;
            });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
