<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Đăng nhập Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/login/styles.css"/>
</head>
<body>
<div class="login-container">
    <h2>Đăng nhập quản trị</h2>
    <form method="post" action="${pageContext.request.contextPath}/adminLogin">
        <input type="text" name="username" placeholder="Tài khoản" required autofocus>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <input type="submit" value="Đăng nhập">
    </form>
    <p
            class="error-message"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
    </p>
</div>
</body>
</html>
