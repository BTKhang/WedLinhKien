*******************************************************************************
*                                                                             *
*                 DỰ ÁN: HỆ THỐNG BÁN LINH KIỆN MÁY TÍNH (Spring MVC)           *
*                                                                             *
*******************************************************************************

vui lòng thực hiện theo các bước hướng dẫn dưới đây:

I. THÔNG TIN ĐĂNG NHẬP (DỮ LIỆU MẪU)
------------------------------------
1. QUẢN TRỊ VIÊN (Admin):
   - Tài khoản: admin
   - Mật khẩu: 123
   - Link: http://localhost:8080/admin

2. NGƯỜI DÙNG (User):
   - Tài khoản: user
   - Mật khẩu: 123

II. CÁC BƯỚC CÀI ĐẶT NHANH
---------------------------
BƯỚC 1: Cấu hình Cơ sở dữ liệu (XAMPP MySQL)
   - Mở XAMPP Control Panel, nhấn START cho Apache và MySQL.
   - Truy cập http://localhost/phpmyadmin/
   - Nhấn vào tab "SQL", Copy toàn bộ nội dung file "database.sql" (nằm cùng thư mục này).
   - Dán vào ô SQL và nhấn "Go" (Thực hiện).

BƯỚC 2: Mở Dự án bằng IntelliJ IDEA
   - File -> Open -> Chọn thư mục "WedLinhKien".
   - Đảm bảo SDK được chọn là Java 17.
   - Chuột phải vào file "pom.xml" -> Maven -> Reload Project (để tải thư viện).

BƯỚC 3: Cấu hình Server (Apache Tomcat 9.0)
   - Add Configuration -> Smart Tomcat (hoặc Tomcat Server Local).
   - Tomcat Server: Trỏ đến thư mục cài đặt Tomcat 9 trên máy.
   - Deployment Directory: Trỏ đến thư mục "src/main/webapp" của dự án.
   - Context Path: Để dấu gạch chéo "/"
   - Nhấn OK và nhấn nút PLAY (Tam giác xanh) để chạy.

BƯỚC 4: Truy cập Website
   - Mở trình duyệt gõ: http://localhost:8080/

III. DANH SÁCH CÁC TÍNH NĂNG CHÍNH
----------------------------------
1. KHÁCH HÀNG: Xem sản phẩm, Lọc danh mục, Tìm kiếm, Đăng ký/Đăng nhập,
   Giỏ hàng thông minh (AJAX), Thanh toán, Xem lịch sử đơn hàng.
2. ADMIN: Dashboard thống kê, Biểu đồ doanh thu (Chart.js), Quản lý Sản phẩm,
   Quản lý Danh mục, Quản lý Đơn hàng (Cập nhật trạng thái), Quản lý Khách hàng.

IV. GHI CHÚ
-----------
- Dự án đã được cấu hình chuẩn UTF-8 để hiển thị Tiếng Việt không lỗi font.
- Toàn bộ hình ảnh sản phẩm nằm trong thư mục: src/main/webapp/resources/images/

