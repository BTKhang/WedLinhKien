<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công - WedLinhKien</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .success-card { background: white; padding: 50px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); text-align: center; max-width: 500px; width: 100%; }
        .success-icon { font-size: 80px; color: #28a745; margin-bottom: 20px; animation: bounce 1s ease infinite alternate; }
        @keyframes bounce { from { transform: translateY(0); } to { transform: translateY(-10px); } }
        .btn-home { background: #0d6efd; color: white; border-radius: 50px; padding: 12px 30px; transition: 0.3s; }
        .btn-home:hover { background: #0056b3; transform: scale(1.05); }
    </style>
</head>
<body>

<div class="success-card">
    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    <h1 class="fw-bold mb-3">ĐẶT HÀNG THÀNH CÔNG!</h1>
    <p class="text-muted mb-4">Cảm ơn bạn đã tin tưởng WedLinhKien. Đơn hàng của bạn đang được xử lý và sẽ sớm giao đến địa chỉ của bạn.</p>

    <div class="alert alert-info py-2 small mb-4">
        Hệ thống đã lưu đơn hàng vào <strong>Lịch sử mua hàng</strong> của bạn.
    </div>

    <div class="d-grid gap-2">
        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-primary rounded-pill">Xem lịch sử đơn hàng</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-home">Quay lại Trang Chủ</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
