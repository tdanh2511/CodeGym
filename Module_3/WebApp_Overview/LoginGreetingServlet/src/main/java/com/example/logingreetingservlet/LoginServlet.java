package com.example.logingreetingservlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        PrintWriter out = resp.getWriter();
        out.println("<html>");
        if ("admin".equals(username) && "123456".equals(password)) {
            out.println("<h1>Welcome " + username + " to website</h1>");
        } else {
            out.println("<h1>Login error</h1>");
        }
        out.println("</html>");
    }
}