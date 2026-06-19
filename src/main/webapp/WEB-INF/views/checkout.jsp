<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán An Toàn - WedLinhKien</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Lexend -->
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background-color: #f4f7f6; font-family: 'Lexend', sans-serif; color: #334155; }
        .checkout-card { border-radius: 25px; border: none; box-shadow: 0 15px 40px rgba(0,0,0,0.05); }
        .form-control { border-radius: 12px; padding: 12px 20px; border: 1px solid #e0e0e0; }
        .btn-order { background: linear-gradient(to right, #28a745, #218838); color: white; border: none; padding: 15px; border-radius: 50px; font-weight: bold; transition: 0.3s; }
        .btn-order:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(40, 167, 69, 0.3); }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card checkout-card overflow-hidden">
                <div class="row g-0">
                    <div class="col-md-7 p-5">
                        <h2 class="fw-bold mb-4">THÔNG TIN GIAO HÀNG</h2>
                        <form action="${pageContext.request.contextPath}/placeOrder" method="post" id="checkoutForm">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Họ và tên người nhận</label>
                                <input type="text" name="name" class="form-control" value="${preName}" placeholder="Nhập tên đầy đủ" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label small fw-bold">Địa chỉ Email</label>
                                    <input type="email" name="email" class="form-control" placeholder="Để nhận hóa đơn" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label small fw-bold">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control" placeholder="Bắt buộc để giao hàng" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Địa chỉ nhận hàng</label>
                                <textarea name="address" class="form-control" rows="4" placeholder="Ví dụ: 123 Đường ABC, Quận 1, TP.HCM" required></textarea>
                            </div>
                        </form>
                    </div>

                    <div class="col-md-5 bg-light p-5 border-start">
                        <h4 class="fw-bold mb-4 text-center">TỔNG ĐƠN HÀNG</h4>
                        <div class="d-flex justify-content-between mb-3 h5">
                            <span>Thành tiền:</span>
                            <span class="text-danger fw-bold">
                                <fmt:formatNumber value="${total}" type="number" groupingUsed="true" /> ₫
                            </span>
                        </div>
                        <div class="alert alert-success border-0 small">
                            <i class="fas fa-shipping-fast me-2"></i> Miễn phí vận chuyển toàn quốc
                        </div>
                        <hr class="my-4">
                        <div class="payment-methods mb-4">
                            <label class="fw-bold mb-3 small d-block">PHƯƠNG THỨC THANH TOÁN</label>
                            <div class="p-3 border rounded-3 bg-white mb-2 d-flex align-items-center">
                                <input type="radio" checked class="me-3">
                                <i class="fas fa-money-bill-wave text-success me-2"></i> Thanh toán khi nhận hàng (COD)
                            </div>
                        </div>
                        <button type="submit" form="checkoutForm" onclick="showLoading()" class="btn btn-order w-100 fs-5">
                            XÁC NHẬN ĐẶT HÀNG <i class="fas fa-chevron-right ms-2"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function showLoading() {
        if(document.getElementById('checkoutForm').checkValidity()) {
            Swal.fire({
                title: 'Đang xử lý đơn hàng...',
                html: 'Vui lòng không tắt trình duyệt',
                allowOutsideClick: false,
                didOpen: () => { Swal.showLoading() }
            });
        }
    }
</script>
</body>
</html>
