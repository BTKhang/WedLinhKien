<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - WedLinhKien</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Lexend -->
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafe; font-family: 'Lexend', sans-serif; color: #334155; }
        .cart-card { border: none; border-radius: 25px; box-shadow: 0 15px 40px rgba(0,0,0,0.04); background: white; }
        .product-img { width: 90px; height: 90px; object-fit: contain; border-radius: 15px; background: #f1f5f9; padding: 10px; }
        .qty-box { background: #f1f5f9; border-radius: 12px; padding: 5px 10px; display: inline-flex; align-items: center; }
        .qty-input { width: 40px; text-align: center; border: none; background: transparent; font-weight: 700; color: #0f172a; }
        .btn-qty { width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; border-radius: 8px !important; transition: 0.3s; }
        .btn-qty:hover { background: #0d6efd; color: white !important; }
        .price-subtotal { color: #dc3545; font-weight: 700; font-size: 1.05rem; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-5 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/"><i class="fas fa-bolt me-2 text-info"></i>WEDLINHKIEN</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-info rounded-pill px-4 btn-sm fw-bold">Tiếp tục mua sắm</a>
    </div>
</nav>

<div class="container">
    <div class="card cart-card p-4 p-md-5 mb-5">
        <h2 class="fw-bold mb-5"><i class="fas fa-shopping-bag text-primary me-3"></i>Giỏ hàng của bạn</h2>

        <c:choose>
            <c:when test="${empty cart}">
                <div class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/11329/11329061.png" width="140" class="mb-4 opacity-50">
                    <h4 class="text-muted fw-light">Chưa có gì trong giỏ hàng cả!</h4>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3 px-5 py-2 rounded-pill fw-bold shadow">MUA SẮM NGAY</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr class="text-secondary small text-uppercase">
                                <th style="min-width: 300px;">Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th class="text-center">Số lượng</th>
                                <th>Thành tiền</th>
                                <th class="text-center">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cart}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${pageContext.request.contextPath}/resources/images/${item.product.imageUrl}" class="product-img me-3">
                                            <div class="fw-bold text-dark">${item.product.name}</div>
                                        </div>
                                    </td>
                                    <td class="text-muted small fw-bold">
                                        <fmt:formatNumber value="${item.product.price}" type="number" groupingUsed="true" /> ₫
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-center">
                                            <div class="qty-box">
                                                <a href="${pageContext.request.contextPath}/updateCart?productId=${item.product.id}&action=sub" class="btn-qty text-secondary text-decoration-none"><i class="fas fa-minus small"></i></a>
                                                <input type="text" class="qty-input" value="${item.quantity}" readonly>
                                                <a href="${pageContext.request.contextPath}/updateCart?productId=${item.product.id}&action=add" class="btn-qty text-primary text-decoration-none"><i class="fas fa-plus small"></i></a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="price-subtotal">
                                        <fmt:formatNumber value="${item.subTotal}" type="number" groupingUsed="true" /> ₫
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/removeFromCart?productId=${item.product.id}" class="text-danger opacity-50 hover-opacity-100 transition-03"><i class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="row mt-5 pt-4 border-top">
                    <div class="col-md-5 offset-md-7">
                        <div class="card border-0 bg-light p-4 rounded-4">
                            <div class="d-flex justify-content-between mb-3 align-items-center">
                                <span class="text-muted">Tổng cộng thanh toán:</span>
                                <span class="h3 mb-0 text-danger fw-800"><fmt:formatNumber value="${total}" type="number" groupingUsed="true" /> ₫</span>
                            </div>
                            <hr class="my-3 opacity-10">
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold shadow">THANH TOÁN NGAY <i class="fas fa-arrow-right ms-2"></i></a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer class="text-center py-5 text-muted small">
    &copy; 2023 WedLinhKien Team - All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
