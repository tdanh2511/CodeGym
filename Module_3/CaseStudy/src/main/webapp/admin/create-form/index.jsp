<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/create-form/styles.css">
</head>
<body>
<div class="container">
    <h2>Thêm sản phẩm mới</h2>
    <form method="post">
        <div class="form-group">
            <label for="name">Tên sản phẩm:</label>
            <input type="text" id="name" name="name" required placeholder="Nhập tên sản phẩm">
        </div>

        <div class="form-group">
            <label for="price">Giá:</label>
            <input type="number" id="price" name="price" required step="0.01" placeholder="Nhập giá sản phẩm">
        </div>

        <div class="form-group">
            <label for="image">Đường dẫn ảnh:</label>
            <input type="text" id="image" name="image" required placeholder="images/ten_anh.jpg hoặc URL">
        </div>

        <div class="buttons">
            <button type="submit" class="btn btn-danger">💾 Lưu sản phẩm</button>
            <a href="${pageContext.request.contextPath}/adminProductsList" class="btn btn-secondary">⬅ Quay lại</a>
        </div>
    </form>
</div>
</body>
</html>
