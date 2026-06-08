<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - メインメニュー</title>

<style>
    /* 全体：画面の縦幅に合わせる */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #f5f7fb;
    }

    body {
        display: flex;
        flex-direction: column; /* ヘッダー、中身、フッターを縦に並べる */
    }

    /* 全体レイアウト（サイドバーとメインコンテンツの横並びコンテナ） */
    .container {
        display: flex;
        flex: 1;          /* 画面の余った縦幅をすべてこれに使う */
        width: 100%;      /* 横幅いっぱい */
        align-items: stretch; /* 子要素（サイドバーとメイン）の高さを統一する */
    }

    /* メインエリア */
    .main-content {
        flex: 1;
        padding: 40px;
        background-color: #f5f7fb;
        box-sizing: border-box;
    }

    .main-content h2 {
        margin-top: 0;
        margin-bottom: 30px;
        padding: 12px 18px;
        background-color: #ffffff;
        border-left: 6px solid #66a3ff;
        border-radius: 8px;
        color: #333;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }

    /* カード配置 */
    .card-container {
        display: flex;
        justify-content: center;
        align-items: stretch;
        gap: 30px;
        flex-wrap: wrap;
    }

    /* カード */
    .menu-card {
        width: 240px;
        min-height: 220px;
        border-radius: 16px;
        padding: 24px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        box-shadow: 0 6px 14px rgba(0,0,0,0.12);
        transition: 0.2s;
    }

    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.18);
    }

    .menu-card h3 {
        margin: 0 0 24px;
        color: #333;
        font-size: 22px;
    }

    /* カード内ボタン */
    .menu-links {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 14px;
    }

    .menu-links a {
        display: block;
        width: 100%;
        padding: 12px 0;
        text-align: center;
        background-color: rgba(255,255,255,0.9);
        color: #0066cc;
        text-decoration: none;
        border-radius: 10px;
        font-weight: bold;
        transition: 0.2s;
    }

    .menu-links a:hover {
        background-color: #ffffff;
        transform: scale(1.03);
    }

    /* カード色 */
    .card-student {
        background: linear-gradient(135deg, #f3bfd0, #e7a7be);
    }

    .card-score {
        background: linear-gradient(135deg, #cfeec7, #b8e3ad);
    }

    .card-subject {
        background: linear-gradient(135deg, #d7d7e8, #c2c2d9);
    }

    /* フッター */
    footer {
        background-color: #e0e0e0;
        text-align: center;
        padding: 14px;
        font-size: 12px;
        color: #666;
        width: 100%;
        box-sizing: border-box;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>
    
    <div class="main-content">
        <h2>メインメニュー</h2>

        <div class="card-container">

            <div class="menu-card card-student">
                <h3>学生管理</h3>

                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/StudentList.action">
                        学生一覧
                    </a>
                </div>
            </div>

            <div class="menu-card card-score">
                <h3>成績管理</h3>

                <div class="menu-links">
                 	<a href="${pageContext.request.contextPath}/action/TestRegist.action">
					    成績登録
					</a>
					<a href="${pageContext.request.contextPath}/action/TestList.action">
					    成績参照
					</a>
                </div>
            </div>

            <div class="menu-card card-subject">
                <h3>科目管理</h3>

                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                        科目一覧
                    </a>
                </div>
            </div>

        </div>
    </div>

</div>

<footer>
    &copy; 2026 得点管理システム
</footer>

</body>
</html>