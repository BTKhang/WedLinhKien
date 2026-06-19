<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng - WedLinhKien</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Lexend -->
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Lexend', sans-serif; background-color: #f8fafe; color: #334155; }
        .navbar { background-color: #001d3d; border-bottom: 3px solid #0061ff; }
        .order-card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); background: white; padding: 40px; }
        .table thead th { border-bottom: 2px solid #f1f5f9; color: #64748b; font-size: 0.8rem; text-uppercase: true; letter-spacing: 0.5px; }
        .table tbody td { padding: 20px 0; vertical-align: middle; border-bottom: 1px solid #f1f5f9; }
        .badge-status { padding: 8px 16px; border-radius: 50px; font-size: 0.75rem; font-weight: 600; }
        .price-text { color: #dc3545; font-weight: 700; font-size: 1.1rem; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top mb-5 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/"><i class="fas fa-bolt me-2 text-info"></i>WEDLINHKIEN</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-info rounded-pill px-4 btn-sm fw-bold">Quay lại shop</a>
    </div>
</nav>

<div class="container">
    <div class="order-card">
        <h2 class="fw-bold mb-5 d-flex align-items-center">
            <i class="fas fa-history text-primary me-3"></i> Lịch sử mua hàng của bạn
        </h2>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/11329/11329061.png" width="120" class="mb-4 opacity-50">
                    <h5 class="text-muted">Bạn chưa có đơn hàng nào tại WedLinhKien.</h5>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3 rounded-pill px-4">Khám phá sản phẩm ngay</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>MÃ ĐƠN HÀNG</th>
                                <th>NGÀY ĐẶT</th>
                                <th>ĐỊA CHỈ GIAO HÀNG</th>
                                <th>TỔNG THANH TOÁN</th>
                                <th class="text-center">TRẠNG THÁI</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td class="fw-bold text-primary">#${o.id}</td>
                                    <td class="text-muted small">${o.order_date}</td>
                                    <td class="small" style="max-width: 300px;">${o.customer_address}</td>
                                    <td class="price-text">
                                        <fmt:formatNumber value="${o.total_price}" type="number" groupingUsed="true" /> ₫
                                    </td>
                                    <td class="text-center">
                                        <c:set var="statusClass" value="bg-warning text-dark" />
                                        <c:if test="${o.status == 'Đã giao'}"><c:set var="statusClass" value="bg-success text-white" /></c:if>
                                        <c:if test="${o.status == 'Hủy'}"><c:set var="statusClass" value="bg-danger text-white" /></c:if>
                                        <span class="badge-status ${statusClass}">${o.status}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer class="mt-5 py-5 text-center text-muted small">
    &copy; 2023 WedLinhKien Team. Toàn bộ thông tin đơn hàng được bảo mật tuyệt đối.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
