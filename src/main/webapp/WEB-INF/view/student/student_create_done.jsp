<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生登録完了</title>
<style>
    /* 全体レイアウト */
    body {
        margin: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #ffffff;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* メインコンテナ（サイドバーとコンテンツの並び） */
    .container {
        display: flex;
        flex: 1;
    }

    /* 左側サイドバーメニュー（共通メニュー） */
    .sidebar {
        width: 220px;
        background-color: #ffffff;
        border-right: 1px solid #ddd;
        padding: 24px 20px;
        box-sizing: border-box;
    }
    .sidebar ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }
    .sidebar li {
        margin-bottom: 16px;
        color: #333;
        font-weight: bold;
    }
    .sidebar a {
        color: #0066cc;
        text-decoration: none;
        font-weight: normal;
        font-size: 14px;
    }
    .sidebar a:hover {
        text-decoration: underline;
    }
    .sub-menu {
        margin-top: 8px;
        margin-left: 15px;
    }
    .sub-menu li {
        margin-bottom: 8px;
        font-size: 14px;
        font-weight: normal;
    }

    /* 右側メインエリア */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
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

<div class="container">
    <!-- 右側メインエリア -->
    <div class="main-content">

        <!-- ① 見出し「学生情報登録」 -->
        <h2>学生情報登録</h2>
        
        <!-- ② 登録完了メッセージ（緑の帯） -->
        <div class="success-alert">
            登録が完了しました
        </div>
        
        <!-- リンクグループ -->
        <div class="link-group">
            <!-- ③ 戻るリンク（続けて登録する画面へ） -->
            <a href="${pageContext.request.contextPath}/action/StudentCreate.action">戻る</a>
            
            <!-- ④ 学生一覧リンク -->
            <a href="${pageContext.request.contextPath}/action/StudentList.action">学生一覧</a>
        </div>

    </div>
</div>

<!-- フッターの読み込み -->
<%@ include file="/footer.jsp" %>

</body>
</html>
