package com.example.casestudy.controller.admin;
import com.example.casestudy.dao.AdminDAO;
import com.example.casestudy.service.DBConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Connection conn = DBConnection.getConnection();
        AdminDAO adminDAO = new AdminDAO(conn);

        if (adminDAO.login(username, password)) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", username);
            resp.sendRedirect(req.getContextPath() + "/adminProductsList");
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("admin/login/index.jsp").forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String admin = (String) session.getAttribute("admin");

        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/adminProductsList");
        }
    }
}
