<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>パスワード変更</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error-msg { color: red; font-size: 0.9em; display: block; margin-top: 5px; }
        .form-group { margin-bottom: 15px; }
    </style>
</head>
<body>
    <h1>パスワード変更</h1>
    <p>現在のパスワードと、新しいパスワードを入力してください。</p>

    <form action="../action/StudentPasswordEditExecute.action" method="post">
        
        <div class="form-group">
            <label>現在のパスワード</label><br>
            <input type="password" name="currentPassword" required>
            <c:if test="${not empty errors.currentPassword}">
                <span class="error-msg">${errors.currentPassword}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label>新しいパスワード</label><br>
            <input type="password" name="newPassword" required>
            <c:if test="${not empty errors.newPassword}">
                <span class="error-msg">${errors.newPassword}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label>新しいパスワード（確認用）</label><br>
            <input type="password" name="confirmPassword" required>
            <c:if test="${not empty errors.confirmPassword}">
                <span class="error-msg">${errors.confirmPassword}</span>
            </c:if>
        </div>

        <c:if test="${not empty errors.system}">
            <div class="error-msg" style="margin-bottom: 15px;">${errors.system}</div>
        </c:if>

        <button type="submit">パスワードを変更する</button>
    </form>

    <br>
    <p><a href="../action/StudentMenu.action">メニューに戻る</a></p>

</body>
</html>