package com.example.casestudy.controller.user;

import com.example.casestudy.dao.ProductDAO;
import com.example.casestudy.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserStoreServlet", urlPatterns = "/store")
public class UserStoreServlet extends HttpServlet {
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            loadProducts(request, response);
            return;
        }

        try {
            switch (action) {
                case "search":
                    searchProducts(request, response);
                    break;
                default:
                    loadProducts(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void loadProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("listProducts", productList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("user/product-list/index.jsp");
        dispatcher.forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> searchProducts;

        if (keyword == null || keyword.trim().isEmpty()) {
            searchProducts = productDAO.getAllProducts();
        } else {
            searchProducts = productDAO.searchProducts(keyword.trim());
        }
        request.setAttribute("listProducts", searchProducts);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/user/product-list/index.jsp").forward(request, response);
    }
}
