<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>

<style>

/* 全体のベーススタイル */
body {
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #ffffff;
    color: #333333;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    box-sizing: border-box;
}

/* ヘッダー・フッター用の共通設定（インクルードファイル用） */
header, #header {
    width: 100%;
}

/* 画面全体のレイアウト：左にメニュー、右にメインコンテンツ */
.main-wrapper {
    display: flex;
    flex: 1;
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
    gap: 40px; /* メニューとコンテンツの間の隙間 */
}

/* ーーー 左側：サイドメニュー（もしJSPのヘッダー等に含まれていない場合用） ーーー */
/* 必要に応じてクラス名などは調整してください */
.side-menu {
    width: 180px;
    flex-shrink: 0;
    font-size: 14px;
    line-height: 1.8;
}
.side-menu a {
    color: #0066cc;
    text-decoration: underline;
}

/* ーーー 右側：メインコンテンツエリア ーーー */
.done-box {
    flex: 1;
}

/* ① 「成績管理」の見出し */
.done-box h2 {
    font-size: 20px;
    font-weight: bold;
    background-color: #f1f1f1;
    padding: 12px 20px;
    margin: 0 0 20px 0;
    border-radius: 4px;
    color: #333333;
}

/* ② 緑色のメッセージボックス */
.done-box p {
    background-color: #a3cfbb; /* 画像のような落ち着いた緑色 */
    color: #0f5132;
    padding: 12px 20px;
    margin: 0 0 30px 0;
    font-size: 14px;
    border-radius: 4px;
}

/* ③・④ 下部のリンクボタン（戻る・続けて登録など） */
.done-box a {
    display: inline-block;
    color: #0066cc;
    text-decoration: underline;
    font-size: 15px;
    margin-right: 40px; /* リンク同士の間隔 */
}
.done-box a:hover {
    color: #0033aa;
}

/* ーーー フッターの固定 ーーー */
footer, #footer {
    width: 100%;
    background-color: #edf0f2; /* 画像の薄いグレーのフッター */
    padding: 15px 0;
    text-align: center;
    font-size: 13px;
    color: #666666;
    margin-top: auto; /* 一番下に押し下げる */
    border-top: 1px solid #e0e0e0;
    box-sizing: border-box;
    line-height: 1.5;
}

</style>

</head>
<body>

<!-- 💡 wrapper で囲うことで、コンテンツが画面中央に配置されます -->
<div class="main-wrapper">
    <div class="done-box">
        <h2>登録完了</h2>
        <p>成績を登録しました！</p>
        
        <a href="${pageContext.request.contextPath}/action/Menu.action">
            メニューへ戻る
        </a>
        <a href="${pageContext.request.contextPath}/action/TestRegist.action">
            続けて登録
        </a>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>