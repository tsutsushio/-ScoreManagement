<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - ログイン</title>
<style>
/* 全体：画面の縦横をいっぱい使い、他の画面と文字フォントを統一 */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;
    color: #333333;
}

body {
    display: flex;
    flex-direction: column; /* 上からヘッダー、中央メイン、下フッターの順 */
}

/* メインエリア：ログインカードを画面の縦横中央に綺麗に配置する */
.main-content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px 20px;
    box-sizing: border-box;
}

/* ログインカード（システム共通のモダンな影と角丸） */
.login-container {
    width: 100%;
    max-width: 420px;
    background: #ffffff;
    padding: 40px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    box-sizing: border-box;
}

h1 {
    margin: 0 0 25px;
    color: #4a7bd8;
    font-size: 24px;
    text-align: center;
    font-weight: bold;
}

/* 入力グループ */
.input-group {
    margin-bottom: 20px;
}

.input-group label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: bold;
    color: #444;
}

.input-group input[type="text"],
.input-group input[type="password"] {
    width: 100%;
    padding: 11px 14px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
    background-color: #fff;
    transition: 0.2s;
}

.input-group input[type="text"]:focus,
.input-group input[type="password"]:focus {
    outline: none;
    border-color: #6ea8ff;
    box-shadow: 0 0 0 3px rgba(110,168,255,0.2);
}

/* パスワードを表示チェックボックス */
.checkbox-group {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 10px;
    margin-bottom: 25px;
    font-size: 14px;
    color: #555;
    cursor: pointer;
}

.checkbox-group input {
    margin-right: 8px;
    cursor: pointer;
}

.checkbox-group label {
    cursor: pointer;
    user-select: none;
}

/* ログインボタン（システム共通の鮮やかなグラデーション） */
.login-btn {
    display: block;
    width: 60%;
    margin: 0 auto;
    padding: 11px;
    border: none;
    border-radius: 8px;
    background: linear-gradient(135deg, #6ea8ff, #4a7bd8);
    color: #ffffff;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
    text-align: center;
}

.login-btn:hover {
    box-shadow: 0 4px 10px rgba(74,123,216,0.35);
}

/* エラーメッセージ（共通のエラースタイルに準拠） */
.error-msg {
    background: #ffe5e5;
    color: #d33;
    border-left: 5px solid #ff6b6b;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-weight: bold;
    font-size: 14px;
    text-align: center;
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="main-content">

    <div class="login-container">
        
        <h1>得点管理システム</h1>
        
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/action/LoginExecute.action" method="post">
            
            <div class="input-group">
                <label for="id">ユーザーID</label>
                <input type="text" id="id" name="id" placeholder="IDを入力" required>
            </div>

            <div class="input-group">
                <label for="password">パスワード</label>
                <input type="password" id="password" name="password" placeholder="パスワードを入力" required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="togglePassword">
                <label for="togglePassword">パスワードを表示</label>
            </div>

            <input type="submit" value="ログイン" class="login-btn">
        </form>
        
    </div> </div> <%@ include file="/footer.jsp" %>

<script>
    // チェックボックスの変更イベントで表示/非表示を切り替える
    const toggle = document.getElementById("togglePassword");
    const password = document.getElementById("password");

    toggle.addEventListener("change", function () {
        if (toggle.checked) {
            password.type = "text"; // チェックを入れたら見えるようにする
        } else {
            password.type = "password"; // 外したら隠す
        }
    });
</script>
</body>
</html>