<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 登録完了</title>

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

/* メインエリア：この中でメッセージボックスを画面の真ん中に寄せる */
.main-content {
    flex: 1;
    padding: 40px 20px;
    box-sizing: border-box;
    background-color: #f4f7fb;

    /* メッセージボックスを中央に配置するための設定 */
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 完了ボックス（元のスタイルを100%キープ） */
.done-box {
    width: 450px;
    background: #ffffff;
    padding: 35px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    text-align: center;
    box-sizing: border-box; /* 幅崩れ防止 */
}

.done-box h2 {
    margin: 0 0 20px;
    padding: 14px 20px;
    background: #fff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 28px;
    text-align: left;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.done-message {
    font-size: 16px;
    color: #444;
    margin: 30px 0;
}

.button-area {
    display: flex;
    justify-content: center;
    gap: 15px;
}

.button-area a {
    display: inline-block;
    padding: 10px 22px;
    background-color: #6ea8ff;
    color: #ffffff;
    border: 2px solid #2f5fb8;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
    transition: 0.2s;
}

.button-area a:hover {
    background-color: #4a7bd8;
    box-shadow: 0 4px 10px rgba(74,123,216,0.35);
}

/* メインエリア内でのレスポンシブ調整 */
@media screen and (max-width: 600px) {
    .done-box {
        width: calc(100% - 40px);
    }

    .button-area {
        flex-direction: column;
    }

    .button-area a {
        width: 100%;
        box-sizing: border-box;
    }
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="done-box">
            <h2>登録完了</h2>

            <div class="done-message">
                ${message}
            </div>

            <div class="button-area">
                <a href="${pageContext.request.contextPath}/action/SubjectCreate.action">
                    続けて登録
                </a>

                <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                    一覧へ戻る
                </a>
            </div>
        </div> </div> </div> </body>
</html>