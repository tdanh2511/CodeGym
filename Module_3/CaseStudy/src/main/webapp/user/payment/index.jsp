<%@ page import="com.example.casestudy.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận thanh toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/cart/styles.css">
</head>
<body>
<div id="header">
    <h1><a href="${pageContext.request.contextPath}/store">ＴＥＣＨＳＨＯＰ</a></h1>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/store">Trang chủ</a>
        <a href="#">Sản phẩm</a>
        <a href="#">Liên hệ</a>
    </div>
</div>

<main id="content1">
    <section class="cart-container">
        <h2 class="cart-title">Xác nhận đơn hàng</h2>

        <div class="cart-list">
            <c:forEach var="item" items="${sessionScope.orderItems}">
                <div class="cart-item">
                    <div class="cart-item-left">
                        <img src="${pageContext.request.contextPath}/${item.product.image}" alt="${item.product.name}">
                    </div>
                    <div class="cart-item-info">
                        <p><strong>${item.product.name}</strong></p>
                        <p>Số lượng: ${item.quantity}</p>
                        <p>Giá: ${item.product.price}$</p>
                        <p>Thành tiền: ${item.quantity * item.product.price}$</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <aside class="cart-summary">
            <div class="summary-box">
                <p>Tổng tiền: <strong>${sessionScope.orderTotal}$</strong></p>
                <form action="${pageContext.request.contextPath}/carts" method="get">
                    <input type="hidden" name="action" value="confirm" />
                    <button type="submit" id="checkout-btn">Xác nhận thanh toán</button>
                </form>
            </div>
        </aside>
    </section>
</main>

<footer id="footer">
    <p>Thanh toán an toàn © 2025 - TECHSHOP</p>
</footer>
</body>
</html>
