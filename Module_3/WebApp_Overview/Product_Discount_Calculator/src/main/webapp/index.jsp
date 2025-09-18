<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Discount Calculator</title>
</head>
<body>
<h2>Product Discount Calculator</h2>
<form action="/display-discount" method="post" autocomplete="off">
    <label>Product Description: </label>
    <input type="text" name="productDescription" placeholder="Product Discount" required autofocus><br>

    <label>List Price: </label>
    <input type="text" name="listPrice" placeholder="Enter price" required><br>

    <label>Discount Percent: </label>
    <input type="text" name="discountPercent" placeholder="Enter discount (%)" required><br>

    <input type="submit" value="Calculate Discount">
</form>
</body>
</html>