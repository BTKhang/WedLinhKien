-- ======================================================
-- DATABASE: wed_linh_kien
-- MÔ TẢ: Hệ thống bán linh kiện máy tính chuyên nghiệp
-- ======================================================

CREATE DATABASE IF NOT EXISTS wed_linh_kien CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE wed_linh_kien;

-- 1. BẢNG DANH MỤC
CREATE TABLE category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- 2. BẢNG NGƯỜI DÙNG
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER'
);

-- 3. BẢNG SẢN PHẨM
CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL
);

-- 4. BẢNG ĐƠN HÀNG
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255),
    customer_phone VARCHAR(20),
    customer_address TEXT,
    total_price DOUBLE,
    status VARCHAR(50) DEFAULT 'Đang xử lý',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 5. BẢNG CHI TIẾT ĐƠN HÀNG
CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE SET NULL
);

-- ======================================================
-- DỮ LIỆU MẪU (DÀNH CHO ĐỒ ÁN)
-- ======================================================

-- Dữ liệu Danh mục
INSERT INTO category (id, name) VALUES
(1, 'Bộ vi xử lý (CPU)'),
(2, 'Card đồ họa (VGA)'),
(3, 'Bộ nhớ RAM'),
(4, 'Bo mạch chủ (Main)'),
(5, 'Ổ cứng SSD/HDD');

-- Dữ liệu Người dùng (Admin: admin/123, User: user/123)
INSERT INTO users (username, password, full_name, role) VALUES
('admin', '123', 'Quản Trị Viên', 'ADMIN'),
('user', '123', 'Khách Hàng Mẫu', 'USER');

-- Dữ liệu Sản phẩm (Hỗ trợ cả link ảnh và tên file)
INSERT INTO product (name, price, description, image_url, category_id) VALUES
('Intel Core i9-14900K', 16500000, '24 Nhân 32 Luồng, Up to 6.0GHz, Siêu mạnh mẽ', 'i9.jpg', 1),
('AMD Ryzen 9 7950X', 14200000, 'Đỉnh cao đa nhân cho dân đồ họa', 'r9.jpg', 1),
('NVIDIA RTX 4090 ROG Strix', 55000000, 'Card đồ họa mạnh nhất thế giới hiện tại', 'rtx4090.jpg', 2),
('NVIDIA RTX 4070 Ti Super', 24500000, 'Hiệu năng cực tốt trên giá thành', 'rtx4070.jpg', 2),
('Corsair Dominator 32GB', 4500000, 'DDR5 6000MHz RGB Cao cấp', 'ram_corsair.jpg', 3),
('ASUS ROG Maximus Z790', 18500000, 'Mainboard cao cấp cho Intel Gen 14', 'z790.jpg', 4),
('Samsung 990 Pro 1TB', 3200000, 'Ổ cứng SSD nhanh nhất thế giới', '990pro.jpg', 5);

-- Dữ liệu Đơn hàng mẫu (Để hiện biểu đồ doanh thu)
INSERT INTO orders (customer_name, customer_email, customer_phone, customer_address, total_price, status) VALUES
('Nguyễn Văn A', 'anv@gmail.com', '0901234567', 'Quận 1, TP.HCM', 16500000, 'Đã giao'),
('Trần Thị B', 'btt@gmail.com', '0911222333', 'Hà Nội', 24500000, 'Đang xử lý');
