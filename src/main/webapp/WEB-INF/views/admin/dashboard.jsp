<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ Thống Quản Trị Cao Cấp | WedLinhKien</title>
    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root { --admin-bg: #f8fafc; --sidebar-bg: #0f172a; --primary-blue: #0ea5e9; }
        body { background-color: var(--admin-bg); font-family: 'Lexend', sans-serif; margin: 0; overflow-x: hidden; }

        .sidebar { background: var(--sidebar-bg); min-height: 100vh; position: fixed; width: 260px; z-index: 1000; padding: 30px 0; }
        .sidebar-brand { color: white; font-weight: 800; font-size: 1.5rem; text-align: center; margin-bottom: 40px; padding: 0 20px; }
        .nav-admin-link { color: #94a3b8; padding: 14px 25px; text-decoration: none; display: flex; align-items: center; transition: 0.3s; margin: 4px 15px; border-radius: 12px; cursor: pointer; }
        .nav-admin-link:hover { background: rgba(255,255,255,0.05); color: white; }
        .nav-admin-link.active { background: var(--primary-blue); color: white; box-shadow: 0 4px 15px rgba(14, 165, 233, 0.4); }

        .main-wrapper { margin-left: 260px; padding: 40px; }
        .admin-tab { display: none; animation: slideUp 0.4s ease-out; }
        .admin-tab.active { display: block; }
        @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .card-stat { background: white; border: none; border-radius: 24px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); }
        .card-table { background: white; border: none; border-radius: 24px; padding: 30px; box-shadow: 0 10px 40px rgba(0,0,0,0.04); }
        .img-admin { width: 50px; height: 50px; object-fit: contain; border-radius: 10px; background: #f1f5f9; }
        .badge-pill { padding: 6px 16px; border-radius: 50px; font-weight: 600; font-size: 0.75rem; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-brand">WEDLINHKIEN <span style="color: var(--primary-blue)">PRO</span></div>
    <div class="nav-menu">
        <div class="nav-admin-link active" onclick="openTab('tab-stats', this)"><i class="fas fa-chart-pie me-3"></i> Thống Kê</div>
        <div class="nav-admin-link" onclick="openTab('tab-products', this)"><i class="fas fa-microchip me-3"></i> Sản Phẩm</div>
        <div class="nav-admin-link" onclick="openTab('tab-categories', this)"><i class="fas fa-tags me-3"></i> Danh Mục</div>
        <div class="nav-admin-link" onclick="openTab('tab-orders', this)"><i class="fas fa-shopping-cart me-3"></i> Đơn Hàng</div>
        <div class="nav-admin-link" onclick="openTab('tab-users', this)"><i class="fas fa-users me-3"></i> Khách Hàng</div>
        <hr class="text-secondary mx-4 my-4 opacity-25">
        <a href="${pageContext.request.contextPath}/" class="nav-admin-link text-info"><i class="fas fa-store me-3"></i> Xem Shop</a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-admin-link text-danger"><i class="fas fa-sign-out-alt me-3"></i> Thoát</a>
    </div>
</div>

<div class="main-wrapper">
    <!-- TAB 1: THỐNG KÊ -->
    <div id="tab-stats" class="admin-tab active">
        <h2 class="fw-800 mb-5">Tổng Quan Hệ Thống</h2>
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card-stat border-start border-primary border-5">
                    <h6 class="text-muted small fw-bold">DOANH THU</h6>
                    <h3 class="fw-800 mb-0"><fmt:formatNumber value="${totalRevenue}" type="number" /> ₫</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-stat border-start border-success border-5">
                    <h6 class="text-muted small fw-bold">ĐƠN HÀNG</h6>
                    <h3 class="fw-800 mb-0">${totalOrders} Đơn</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-stat border-start border-info border-5">
                    <h6 class="text-muted small fw-bold">SẢN PHẨM</h6>
                    <h3 class="fw-800 mb-0">${products.size()} Món</h3>
                </div>
            </div>
        </div>
        <div class="card-table p-5">
            <h5 class="fw-bold mb-4">Biểu Đồ Doanh Thu</h5>
            <canvas id="revenueChart" height="100"></canvas>
        </div>
    </div>

    <!-- TAB 2: SẢN PHẨM -->
    <div id="tab-products" class="admin-tab">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-800">Kho Sản Phẩm</h2>
            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary rounded-pill px-4 fw-bold shadow">+ Thêm Linh Kiện</a>
        </div>
        <div class="card-table">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead><tr class="text-muted small"><th>HÌNH ẢNH</th><th>TÊN SẢN PHẨM</th><th>GIÁ BÁN</th><th class="text-end">THAO TÁC</th></tr></thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:startsWith(p.imageUrl, 'http')}"><img src="${p.imageUrl}" class="img-admin"></c:when>
                                        <c:otherwise><img src="${pageContext.request.contextPath}/resources/images/${p.imageUrl}" class="img-admin"></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-bold text-dark">${p.name}</td>
                                <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" type="number" /> ₫</td>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/admin/product/edit/${p.id}" class="btn btn-sm btn-light rounded-pill px-3 me-1"><i class="fas fa-pen text-primary"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete/${p.id}" class="btn btn-sm btn-light rounded-pill px-3" onclick="return confirm('Xóa?')"><i class="fas fa-trash text-danger"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- TAB 4: ĐƠN HÀNG (CÓ CHỨC NĂNG XÓA) -->
    <div id="tab-orders" class="admin-tab">
        <h2 class="fw-800 mb-4">Quản Lý Đơn Hàng</h2>
        <div class="card-table">
            <table class="table table-hover align-middle">
                <thead class="bg-light"><tr><th>MÃ ĐH</th><th>KHÁCH HÀNG</th><th>TỔNG TIỀN</th><th>TRẠNG THÁI</th><th>XỬ LÝ / XÓA</th></tr></thead>
                <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td class="fw-bold text-primary">#${o.id}</td>
                            <td><div class="fw-bold text-dark">${o.customer_name}</div><small class="text-muted">${o.customer_phone}</small></td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${o.total_price}" type="number" /> ₫</td>
                            <td><span class="badge-pill bg-warning text-dark">${o.status}</span></td>
                            <td>
                                <div class="d-flex gap-2">
                                    <form action="${pageContext.request.contextPath}/admin/order/update-status" method="post" class="d-flex gap-2">
                                        <input type="hidden" name="orderId" value="${o.id}">
                                        <select name="status" class="form-select form-select-sm rounded-pill border-light bg-light">
                                            <option value="Đang xử lý">Đang xử lý</option>
                                            <option value="Đã giao">Đã giao</option>
                                            <option value="Hủy">Hủy</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-dark rounded-circle"><i class="fas fa-check"></i></button>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/admin/order/delete/${o.id}" class="btn btn-sm btn-outline-danger rounded-circle" onclick="return confirm('Bạn có chắc chắn muốn XÓA ĐƠN HÀNG này không?')">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- (Các tab khác giữ nguyên) -->
    <div id="tab-categories" class="admin-tab">
        <h2 class="fw-800 mb-4">Quản Lý Danh Mục</h2>
        <div class="row">
            <div class="col-md-5">
                <div class="card-table">
                    <h6 class="fw-bold mb-4">Thêm Danh Mục Mới</h6>
                    <form action="${pageContext.request.contextPath}/admin/category/add" method="post" class="mb-4">
                        <div class="input-group"><input type="text" name="name" class="form-control border-light bg-light rounded-start-pill px-3" placeholder="Tên danh mục..." required><button class="btn btn-primary rounded-end-pill px-4" type="submit">Thêm</button></div>
                    </form>
                    <div class="list-group list-group-flush">
                        <c:forEach var="cat" items="${categories}">
                            <div class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                                <span class="fw-bold">${cat.name}</span>
                                <a href="${pageContext.request.contextPath}/admin/category/delete/${cat.id}" class="text-danger"><i class="fas fa-times-circle"></i></a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="tab-users" class="admin-tab">
        <h2 class="fw-800 mb-4">Quản Lý Người Dùng</h2>
        <div class="card-table">
            <table class="table table-hover align-middle">
                <thead><tr class="text-muted small"><th>ID</th><th>HỌ VÀ TÊN</th><th>TÀI KHOẢN</th><th>VAI TRÒ</th><th class="text-end">THAO TÁC</th></tr></thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.id}</td>
                            <td class="fw-bold text-dark">${u.fullName}</td>
                            <td>${u.username}</td>
                            <td><span class="badge bg-light text-dark fw-bold border border-secondary border-opacity-10">${u.role}</span></td>
                            <td class="text-end">
                                <c:if test="${u.role != 'ADMIN'}"><a href="${pageContext.request.contextPath}/admin/user/delete/${u.id}" class="btn btn-sm btn-outline-danger rounded-pill px-3">Xóa</a></c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function openTab(id, el) {
        document.querySelectorAll('.admin-tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.nav-admin-link').forEach(l => l.classList.remove('active'));
        document.getElementById(id).classList.add('active');
        el.classList.add('active');
    }

    const ctx = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: [<c:forEach var="item" items="${revenueData}">'${item.date}',</c:forEach>],
            datasets: [{
                label: 'Doanh thu (₫)',
                data: [<c:forEach var="item" items="${revenueData}">${item.total},</c:forEach>],
                borderColor: '#0ea5e9',
                backgroundColor: 'rgba(14, 165, 233, 0.1)',
                fill: true, tension: 0.4
            }]
        }
    });
</script>
</body>
</html>
