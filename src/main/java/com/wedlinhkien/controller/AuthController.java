package com.wedlinhkien.controller;

import com.wedlinhkien.dao.UserDAO;
import com.wedlinhkien.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    @Autowired
    private UserDAO userDAO;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("username") String username, 
                        @RequestParam("password") String password, 
                        HttpSession session, Model model) {
        User user = userDAO.checkLogin(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/";
        }
        model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu sai!");
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam("username") String username,
                           @RequestParam("password") String password,
                           @RequestParam("fullName") String fullName,
                           Model model) {
        if (userDAO.isUsernameExists(username)) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "register";
        }
        userDAO.register(username, password, fullName);
        return "redirect:/login?success=registered";
    }

    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("fullName") String fullName,
                                @RequestParam("password") String password,
                                HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            userDAO.updateProfile(user.getId(), fullName, password);
            user.setFullName(fullName);
            user.setPassword(password);
            session.setAttribute("user", user);
        }
        return "redirect:/profile?success=updated";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
