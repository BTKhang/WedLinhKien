<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WedLinhKien | Chuyên Gia Linh Kiện PC Cao Cấp</title>
    <!-- Bootstrap 5 & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts: Lexend -->
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        :root { --primary: #0061ff; --secondary: #00f2fe; --dark: #0f172a; --light: #f8fafc; --accent: #ef4444; }
        body { font-family: 'Lexend', sans-serif; background-color: #f1f5f9; color: #1e293b; scroll-behavior: smooth; }
        .navbar { background: rgba(15, 23, 42, 0.95); backdrop-filter: blur(10px); padding: 20px 0; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .navbar-brand { font-size: 1.8rem; font-weight: 900; background: linear-gradient(to right, var(--primary), var(--secondary)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .hero-wrap { background: var(--dark); padding: 100px 0; color: white; position: relative; overflow: hidden; border-radius: 0 0 60px 60px; }
        .sidebar-card { background: white; border-radius: 30px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.03); border: 1px solid rgba(0,0,0,0.05); }
        .cat-link { display: flex; align-items: center; padding: 15px 20px; color: #64748b; text-decoration: none; font-weight: 600; border-radius: 15px; transition: 0.4s; margin-bottom: 8px; }
        .cat-link:hover { background: #f1f5f9; color: var(--primary); transform: translateX(8px); }
        .cat-link.active { background: var(--primary); color: white !important; box-shadow: 0 8px 20px rgba(0, 97, 255, 0.3); }
        .product-card { border: none; border-radius: 30px; background: white; transition: 0.5s; overflow: hidden; height: 100%; padding: 20px; }
        .product-card:hover { transform: translateY(-15px); box-shadow: 0 30px 60px rgba(0,0,0,0.08); }
        .img-box { background: #f8fafc; border-radius: 20px; height: 220px; display: flex; align-items: center; justify-content: center; margin-bottom: 20px; padding: 20px; overflow: hidden; }
        .img-box img { max-width: 100%; max-height: 100%; object-fit: contain; transition: 0.5s; }
        .price-text { font-size: 1.4rem; font-weight: 800; color: var(--accent); }
        .btn-buy { width: 50px; height: 50px; border-radius: 18px; background: var(--dark); color: white; border: none; transition: 0.3s; }
        .btn-buy:hover { background: var(--primary); transform: rotate(15deg); }
        footer { background: var(--dark); color: #94a3b8; padding: 80px 0 40px; margin-top: 100px; border-radius: 60px 60px 0 0; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">WEDLINHKIEN</a>
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light rounded-circle me-3 position-relative" style="width: 45px; height: 45px; border-color: rgba(255,255,255,0.2)">
                <i class="fas fa-shopping-bag"></i>
                <span id="cart-badge" class="badge rounded-pill bg-primary position-absolute top-0 start-100 translate-middle">${cartSize}</span>
            </a>
            <c:choose>
                <c:when test="${not empty user}">
                    <div class="dropdown">
                        <button class="btn btn-primary rounded-pill px-4 fw-bold shadow" data-bs-toggle="dropdown">${user.fullName}</button>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-4 mt-3">
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a></li>
                            <c:if test="${user.role == 'ADMIN'}">
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item py-2 text-danger fw-bold" href="${pageContext.request.contextPath}/admin">Quản Trị Hệ Thống</a></li>
                            </c:if>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary rounded-pill px-4 fw-bold">ĐĂNG NHẬP</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<c:if test="${empty keyword}">
<div class="hero-wrap">
    <div class="container text-center">
        <h1 class="display-3 fw-900 text-white mb-4">BUILD PC <span style="color: var(--secondary)">TRONG MƠ</span></h1>
        <p class="lead text-white-50 mb-5">Sở hữu những linh kiện mạnh mẽ nhất với giá thành tốt nhất thị trường.</p>
        <a href="#store" class="btn btn-primary btn-lg rounded-pill px-5 fw-bold shadow-lg">MUA SẮM NGAY</a>
    </div>
</div>
</c:if>

<div class="container mt-5" id="store">
    <div class="row g-4">
        <div class="col-lg-3">
            <div class="sidebar-card">
                <h5 class="fw-900 mb-4"><i class="fas fa-th-large me-2 text-primary"></i>DANH MỤC</h5>
                <a href="${pageContext.request.contextPath}/" class="cat-link ${activeCat == 0 ? 'active' : ''}">Tất cả sản phẩm</a>
                <c:forEach var="cat" items="${categories}">
                    <a href="${pageContext.request.contextPath}/category/${cat.id}" class="cat-link ${activeCat == cat.id ? 'active' : ''}">${cat.name}</a>
                </c:forEach>
            </div>
        </div>

        <div class="col-lg-9">
            <div class="row g-4">
                <c:forEach var="p" items="${products}">
                    <div class="col-md-6 col-xl-4">
                        <div class="card product-card">
                            <div class="img-box">
                                <c:choose>
                                    <c:when test="${fn:startsWith(p.imageUrl, 'http')}">
                                        <img src="${p.imageUrl}" alt="${p.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/resources/images/${p.imageUrl}" alt="${p.name}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="card-body p-0 text-center">
                                <a href="${pageContext.request.contextPath}/product/${p.id}" class="text-decoration-none text-dark">
                                    <h6 class="fw-bold text-truncate">${p.name}</h6>
                                </a>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="price-text"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" /> ₫</span>
                                    <button onclick="addToCart(${p.id}, '${p.name}')" class="btn-buy shadow"><i class="fas fa-cart-plus"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    function addToCart(productId, productName) {
        fetch('${pageContext.request.contextPath}/addToCart?productId=' + productId).then(() => {
            Swal.fire({ title: 'Đã thêm!', text: productName + ' đã vào giỏ hàng.', icon: 'success', toast: true, position: 'top-end', showConfirmButton: false, timer: 2000 });
            let badge = document.getElementById('cart-badge');
            badge.innerText = parseInt(badge.innerText || 0) + 1;
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
