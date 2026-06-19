package com.wedlinhkien.controller;

import com.wedlinhkien.dao.OrderDAO;
import com.wedlinhkien.model.CartItem;
import com.wedlinhkien.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    private OrderDAO orderDAO;

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) return "redirect:/cart";
        
        double total = 0;
        for (CartItem item : cart) total += item.getSubTotal();
        model.addAttribute("total", total);
        
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("preName", user.getFullName());
        }
        
        return "checkout";
    }

    @PostMapping("/placeOrder")
    public String placeOrder(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("address") String address,
            HttpSession session) {

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            User user = (User) session.getAttribute("user");
            Integer userId = (user != null) ? user.getId() : null;
            
            double total = 0;
            for (CartItem item : cart) total += item.getSubTotal();

            orderDAO.saveOrder(userId, name, email, phone, address, total, cart);
            session.removeAttribute("cart");
        }
        return "orderSuccess";
    }

    @GetMapping("/my-orders")
    public String myOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        
        List<Map<String, Object>> orders = orderDAO.getOrdersByUserId(user.getId());
        model.addAttribute("orders", orders);
        return "myOrders";
    }
}
