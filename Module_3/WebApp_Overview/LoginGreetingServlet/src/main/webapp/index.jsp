<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Form</title>
</head>
<style type="text/css">
    body {
        background-color: #b4b4b4;
        height: 100vh;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login {
        background-color: white;
        padding: 20px;
        width: 300px;
        height: auto;
        box-shadow: 0 0 10px rgba(0,0,0,0.2);
        border-radius: 8px;
        text-align: center;
    }

    .login h2 {
        margin-bottom: 20px;
    }

    .login input[type="text"], .login input[type="password"] {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
    }

    .login input[type="submit"] {
        width: 100px;
        padding: 10px;
        margin-top: 15px;
        cursor: pointer;
    }
</style>
<body>
<form action="/login" method="post">
    <div class="login">
        <h2>Login</h2>
        <input type="text" name="username" id="username" placeholder="username" size="30" required autofocus>
        <input type="password" name="password" id="password" placeholder="password" size="30" required>
        <input type="submit" value="Sign in">
    </div>
</form>
</body>
</html>