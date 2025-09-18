package com.example.product_discount_calculator;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "ProductDiscountCalculator", value = "/display-discount")
public class DiscountServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String description = req.getParameter("productDescription");
        float price = Float.parseFloat(req.getParameter("listPrice"));
        float percent = Float.parseFloat(req.getParameter("discountPercent"));

        float discountAmount = price * percent * 0.01f;
        float discountPrice = price - discountAmount;

        PrintWriter out = resp.getWriter();
        out.println("<html><body>");
        out.println("<h2>Product Discount Calculator Result</h2>");
        out.println("<p><strong>Product Description:</strong> " + description + "</p>");
        out.println("<p><strong>List Price:</strong> $" + price + "</p>");
        out.println("<p><strong>Discount Percent:</strong> " + percent + "%</p>");
        out.println("<p><strong>Discount Amount:</strong> $" + discountAmount + "</p>");
        out.println("<p><strong>Discount Price:</strong> $" + discountPrice + "</p>");
        out.println("<br><a href=\"index.jsp\"><button>Quay lại</button></a>");
        out.println("</body></html>");
    }
}