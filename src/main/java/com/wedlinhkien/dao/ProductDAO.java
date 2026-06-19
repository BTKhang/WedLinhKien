package com.wedlinhkien.dao;

import com.wedlinhkien.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM product";
        return jdbcTemplate.query(sql, new ProductRowMapper());
    }

    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT * FROM product WHERE category_id = ?";
        return jdbcTemplate.query(sql, new ProductRowMapper(), categoryId);
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM product WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new ProductRowMapper(), id);
    }

    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT * FROM product WHERE name LIKE ?";
        return jdbcTemplate.query(sql, new ProductRowMapper(), "%" + keyword + "%");
    }

    // --- CÁC HÀM QUẢN TRỊ (ADMIN) MỚI THÊM ---
    
    public void addProduct(Product product) {
        String sql = "INSERT INTO product (name, price, description, image_url, category_id) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, product.getName(), product.getPrice(), product.getDescription(), product.getImageUrl(), product.getCategoryId());
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE product SET name=?, price=?, description=?, image_url=?, category_id=? WHERE id=?";
        jdbcTemplate.update(sql, product.getName(), product.getPrice(), product.getDescription(), product.getImageUrl(), product.getCategoryId(), product.getId());
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM product WHERE id=?";
        jdbcTemplate.update(sql, id);
    }

    private static class ProductRowMapper implements RowMapper<Product> {
        @Override
        public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setPrice(rs.getDouble("price"));
            product.setDescription(rs.getString("description"));
            product.setImageUrl(rs.getString("image_url"));
            product.setCategoryId(rs.getInt("category_id"));
            return product;
        }
    }
}
