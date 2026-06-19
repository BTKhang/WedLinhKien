<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ Sơ Của Tôi - WedLinhKien</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafe; }
        .profile-card { border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .avatar-box { width: 100px; height: 100px; background: #0d6efd; color: white; display: flex; align-items: center; justify-content: center; font-size: 40px; border-radius: 50%; margin: 0 auto 20px; }
    </style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark mb-5">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">WEDLINHKIEN</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light btn-sm rounded-pill">Quay lại shop</a>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card profile-card p-5 bg-white text-center">
                <div class="avatar-box fw-bold text-uppercase">${user.fullName.substring(0,1)}</div>
                <h4 class="fw-bold mb-1">${user.fullName}</h4>
                <p class="text-muted small mb-4">Thành viên từ 2023</p>

                <c:if test="${param.success == 'updated'}">
                    <div class="alert alert-success rounded-pill small py-2">Cập nhật hồ sơ thành công!</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/update" method="post" class="text-start">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Họ và Tên</label>
                        <input type="text" name="fullName" class="form-control rounded-pill border-light bg-light px-3" value="${user.fullName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Tên đăng nhập</label>
                        <input type="text" class="form-control rounded-pill border-light bg-light px-3" value="${user.username}" disabled>
                        <small class="text-muted ms-2">Không thể thay đổi tên đăng nhập</small>
                    </div>
                    <div class="mb-4">
                        <label class="form-label small fw-bold text-secondary">Mật khẩu mới</label>
                        <input type="password" name="password" class="form-control rounded-pill border-light bg-light px-3" value="${user.password}" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-bold shadow">CẬP NHẬT HỒ SƠ</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
