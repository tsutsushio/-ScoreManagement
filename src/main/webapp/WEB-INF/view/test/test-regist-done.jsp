<%@ page contentType="text/html; charset=UTF-8" %>

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
    background-color: #f5f7fb;
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
    padding: 40px;
    box-sizing: border-box;
    background-color: #f5f7fb;

    /* メッセージボックスを中央に配置するための設定 */
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 完了ボックス */
.done-box {
    background: white;
    padding: 40px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    text-align: center;
    width: 400px;
    box-sizing: border-box; /* 幅崩れ防止 */
}

.done-box h2 {
    color: #4a90e2;
    margin-top: 0;
    margin-bottom: 20px;
}

.done-box p {
    font-size: 18px;
    margin-top: 0;
    margin-bottom: 30px;
    color: #555;
}

/* ボタンを綺麗に横並びにするコンテナ */
.btn-group {
    display: flex;
    justify-content: center;
    gap: 15px; /* ボタン同士の間隔 */
}

.done-box a {
    flex: 1; /* ボタンの幅を均等にする */
    display: inline-block;
    padding: 12px 0; /* 横パディングの代わりに幅一杯にして中央寄せ */
    background: #66a3ff;
    color: white;
    text-decoration: none;
    border-radius: 10px;
    font-size: 15px;
    font-weight: bold;
    transition: 0.2s;
    text-align: center;
}

.done-box a:hover {
    background: #4d8cff;
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

            <p>成績を登録しました！</p>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/action/Menu.action">
                    メニューへ戻る
                </a>
                
                <a href="${pageContext.request.contextPath}/action/TestRegist.action">
                    続けて登録
                </a>
            </div>

        </div> </div> </div> </body>
</html>