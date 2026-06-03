<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラー</title>

<style>
body {
    margin: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f5f7fb;
}

header {
    background-color: #e6edf7;
    padding: 20px 40px;
    border-bottom: 1px solid #d0d7e2;
}

header h1 {
    margin: 0;
    color: #333;
}

.main {
    text-align: center;
    padding: 80px 20px;
    color: #444;
}

.error-message {
    font-size: 18px;
    margin-bottom: 30px;
}

.back-btn {
    display: inline-block;
    padding: 10px 25px;
    background-color: #4a90e2;
    color: white;
    text-decoration: none;
    border-radius: 6px;
}

.back-btn:hover {
    background-color: #357abd;
}

footer {
    position: fixed;
    bottom: 0;
    width: 100%;
    background-color: #e5e5e5;
    text-align: center;
    padding: 12px;
    color: #666;
}
</style>
</head>

<body>

<header>
    <h1>得点管理システム</h1>
</header>

<div class="main">
    <div class="error-message">
        システムエラーが発生しました。<br>
    </div>

</div>

<footer>
    ©2023 大原学園
</footer>

</body>
</html>