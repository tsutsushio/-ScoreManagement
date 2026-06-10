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

    /* ① メニュー見出し（グレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 30px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        border: none;
        border-radius: 0;
        color: #333;
        font-size: 18px;
        font-weight: bold;
        box-shadow: none;
    }

    /* カード配置 */
    .card-container {
        display: flex;
        justify-content: flex-start;
        align-items: flex-start;
        gap: 20px;
        flex-wrap: wrap;
    }

    /* ★ カードの基本設定（中央寄せに修正） */
    .menu-card {
        width: 220px;
        min-height: 140px;
        border-radius: 6px;
        padding: 20px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        /* 上下左右の真ん中に配置するための設定 */
        justify-content: center; 
        align-items: center;     
        box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    }

    /* ★ カード内の見出しテキスト（中央寄せ） */
    .menu-card h3 {
        margin: 0 0 10px 0;
        color: #333;
        font-size: 16px;
        font-weight: normal;
        text-align: center;
    }

    /* ★ カード内リンクエリア（中央寄せ） */
    .menu-links {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center; /* リンク文字を中央に寄せる */
        gap: 8px;
    }

    /* ②④⑤⑥の青文字・下線付きリンク（中央寄せ） */
    .menu-links a {
        display: inline-block;
        width: auto;
        padding: 0;
        text-align: center;
        background-color: transparent;
        color: #0066ff;
        text-decoration: underline;
        border-radius: 0;
        font-weight: normal;
        font-size: 16px;
    }

    .menu-links a:hover {
        background-color: transparent;
        transform: none;
        color: #0044cc;
    }

    /* ② 学生管理（くすんだ赤/ピンク系） */
    .card-student {
        background-color: #dfb9bc;
    }
    .card-student h3 {
        display: none;
    }

    /* ③④⑤ 成績管理（くすんだ緑系） */
    .card-score {
        background-color: #acd3b1;
    }

    /* ⑥ 科目管理（くすんだ紫/青系） */
    .card-subject {
        background-color: #b9bada;
    }
    .card-subject h3 {
        display: none;
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
    

    <!-- メイン -->
    <div class="main-content">
        <h2>メニュー</h2>

        <div class="card-container">


            <!-- ② 学生管理 -->

            <div class="menu-card card-student">
                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/StudentList.action">
                        学生管理
                    </a>
                </div>
            </div>


            <!-- ③④⑤ 成績管理 -->

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


            <!-- ⑥ 科目管理 -->
            <div class="menu-card card-subject">
                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                        科目管理
                    </a>
                </div>
            </div>

        </div>
    </div>

</div>

    <!-- フッターの読み込み -->
    <%@ include file="/footer.jsp" %>

</body>
</html>
