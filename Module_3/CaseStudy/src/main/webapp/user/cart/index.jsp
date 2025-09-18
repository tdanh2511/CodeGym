<%@ page import="com.example.casestudy.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/cart/styles.css">
</head>
<body>
<!-- Header -->
<div id="header">
    <h1><a href="${pageContext.request.contextPath}/store">ＴＥＣＨＳＨＯＰ</a></h1>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/store">Trang chủ</a>
        <a href="#">Sản phẩm</a>
        <a href="#">Tin tức</a>
        <a href="#">Liên hệ</a>
    </div>
    <div id="login-btn">
        <button>Đăng nhập</button>
    </div>
</div>

<!-- Nội dung chính -->
<main id="content1">
    <section class="cart-container">
        <h2 class="cart-title">Giỏ hàng của bạn</h2>
        <div class="info-wrapper">
            <!-- Danh sách sản phẩm -->
            <div class="cart-left">
                <div class="cart-list">
                    <c:choose>
                        <c:when test="${not empty sessionScope.cart}">
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <div class="cart-item">
                                    <!-- PHẦN 1: Checkbox + Ảnh (theo hàng ngang) -->
                                    <div class="cart-item-left">
                                        <input
                                                type="checkbox"
                                                class="item-checkbox"
                                                name="selectedItems"
                                                value="${item.product.id}"
                                                checked
                                                data-price="${item.product.price}"
                                                data-quantity="${item.quantity}"
                                        >

                                        <img src="${pageContext.request.contextPath}/${item.product.image}"
                                             alt="${item.product.name}">
                                    </div>

                                    <!-- PHẦN 2: Thông tin -->
                                    <div class="cart-item-info">
                                        <p><strong>${item.product.name}</strong></p>
                                        <p>Giá: ${item.product.price}$</p>
                                        <div class="quantity-control">
                                            <form action="${pageContext.request.contextPath}/carts" method="get">
                                                <input type="hidden" name="action" value="decrease">
                                                <input type="hidden" name="id" value="${item.product.id}">
                                                <button type="submit">-</button>
                                            </form>
                                            <input type="text" class="qty-input" value="${item.quantity}"
                                                   data-product-id="${item.product.id}">
                                            <form action="${pageContext.request.contextPath}/carts" method="get">
                                                <input type="hidden" name="action" value="increase">
                                                <input type="hidden" name="id" value="${item.product.id}">
                                                <button type="submit">+</button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- PHẦN 3: Xóa -->
                                    <div class="cart-item-remove">
                                        <form action="${pageContext.request.contextPath}/carts" method="post"
                                              class="remove-form">
                                            <input type="hidden" name="action" value="delete" />
                                            <input type="hidden" name="productId" value="${item.product.id}">
                                            <button type="submit" class="remove-btn">🗑️ Xóa</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="cart-empty">
                                <p>🛒 Giỏ hàng của bạn đang trống</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:set var="totalQuantity" value="0"/>
            <c:set var="subtotal" value="0"/>
            <c:forEach var="item" items="${sessionScope.cart}">
                <c:set var="totalQuantity" value="${totalQuantity + item.quantity}"/>
                <c:set var="subtotal" value="${subtotal + item.quantity * item.product.price}"/>
            </c:forEach>

            <aside class="cart-summary">
                <div class="summary-box">
                    <h3>Tóm tắt đơn hàng</h3>
                    <p>Số mặt hàng: <span id="summary-count">${totalQuantity}</span></p>
                    <p>Tạm tính: <strong id="summary-subtotal">${subtotal}$</strong></p>
                    <p>Phí vận chuyển: <strong id="summary-shipping">0$</strong></p>
                    <hr>
                    <p class="total-text">Tổng cộng: <strong id="summary-total">${subtotal}$</strong></p>
                    <form action="${pageContext.request.contextPath}/carts" method="get">
                        <input type="hidden" name="action" value="checkout" />
                        <button type="submit" id="checkout-btn">Thanh toán</button>
                    </form>
                </div>
            </aside>
        </div>

        <!-- Nút xóa giỏ hàng -->
        <div class="cart-clear">
            <form action="${pageContext.request.contextPath}/carts" method="POST">
                <input type="hidden" name="action" value="deleteAll" />
                <button type="submit" id="clear-cart">Xóa toàn bộ</button>
            </form>
        </div>
    </section>
</main>

<!-- Footer -->
<footer id="footer">
    <p>Website bán hàng 2025 © Đồ Công Nghệ. Thiết kế bởi DTAnh</p>
</footer>
<script src="${pageContext.request.contextPath}/user/cart/main.js"></script>
</body>
</html>
