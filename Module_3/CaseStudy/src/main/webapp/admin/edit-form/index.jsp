<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chỉnh sửa sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/edit-form/styles.css">
</head>
<body>
<div class="login-container">
    <h2>Chỉnh sửa sản phẩm</h2>
    <form action="${pageContext.request.contextPath}/adminProductsList" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${product.id}">

        <input type="text" name="image" placeholder="Link ảnh" value="${product.image}" required>
        <input type="text" name="name" placeholder="Tên sản phẩm" value="${product.name}" required>
        <input type="number" step="0.01" name="price" placeholder="Giá sản phẩm" value="${product.price}" required>

        <input type="submit" value="Lưu thay đổi">
    </form>
</div>
</body>
</html>
