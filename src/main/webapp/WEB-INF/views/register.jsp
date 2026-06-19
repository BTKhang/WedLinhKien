<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tham Gia Cộng Đồng WedLinhKien</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); height: 100vh; display: flex; align-items: center; }
        .register-card { border-radius: 20px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; }
        .register-bg { background: url('https://images.unsplash.com/photo-1540575861501-7cf05a4b125a?auto=format&fit=crop&w=800&q=80'); background-size: cover; background-position: center; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-9">
            <div class="card register-card">
                <div class="row g-0">
                    <div class="col-md-5 d-none d-md-block register-bg"></div>
                    <div class="col-md-7 p-5 bg-white">
                        <h3 class="fw-bold mb-4">ĐĂNG KÝ THÀNH VIÊN</h3>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <form action="${pageContext.request.contextPath}/register" method="post">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Họ và Tên của bạn</label>
                                <input type="text" name="fullName" class="form-control rounded-pill px-3" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Tên đăng nhập</label>
                                <input type="text" name="username" class="form-control rounded-pill px-3" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Mật khẩu</label>
                                <input type="password" name="password" class="form-control rounded-pill px-3" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-bold mt-3 shadow">TẠO TÀI KHOẢN</button>
                        </form>
                        <p class="text-center mt-4 text-muted small">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-primary fw-bold text-decoration-none">Đăng nhập ngay</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
