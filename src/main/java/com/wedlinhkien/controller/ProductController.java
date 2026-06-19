package com.wedlinhkien.controller;

import com.wedlinhkien.dao.CategoryDAO;
import com.wedlinhkien.dao.ProductDAO;
import com.wedlinhkien.model.CartItem;
import com.wedlinhkien.model.Category;
import com.wedlinhkien.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    private void addCommonData(Model model, HttpSession session) {
        model.addAttribute("categories", categoryDAO.getAllCategories());
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        int totalItems = 0;
        if (cart != null) {
            for (CartItem item : cart) totalItems += item.getQuantity();
        }
        model.addAttribute("cartSize", totalItems);
    }

    @RequestMapping("/")
    public String listProducts(Model model, HttpSession session) {
        model.addAttribute("products", productDAO.getAllProducts());
        model.addAttribute("activeCat", 0); // 0 nghĩa là "Tất cả"
        addCommonData(model, session);
        return "index";
    }

    @GetMapping("/category/{categoryId}")
    public String listProductsByCategory(@PathVariable("categoryId") int categoryId, Model model, HttpSession session) {
        model.addAttribute("products", productDAO.getProductsByCategory(categoryId)); // Lọc sản phẩm theo danh mục
        model.addAttribute("activeCat", categoryId); // Đánh dấu danh mục đang chọn
        addCommonData(model, session);
        return "index";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable("id") int id, Model model, HttpSession session) {
        model.addAttribute("product", productDAO.getProductById(id));
        addCommonData(model, session);
        return "productDetail";
    }

    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
        model.addAttribute("products", productDAO.searchProducts(keyword));
        model.addAttribute("keyword", keyword);
        addCommonData(model, session);
        return "index";
    }

    @GetMapping("/addToCart")
    public String addToCart(@RequestParam("productId") int productId, HttpSession session) {
        Product product = productDAO.getProductById(productId);
        if (product != null) {
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) cart = new ArrayList<>();

            boolean exists = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                cart.add(new CartItem(product, 1));
            }
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart";
    }

    @GetMapping("/updateCart")
    public String updateCart(@RequestParam("productId") int productId, @RequestParam("action") String action, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    if ("add".equals(action)) item.setQuantity(item.getQuantity() + 1);
                    else if ("sub".equals(action) && item.getQuantity() > 1) item.setQuantity(item.getQuantity() - 1);
                    break;
                }
            }
        }
        return "redirect:/cart";
    }

    @GetMapping("/removeFromCart")
    public String removeFromCart(@RequestParam("productId") int productId, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
        }
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String viewCart(Model model, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();
        double total = 0;
        for (CartItem item : cart) total += item.getSubTotal();
        model.addAttribute("cart", cart);
        model.addAttribute("total", total);
        addCommonData(model, session);
        return "cart";
    }
}
