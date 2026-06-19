<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.id > 0 ? 'Sửa' : 'Thêm'} Linh Kiện | Admin Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #f1f5f9; font-family: 'Lexend', sans-serif; }
        .form-card { border: none; border-radius: 25px; box-shadow: 0 15px 40px rgba(0,0,0,0.05); background: white; padding: 40px; }
        .form-label { font-weight: 600; color: #475569; font-size: 0.9rem; }
        .form-control, .form-select { border-radius: 12px; padding: 12px 15px; border: 1px solid #e2e8f0; background: #f8fafc; }
        .form-control:focus { box-shadow: 0 0 0 4px rgba(14, 165, 233, 0.1); border-color: #0ea5e9; }
        .btn-save { background: #0ea5e9; color: white; border: none; padding: 12px 40px; border-radius: 50px; font-weight: bold; transition: 0.3s; }
        .btn-save:hover { background: #0284c7; transform: translateY(-2px); box-shadow: 0 8px 20px rgba(14, 165, 233, 0.3); }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="form-card">
                <div class="text-center mb-5">
                    <h2 class="fw-bold text-dark">${product.id > 0 ? 'Cập Nhật' : 'Thêm Mới'} Linh Kiện</h2>
                    <p class="text-muted">Quản lý kho hàng chuyên nghiệp cho WedLinhKien</p>
                </div>

                <form action="${pageContext.request.contextPath}/admin/product/save" method="post">
                    <input type="hidden" name="id" value="${product.id}">

                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control" value="${product.name}" placeholder="Ví dụ: NVIDIA RTX 4090 ROG Strix" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Giá bán (₫)</label>
                            <input type="number" name="price" class="form-control" value="${product.price}" placeholder="Nhập số tiền" required>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label class="form-label">Danh mục linh kiện</label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${cat.id == product.categoryId ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Tên file hình ảnh</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted small border-0">/resources/images/</span>
                            <input type="text" name="imageUrl" class="form-control" value="${product.imageUrl}" placeholder="cpu_i9.jpg" required>
                        </div>
                        <small class="text-muted mt-2 d-block">Lưu ý: Hãy copy file ảnh vào thư mục <b>webapp/resources/images</b> trước.</small>
                    </div>

                    <div class="mb-5">
                        <label class="form-label">Mô tả sản phẩm</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập thông số kỹ thuật hoặc giới thiệu ngắn...">${product.description}</textarea>
                    </div>

                    <div class="d-flex justify-content-between align-items-center border-top pt-4">
                        <a href="${pageContext.request.contextPath}/admin" class="text-decoration-none text-muted fw-bold">← Quay lại Dashboard</a>
                        <button type="submit" class="btn btn-save shadow-sm">
                            <i class="fas fa-check-circle me-2"></i> ${product.id > 0 ? 'LƯU THAY ĐỔI' : 'THÊM SẢN PHẨM'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>
