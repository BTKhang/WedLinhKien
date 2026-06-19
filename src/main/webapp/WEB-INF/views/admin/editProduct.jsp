<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Sản Phẩm - WedLinhKien Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark fw-bold">
                        <h4 class="mb-0">Cập Nhật Thông Tin Sản Phẩm</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/product/edit" method="post">
                            <input type="hidden" name="id" value="${product.id}">
                            <div class="mb-3">
                                <label class="form-label">Tên sản phẩm</label>
                                <input type="text" name="name" class="form-control" value="${product.name}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá bán (VNĐ)</label>
                                <input type="number" name="price" class="form-control" value="${product.price}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Danh mục</label>
                                <select name="categoryId" class="form-select">
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.id}" ${cat.id == product.categoryId ? 'selected' : ''}>${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên file ảnh</label>
                                <input type="text" name="imageUrl" class="form-control" value="${product.imageUrl}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-warning">Lưu Thay Đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
