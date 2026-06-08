<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>パスワード変更完了</title>
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
    justify-content: center;
    min-height: 80vh; /* 画面の中央に配置します */
    box-sizing: border-box;
}

.container {
    background: #ffffff;
    padding: 40px 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    width: 100%;
    max-width: 400px;
    text-align: center;
    box-sizing: border-box;
}

.success-msg {
    color: #2ecc71; /* 鮮やかで優しい成功のグリーン */
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 15px;
}

p {
    font-size: 14px;
    color: #7f8c8d;
    line-height: 1.6;
    margin: 0 0 24px 0;
}

/* ボタン風にアレンジした戻るリンク */
a {
    display: inline-block;
    width: 100%;
    height: 45px;
    line-height: 45px;
    background-color: #3498db;
    color: #fff;
    text-decoration: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
}

a:hover {
    background-color: #2980b9;
}

br {
    display: none; /* 余計な空白を消して美しく整えます */
}

    </style>
</head>
<body>

    <div class="container">
        <div class="success-msg">パスワードの変更が完了しました。</div>
        <p>次回ログイン時からは、新しいパスワードをご利用ください。</p>
        <br>
        <p><a href="../action/StudentMenu.action">学生メニューへ戻る</a></p>
    </div>

</body>
</html>