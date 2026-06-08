<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生変更完了</title>
<style>
    /* 全体：他の画面と共通の縦幅いっぱいベースを作る */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: sans-serif;
        background-color: #f9f9f9;
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
        padding: 40px;
        box-sizing: border-box;
        background-color: #f9f9f9;

        /* メッセージボックスを中央に配置するための設定 */
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* メッセージボックス（スタイルはそのまま流用） */
    .message-box {
        background-color: white;
        padding: 40px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        text-align: center;
        width: 350px;
        box-sizing: border-box; /* パディングでの幅崩れ防止 */
    }

    h2 {
        color: #333;
        margin-top: 0;
        margin-bottom: 20px;
    }

    p {
        color: #555;
        font-size: 16px;
        margin-bottom: 30px;
    }
    
    .btn {
        display: block;
        padding: 12px;
        text-decoration: none;
        border-radius: 4px;
        font-size: 16px;
        font-weight: bold;
        transition: background-color 0.2s;
        background-color: #0d6efd; /* 青色 */
        color: white;
    }
    
    .btn:hover {
        background-color: #0b5ed7;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="message-box">
            <h2>変更完了</h2>
            <p>学生情報の変更が完了しました。</p>
            
            <a href="${pageContext.request.contextPath}/action/StudentList.action" class="btn">学生一覧へ戻る</a>
        </div>

    </div> </div> </body>
</html>