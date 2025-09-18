package com.example.casestudy.controller.user;

import com.example.casestudy.dao.ProductDAO;
import com.example.casestudy.model.CartItem;
import com.example.casestudy.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ShoppingCartServlet", urlPatterns = "/carts")
public class ShoppingCartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "delete":
                    deleteProduct(req);
                    break;
                case "deleteAll":
                    deleteAll(req);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/carts");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "increase":
                    updateQuantity(req, 1);
                    break;
                case "decrease":
                    updateQuantity(req, -1);
                    break;
                case "checkout":
                    checkout(req, resp);
                    return;
                case "confirm":
                    confirmOrder(req, resp);
                    return;
                default:
                    showCart(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        showCart(req, resp);
    }

    // Show giỏ hàng
    private void showCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("user/cart/index.jsp");
        dispatcher.forward(request, response);
    }

    // Update số lượng
    private void updateQuantity(HttpServletRequest request, int delta) {
        int productId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart");

        if (cartItemList == null) {
            cartItemList = new ArrayList<>();
        }

        int index = getIndex(productId, cartItemList);

        if (index == -1) {
            if (delta > 0) {
                Product product = productDAO.getProductById(productId);
                cartItemList.add(new CartItem(product, delta));
            }
        } else {
            CartItem cartItem = cartItemList.get(index);
            int newQuantity = cartItem.getQuantity() + delta;

            if (newQuantity <= 0) {
                cartItemList.remove(index);
            } else {
                cartItem.setQuantity(newQuantity);
            }
        }

        session.setAttribute("cart", cartItemList);
    }

    private int getIndex(int productId, List<CartItem> cart) {
        for (int i = 0; i < cart.size(); i++) {
            if (cart.get(i).getProduct().getId() == productId) {
                return i;
            }
        }
        return -1;
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("message", "Giỏ hàng đang trống, không thể thanh toán.");
            showCart(request, response);
            return;
        }

        double total = 0;
        for (CartItem item : cartItems) {
            total += item.getQuantity() * item.getProduct().getPrice();
        }

        session.setAttribute("orderTotal", total);
        session.setAttribute("orderItems", cartItems);

        RequestDispatcher dispatcher = request.getRequestDispatcher("user/payment/index.jsp");
        dispatcher.forward(request, response);
    }

    private void confirmOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        session.removeAttribute("cart");
        session.removeAttribute("orderItems");
        session.removeAttribute("orderTotal");

        RequestDispatcher dispatcher = request.getRequestDispatcher("user/success/index.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            return;
        }

        int index = getIndex(productId, cart);
        if (index != -1) {
            cart.remove(index);
        }

        session.setAttribute("cart", cart);
    }

    private void deleteAll(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
    }

}
