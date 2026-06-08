<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - パスワード変更完了</title>
    <style>
/* 全体：他の画面と共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #f4f7f9;
    color: #333;
}

body {
    display: flex;
    flex-direction: column; /* 上からヘッダー、コンテンツの順 */
}

/* 全体レイアウト（サイドバーとメインコンテンツの横並びコンテナ） */
.container {
    display: flex;
    flex: 1;            /* 画面の残りの高さをすべて使う */
    width: 100%;
    align-items: stretch;
}

/* メインエリア：この中でメッセージボックスを画面の真ん中に寄せる */
.main-content {
    flex: 1;
    padding: 40px 20px;
    box-sizing: border-box;
    background-color: #f4f7f9;

    /* メッセージボックスを中央に配置するための設定 */
    display: flex;
    justify-content: center;
    align-items: center;
}

/* メッセージボックス（元の.containerのスタイルを流用、クラス名競合防止のため変更） */
.message-box {
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

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="message-box">
            <div class="success-msg">パスワードの変更が完了しました。</div>
            <p>次回ログイン時からは、新しいパスワードをご利用ください。</p>
            <br>
            <p><a href="../action/StudentMenu.action">学生メニューへ戻る</a></p>
        </div>

    </div> </div> </body>
</html>