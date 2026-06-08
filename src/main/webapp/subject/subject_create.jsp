<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目新規登録</title>

<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;
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

/* メインエリア：この中でフォームを配置する */
.main-content {
    flex: 1;
    padding: 40px 20px;
    box-sizing: border-box;
    background-color: #f4f7fb;
    overflow-y: auto;   /* コンテンツが溢れた場合は右側だけスクロール */
    
    /* フォームとリンクを中央に寄せる設定 */
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 戻るリンクとタイトルエリアのラッパー（幅をフォームと同期） */
.content-wrapper {
    width: 100%;
    max-width: 600px;   /* フォームの最大幅に合わせる */
    box-sizing: border-box;
}

.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

.back-link a:hover {
    color: #2f5fb8;
    text-decoration: underline;
}

/* タイトル */
.title-area {
    margin-bottom: 25px;
    padding: 14px 20px;
    background: #ffffff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 24px;
    font-weight: bold;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

/* 登録フォームの白いカード */
.form-area {
    width: 100%;
    background: #ffffff;
    padding: 30px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    box-sizing: border-box;
}

.form-row {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.form-row label {
    width: 120px;
    font-weight: bold;
    color: #444;
    font-size: 14px;
}

.form-row input[type="text"] {
    flex: 1;
    padding: 10px 14px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    box-sizing: border-box;
    transition: 0.2s;
}

.form-row input[type="text"]:focus {
    outline: none;
    border-color: #6ea8ff;
    box-shadow: 0 0 0 3px rgba(110,168,255,0.2);
}

/* エラーメッセージ */
.error {
    background: #ffe5e5;
    color: #d33;
    border-left: 5px solid #ff6b6b;
    padding: 14px 18px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-weight: bold;
    font-size: 14px;
}

/* ボタンエリア */
.button-area {
    text-align: center;
    margin-top: 30px;
}

.button-area input[type="submit"] {
    padding: 10px 24px;
    border: none;
    border-radius: 8px;
    background: linear-gradient(135deg, #6ea8ff, #4a7bd8);
    color: #fff;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

.button-area input[type="submit"]:hover {
    box-shadow: 0 4px 10px rgba(74,123,216,0.35);
}

.button-area a {
    display: inline-block;
    margin-left: 10px;
    padding: 10px 24px;
    border: 1px solid #6ea8ff;
    border-radius: 8px;
    background: #f0f6ff;
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
    transition: 0.2s;
    font-size: 14px;
}

.button-area a:hover {
    background: #6ea8ff;
    color: #fff;
}

/* レスポンシブ対応 */
@media screen and (max-width: 768px) {
    .form-row {
        flex-direction: column;
        align-items: stretch;
    }

    .form-row label {
        width: auto;
        margin-bottom: 8px;
    }
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="content-wrapper">

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                    ← 科目一覧へ戻る
                </a>
            </div>

            <div class="title-area">
                科目新規登録
            </div>

            <div class="form-area">

                <c:if test="${not empty errorMessage}">
                    <div class="error">
                        ${errorMessage}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.action" method="post">

                    <div class="form-row">
                        <label for="cd">科目コード</label>
                        <input type="text" id="cd" name="cd" value="${cd}" maxlength="3" required>
                    </div>

                    <div class="form-row">
                        <label for="name">科目名</label>
                        <input type="text" id="name" name="name" value="${name}" maxlength="20" required>
                    </div>

                    <div class="button-area">
                        <input type="submit" value="登録">

                        <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                            戻る
                        </a>
                    </div>

                </form>
            </div> </div> </div> </div> </body>
</html>