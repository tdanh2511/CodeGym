<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/cart/styles.css">
</head>
<body>
<div id="header">
    <h1><a href="${pageContext.request.contextPath}/store">ＴＥＣＨＳＨＯＰ</a></h1>
</div>

<main id="content1">
    <section class="cart-container">
        <h2 class="cart-title">🎉 Thanh toán thành công!</h2>
        <div class="cart-empty">
            <p>Cảm ơn bạn đã đặt hàng tại TECHSHOP.</p>
            <a href="${pageContext.request.contextPath}/store">
                <button id="checkout-btn">Tiếp tục mua sắm</button>
            </a>
        </div>
    </section>
</main>

<footer id="footer">
    <p>Cảm ơn quý khách © 2025 - TECHSHOP</p>
</footer>
</body>
</html>
