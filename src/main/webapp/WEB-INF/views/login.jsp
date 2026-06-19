<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống - WedLinhKien</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Lexend -->
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary-blue: #0061ff; --dark-blue: #001d3d; }
        body { font-family: 'Lexend', sans-serif; background-color: #f8fafe; margin: 0; padding: 0; overflow: hidden; }

        .login-wrapper { height: 100vh; display: flex; }

        /* Left Side: Image/Info */
        .login-side-info {
            flex: 1;
            background: linear-gradient(rgba(0, 29, 61, 0.8), rgba(0, 97, 255, 0.8)),
                        url('https://images.unsplash.com/photo-1540575861501-7cf05a4b125a?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 80px;
            color: white;
        }

        /* Right Side: Form */
        .login-side-form {
            width: 500px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }

        .login-card { width: 100%; max-width: 380px; }
        .form-control {
            border-radius: 12px;
            padding: 12px 18px;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            transition: 0.3s;
        }
        .form-control:focus {
            box-shadow: 0 0 0 4px rgba(0, 97, 255, 0.1);
            border-color: var(--primary-blue);
            background-color: white;
        }
        .btn-login {
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-weight: 700;
            transition: 0.3s;
            margin-top: 20px;
        }
        .btn-login:hover { background: #0052d9; transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0, 97, 255, 0.2); }

        .brand-logo { font-size: 2rem; font-weight: 800; letter-spacing: -1px; color: var(--dark-blue); margin-bottom: 40px; }
        .back-link { text-decoration: none; color: #64748b; font-size: 0.9rem; transition: 0.3s; }
        .back-link:hover { color: var(--primary-blue); }

        @media (max-width: 992px) {
            .login-side-info { display: none; }
            .login-side-form { width: 100%; }
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <!-- Left Info Side -->
    <div class="login-side-info">
        <h1 class="display-4 fw-800 mb-4">Chào mừng trở lại!</h1>
        <p class="lead opacity-75 mb-5">Đăng nhập để trải nghiệm không gian mua sắm linh kiện PC hàng đầu Việt Nam.</p>
        <div class="d-flex align-items-center mb-3">
            <i class="fas fa-check-circle me-3 text-info"></i>
            <span>Hàng chính hãng 100%</span>
        </div>
        <div class="d-flex align-items-center mb-3">
            <i class="fas fa-check-circle me-3 text-info"></i>
            <span>Bảo hành nhanh chóng</span>
        </div>
        <div class="d-flex align-items-center">
            <i class="fas fa-check-circle me-3 text-info"></i>
            <span>Ưu đãi thành viên hấp dẫn</span>
        </div>
    </div>

    <!-- Right Form Side -->
    <div class="login-side-form">
        <div class="login-card text-center">
            <div class="brand-logo"><i class="fas fa-bolt text-primary me-2"></i>WEDLINHKIEN</div>

            <h4 class="fw-bold mb-2">Đăng nhập</h4>
            <p class="text-muted small mb-4">Vui lòng nhập thông tin tài khoản của bạn</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 small py-2 rounded-pill mb-4">${error}</div>
            </c:if>
            <c:if test="${param.success == 'registered'}">
                <div class="alert alert-success border-0 small py-2 rounded-pill mb-4">Đăng ký thành công! Mời bạn đăng nhập.</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="text-start">
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Tên đăng nhập</label>
                    <input type="text" name="username" class="form-control" placeholder="Nhập username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Mật khẩu</label>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
                <div class="text-end mb-4">
                    <a href="#" class="small text-decoration-none">Quên mật khẩu?</a>
                </div>
                <button type="submit" class="btn btn-login w-100 shadow-sm">BẮT ĐẦU MUA SẮM</button>
            </form>

            <div class="mt-5">
                <p class="small text-muted">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-bold text-primary text-decoration-none">Đăng ký ngay</a></p>
                <a href="${pageContext.request.contextPath}/" class="back-link"><i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
