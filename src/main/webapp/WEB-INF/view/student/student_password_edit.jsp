<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>パスワード変更</title>

<style>
body {
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #f4f7f9;
    color: #333;
    margin: 0;
    padding: 40px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h1 {
    font-size: 24px;
    color: #2c3e50;
    margin-bottom: 8px;
    text-align: center;
}

p {
    font-size: 14px;
    color: #7f8c8d;
    margin-bottom: 24px;
    text-align: center;
}

form {
    background: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    width: 100%;
    max-width: 400px;
    box-sizing: border-box;
}

.form-group {
    margin-bottom: 20px;
}

label {
    font-size: 14px;
    font-weight: bold;
    color: #34495e;
    display: inline-block;
    margin-bottom: 8px;
}

.password-wrapper {
    position: relative;
    display: block;
    width: 100%;
}

.password-wrapper input {
    width: 100%;
    height: 42px;
    padding: 0 45px 0 12px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fff;
    box-sizing: border-box;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.password-wrapper input:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    outline: none;
}

.toggle-password {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    border: none;
    background: none;
    cursor: pointer;
    font-size: 18px;
    padding: 0;
    line-height: 1;
}

.error-msg {
    color: #e74c3c;
    font-size: 13px;
    display: block;
    margin-top: 6px;
    font-weight: 500;
}

button[type="submit"] {
    width: 100%;
    height: 45px;
    background-color: #3498db;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-top: 10px;
}

button[type="submit"]:hover {
    background-color: #2980b9;
}

a {
    color: #3498db;
    text-decoration: none;
    font-size: 14px;
    transition: color 0.2s;
}

a:hover {
    color: #2980b9;
    text-decoration: underline;
}

br {
    display: none; /* 余計な改行スペースを消して綺麗に整えます */
}

</style>
</head>

<body>

<h1>パスワード変更</h1>
<p>現在のパスワードと、新しいパスワードを入力してください。</p>

<form action="../action/StudentPasswordEditExecute.action" method="post">

    <!-- 現在のパスワード -->
    <div class="form-group">
        <label>現在のパスワード</label><br>

        <div class="password-wrapper">
            <input type="password"
                   name="currentPassword"
                   id="currentPassword"
                   required>

            <button type="button"
                    class="toggle-password"
                    onclick="togglePassword('currentPassword', this)">
                🔒
            </button>
        </div>

        <c:if test="${not empty errors.currentPassword}">
            <span class="error-msg">
                ${errors.currentPassword}
            </span>
        </c:if>
    </div>

    <!-- 新しいパスワード -->
    <div class="form-group">
        <label>新しいパスワード</label><br>

        <div class="password-wrapper">
            <input type="password"
                   name="newPassword"
                   id="newPassword"
                   required>

            <button type="button"
                    class="toggle-password"
                    onclick="togglePassword('newPassword', this)">
                🔒
            </button>
        </div>

        <c:if test="${not empty errors.newPassword}">
            <span class="error-msg">
                ${errors.newPassword}
            </span>
        </c:if>
    </div>

    <!-- 確認用 -->
    <div class="form-group">
        <label>新しいパスワード（確認用）</label><br>

        <div class="password-wrapper">
            <input type="password"
                   name="confirmPassword"
                   id="confirmPassword"
                   required>

            <button type="button"
                    class="toggle-password"
                    onclick="togglePassword('confirmPassword', this)">
                🔒
            </button>
        </div>

        <c:if test="${not empty errors.confirmPassword}">
            <span class="error-msg">
                ${errors.confirmPassword}
            </span>
        </c:if>
    </div>

    <c:if test="${not empty errors.system}">
        <div class="error-msg" style="margin-bottom: 15px;">
            ${errors.system}
        </div>
    </c:if>

    <button type="submit">
        パスワードを変更する
    </button>
</form>

<br>

<p>
    <a href="../action/StudentMenu.action">
        メニューに戻る
    </a>
</p>

<script>
function togglePassword(inputId, button){

    const input =
    document.getElementById(inputId);

    if(input.type === "password"){

        input.type = "text";
        button.textContent = "🔓";

    }else{

        input.type = "password";
        button.textContent = "🔒";
    }
}
</script>

</body>
</html>