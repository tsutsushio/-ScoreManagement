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
    background-color: #ffffff; /* 画面全体の背景を白に変更 */
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

/* ログインカード：①の外枠グレー線、角丸なし、幅広め、影なし */
.login-container {
    width: 100%;
    max-width: 500px;
    background: #ffffff;
    border: 1px solid #dcdcdc; /* 薄いグレーの枠線 */
    box-sizing: border-box;
}

/* ①「ログイン」のヘッダータイトル部分 */
.login-container h1 {
    margin: 0;
    background-color: #f5f5f5; /* グレーの背景 */
    color: #333333;
    font-size: 18px;
    text-align: center;
    font-weight: bold;
    padding: 12px;
    border-bottom: 1px solid #dcdcdc;
}

/* フォーム全体のパディング（中身を白枠内に収める） */
form {
    padding: 30px;
}

/* 入力グループ：②、③の青い背景と枠線 */
.input-group {
    margin-bottom: 20px;
    background-color: #ebf2fe; /* 薄い青色の背景 */
    border: 1px solid #c2d6fc; /* 青系の枠線 */
    border-radius: 6px;
    padding: 6px 12px;
    position: relative;
}

/* ラベル：入力欄内の上部に小さく配置 */
.input-group label {
    display: block;
    font-size: 11px;
    color: #666666;
    margin-bottom: 2px;
}

/* 入力欄本体：背景を透明にして枠線を消去 */
.input-group input[type="text"],
.input-group input[type="password"] {
    width: 100%;
    padding: 2px 0;
    box-sizing: border-box;
    border: none;
    background-color: transparent;
    font-size: 14px;
    color: #333333;
}

/* フォーカス時のアウトラインを無効化 */
.input-group input[type="text"]:focus,
.input-group input[type="password"]:focus {
    outline: none;
}

/* パスワードを表示チェックボックス（④、⑤） */
.checkbox-group {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px;
    margin-bottom: 20px;
    font-size: 14px;
    color: #333333;
}

.checkbox-group input {
    margin-right: 6px;
    transform: scale(1.1);
}

/* ⑥ログインボタン：鮮やかな青の単色 */
.login-btn {
    display: block;
    width: 30%;
    margin: 0 auto;
    padding: 10px;
    border: none;
    border-radius: 6px;
    background: #0066ff; /* 鮮やかな青色単色 */
    color: #ffffff;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
}

.login-btn:hover {
    background: #0052cc;
}

/* エラーメッセージ */
.error-msg {
    background: #ffe5e5;
    color: #d33;
    border-left: 5px solid #ff6b6b;
    padding: 12px;
    border-radius: 8px;
    margin: 15px 30px 0 30px;
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
        
        <h1>ログイン</h1>
        
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/action/LoginExecute.action" method="post">
            
            <div class="input-group">
                <label for="id">ユーザーID</label>
                <input type="text" id="id" name="id" placeholder="IDを入力" maxlength="10" value="${id}" required>
            </div>

            <div class="input-group">
                <label for="password">パスワード</label>
                <input type="password" id="password" name="password" placeholder="パスワードを入力" maxlength="30" required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="togglePassword">
                <label for="togglePassword">パスワードを表示</label>
            </div>

            <input type="submit" value="ログイン" class="login-btn">
        </form>
        
    </div>
</div>

<%@ include file="/footer.jsp" %>

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
