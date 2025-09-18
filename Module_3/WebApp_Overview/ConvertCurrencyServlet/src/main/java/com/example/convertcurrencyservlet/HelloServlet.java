package com.example.convertcurrencyservlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "ConvertCurrency", value = "/convert")
public class HelloServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        float rate = Float.parseFloat(req.getParameter("rate"));
        float usd = Float.parseFloat(req.getParameter("usd"));

        float vnd = rate * usd;
        PrintWriter out = resp.getWriter();
        out.println("<h1>Rate: " + rate + "</h1>");
        out.println("<h1>USD: " + usd + "</h1>");
        out.println("<h1>VND: " + vnd + "</h1>");
        out.println("</html>");
    }
}