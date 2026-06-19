package com.wedlinhkien.dao;

import com.wedlinhkien.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public User checkLogin(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), username, password);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT count(*) FROM users WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }

    public void register(String username, String password, String fullName) {
        String sql = "INSERT INTO users (username, password, full_name, role) VALUES (?, ?, ?, 'USER')";
        jdbcTemplate.update(sql, username, password, fullName);
    }

    public void updateProfile(int id, String fullName, String password) {
        String sql = "UPDATE users SET full_name = ?, password = ? WHERE id = ?";
        jdbcTemplate.update(sql, fullName, password, id);
    }

    public List<User> getAllUsers() {
        String sql = "SELECT * FROM users ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(User.class));
    }

    public void deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
