<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - メインメニュー</title>
<style>
    body { font-family: sans-serif; margin: 20px; }
    .menu-container { border: 1px solid #ccc; padding: 20px; max-width: 400px; }
    ul { list-style-type: none; padding: 0; }
    li { margin-bottom: 10px; }
</style>
</head>
<body>

    <div class="menu-container">
        <h2>メインメニュー</h2>
        
        <p>ようこそ、<strong>${loginUser.name}</strong> 先生！</p>
        
        <hr>
        
        <ul>
            <li><a href="#">学生情報管理</a></li>
            <li><a href="#">成績登録・参照</a></li>
        </ul>
        
        <br>
        <a href="${pageContext.request.contextPath}/action/Logout.action" class="btn-logout">ログアウト</a>
    </div>

</body>
</html>