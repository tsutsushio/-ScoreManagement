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
    background-color: #ffffff; /* 画像に合わせて背景を白に */
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

/* メインエリア（左上の登録画面と同じ余白設定） */
.main-content {
    flex: 1;
    padding: 20px 40px;
    box-sizing: border-box;
    background-color: #ffffff;
}

/* タイトルエリア（①） */
.main-content h2 {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 12px 15px;
    background-color: #f2f2f2; /* 画像の薄いグレー */
    color: #333;
    font-size: 24px;
    font-weight: bold;
}

/* 登録完了メッセージ帯（②） */
.done-message {
    font-size: 14px;
    color: #333;
    background-color: #8cc6a5; /* 画像のような鮮やかで落ち着いた緑色 */
    padding: 10px 15px;
    margin-bottom: 25px;
    box-sizing: border-box;
}

/* ボタンエリア（③・④の横並びリンク用） */
.button-area {
    display: flex;
    justify-content: flex-start; /* 左寄せに変更 */
    gap: 40px;                   /* リンクとリンクの間の広めのすき間 */
}

/* 各リンクのテキスト装飾（③、④） */
.button-area a {
    color: #007bff;              /* リンクの青色 */
    text-decoration: underline;  /* 下線を表示 */
    font-size: 14px;
    font-weight: normal;         /* 太字を解除 */
    background: none;            /* ボタン風の背景色を削除 */
    border: none;                /* ボタン風の枠線を削除 */
    padding: 0;                  /* 余白を削除 */
}

.button-area a:hover {
    color: #0056b3;
    text-decoration: none;       /* ホバー時は下線を消す */
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <!-- タイトル（①） -->
        <h2>科目情報登録</h2>

        <!-- 登録完了メッセージ（②） -->
        <div class="done-message">
            登録が完了しました
        </div>

        <!-- 各種リンク（③「戻る」、④「科目一覧」） -->
        <div class="button-area">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action">
                戻る
            </a>
            <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                科目一覧
            </a>
        </div>

    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>
