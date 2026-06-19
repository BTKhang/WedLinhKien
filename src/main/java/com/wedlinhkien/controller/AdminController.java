package com.wedlinhkien.controller;

import com.wedlinhkien.dao.CategoryDAO;
import com.wedlinhkien.dao.OrderDAO;
import com.wedlinhkien.dao.ProductDAO;
import com.wedlinhkien.dao.UserDAO;
import com.wedlinhkien.model.Product;
import com.wedlinhkien.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private CategoryDAO categoryDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private UserDAO userDAO;

    private boolean checkAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole());
    }

    @GetMapping("")
    public String dashboard(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        
        Double revenue = orderDAO.getTotalRevenue();
        model.addAttribute("totalRevenue", revenue != null ? revenue : 0);
        model.addAttribute("totalOrders", orderDAO.getTotalOrders());
        model.addAttribute("revenueData", orderDAO.getRevenueByDate());
        
        model.addAttribute("products", productDAO.getAllProducts());
        model.addAttribute("categories", categoryDAO.getAllCategories());
        model.addAttribute("orders", orderDAO.getAllOrders());
        model.addAttribute("users", userDAO.getAllUsers());
        
        return "admin/dashboard";
    }

    @GetMapping("/product/add")
    public String addProductPage(Model model, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryDAO.getAllCategories());
        return "admin/addProduct";
    }

    @GetMapping("/product/edit/{id}")
    public String editProduct(@PathVariable int id, Model model, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        model.addAttribute("product", productDAO.getProductById(id));
        model.addAttribute("categories", categoryDAO.getAllCategories());
        return "admin/addProduct";
    }

    @PostMapping("/product/save")
    public String saveProduct(@ModelAttribute("product") Product product) {
        if (product.getId() > 0) productDAO.updateProduct(product);
        else productDAO.addProduct(product);
        return "redirect:/admin";
    }

    @GetMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable int id) {
        productDAO.deleteProduct(id);
        return "redirect:/admin";
    }

    @PostMapping("/category/add")
    public String addCategory(@RequestParam("name") String name) {
        categoryDAO.addCategory(name);
        return "redirect:/admin";
    }

    @GetMapping("/category/delete/{id}")
    public String deleteCategory(@PathVariable int id) {
        categoryDAO.deleteCategory(id);
        return "redirect:/admin";
    }

    @PostMapping("/order/update-status")
    public String updateOrderStatus(@RequestParam("orderId") int orderId, @RequestParam("status") String status) {
        orderDAO.updateOrderStatus(orderId, status);
        return "redirect:/admin";
    }

    // --- CHỨC NĂNG XÓA ĐƠN HÀNG ---
    @GetMapping("/order/delete/{id}")
    public String deleteOrder(@PathVariable int id, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        orderDAO.deleteOrder(id);
        return "redirect:/admin";
    }

    @GetMapping("/user/delete/{id}")
    public String deleteUser(@PathVariable int id, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        userDAO.deleteUser(id);
        return "redirect:/admin";
    }
}
