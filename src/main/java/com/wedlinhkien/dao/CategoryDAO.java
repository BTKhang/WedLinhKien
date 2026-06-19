package com.wedlinhkien.dao;

import com.wedlinhkien.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM category";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Category.class));
    }

    public void addCategory(String name) {
        String sql = "INSERT INTO category (name) VALUES (?)";
        jdbcTemplate.update(sql, name);
    }

    public void deleteCategory(int id) {
        String sql = "DELETE FROM category WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
