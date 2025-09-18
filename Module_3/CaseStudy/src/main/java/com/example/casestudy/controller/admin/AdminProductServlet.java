package com.example.casestudy.controller.admin;

import com.example.casestudy.dao.ProductDAO;
import com.example.casestudy.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductServlet", urlPatterns = "/adminProductsList")
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            try {
                response.sendRedirect("admin/login/index.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            loadProducts(request, response);
            return;
        }

        try {
            switch (action) {
                case "create":
                    insertProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
                default:
                    loadProducts(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            try {
                response.sendRedirect("admin/login/index.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        HttpSession httpSession = request.getSession(false);
        if (httpSession == null || httpSession.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "admin/login/index.jsp");
            return;
        }


        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            loadProducts(request, response);
            return;
        }

        try {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;
                case "update":
                    showEditForm(request, response);
                    break;
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

    // Load sản phẩm từ DB
    private void loadProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("listProducts", productList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/product-list/index.jsp");
        dispatcher.forward(request, response);
    }

    // Form thêm sản phẩm
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/create-form/index.jsp");
        dispatcher.forward(request, response);
    }

    //  Thêm sản phẩm
    private void insertProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));

        Product newProduct = new Product(image, name, price);
        productDAO.insertProduct(newProduct);
        response.sendRedirect(request.getContextPath() + "/adminProductsList");
    }

    //  Xóa sản phẩm
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        productDAO.deleteProduct(id);
        response.sendRedirect(request.getContextPath() + "/adminProductsList");
    }

    // Form chỉnh sửa sản phẩm
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(id);
        request.setAttribute("product", product);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/edit-form/index.jsp");
        dispatcher.forward(request, response);
    }

    // Chỉnh sửa sản phẩm
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));

        Product updated = new Product(id, image, name, price);
        productDAO.updateProduct(updated);
        response.sendRedirect(request.getContextPath() + "/adminProductsList");
    }

    // Tìm kiếm sản phẩm
    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> searchResults;
        if (keyword == null || keyword.trim().isEmpty()) {
            searchResults = productDAO.getAllProducts();
        } else {
            searchResults = productDAO.searchProducts(keyword.trim());
        }
        request.setAttribute("listProducts", searchResults);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/admin/product-list/index.jsp").forward(request, response);
    }
}
