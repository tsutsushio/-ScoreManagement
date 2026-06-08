<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生登録完了</title>

<style>
    /* 全体レイアウト：他の画面と共通の縦幅いっぱいベース */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #ffffff;
    }

    body {
        display: flex;
        flex-direction: column; /* 上からヘッダー、コンテンツの順 */
    }

    /* メインコンテナ（サイドバーとコンテンツの横並び） */
    .container {
        display: flex;
        flex: 1;
        width: 100%;
        align-items: stretch;
    }

    /* 右側メインエリア */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
        box-sizing: border-box;
    }

    /* ① 見出し「学生情報登録」（グレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 20px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        color: #333;
        font-size: 18px;
        font-weight: bold;
    }

    /* ② 登録完了メッセージ（緑の帯） */
    .success-alert {
        background-color: #92c5ad; /* 画像の落ち着いた緑色 */
        color: #333;
        text-align: center;
        padding: 8px 10px;
        font-size: 13px;
        margin-bottom: 50px; /* 下のリンクとの間隔 */
    }

    /* ③④ リンクのグループ（横並び配置） */
    .link-group {
        display: flex;
        gap: 40px; /* 「戻る」と「学生一覧」の横のすき間 */
        font-size: 14px;
    }
    .link-group a {
        color: #0066ff;
        text-decoration: underline;
    }
    .link-group a:hover {
        color: #0044cc;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>学生情報登録</h2>
        
        <div class="success-alert">
            登録が完了しました
        </div>
        
        <div class="link-group">
            <a href="${pageContext.request.contextPath}/action/StudentCreate.action">戻る</a>
            
            <a href="${pageContext.request.contextPath}/action/StudentList.action">学生一覧</a>
        </div>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>