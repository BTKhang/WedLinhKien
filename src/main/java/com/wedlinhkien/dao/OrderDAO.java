package com.wedlinhkien.dao;

import com.wedlinhkien.model.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Types;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void saveOrder(Integer userId, String name, String email, String phone, String address, double total, List<CartItem> cart) {
        String orderSql = "INSERT INTO orders (user_id, customer_name, customer_email, customer_phone, customer_address, total_price) VALUES (?, ?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            if (userId != null && userId > 0) {
                ps.setInt(1, userId);
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setDouble(6, total);
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            int orderId = keyHolder.getKey().intValue();
            String detailSql = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            for (CartItem item : cart) {
                jdbcTemplate.update(detailSql, orderId, item.getProduct().getId(), item.getQuantity(), item.getProduct().getPrice());
            }
        }
    }

    public List<Map<String, Object>> getAllOrders() {
        return jdbcTemplate.queryForList("SELECT * FROM orders ORDER BY order_date DESC");
    }

    public void updateOrderStatus(int orderId, String status) {
        jdbcTemplate.update("UPDATE orders SET status = ? WHERE id = ?", status, orderId);
    }

    public void deleteOrder(int id) {
        // Xóa chi tiết đơn hàng trước (nếu database chưa cấu hình cascade)
        jdbcTemplate.update("DELETE FROM order_details WHERE order_id = ?", id);
        // Xóa đơn hàng chính
        jdbcTemplate.update("DELETE FROM orders WHERE id = ?", id);
    }

    public List<Map<String, Object>> getOrdersByUserId(int userId) {
        return jdbcTemplate.queryForList("SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC", userId);
    }

    public Double getTotalRevenue() {
        return jdbcTemplate.queryForObject("SELECT COALESCE(SUM(total_price), 0) FROM orders", Double.class);
    }

    public Integer getTotalOrders() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM orders", Integer.class);
    }

    public List<Map<String, Object>> getRevenueByDate() {
        String sql = "SELECT DATE(order_date) as date, SUM(total_price) as total FROM orders GROUP BY DATE(order_date) ORDER BY date ASC LIMIT 7";
        return jdbcTemplate.queryForList(sql);
    }
}
