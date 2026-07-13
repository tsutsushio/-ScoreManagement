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
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif;
    background-color: #f4f6f4; /* 全体の薄い緑背景 */
    color: #2b2d42; /* 文字色を優しいチャコールに */
}

body {
    display: flex;
    flex-direction: column; 
}

/* メインコンテナ（サイドバーとコンテンツの横並び） */
.container {
    display: flex;
    flex: 1;
    width: 100%;
    align-items: stretch;
    background-color: #f4f6f4;
}

/* 右側メインエリア */
.main-content {
    flex: 1;
    padding: 40px 60px; /* 余白を贅沢に広げてプレミアムな空気感に */
    background-color: #f4f6f4;
    box-sizing: border-box;
}

/* ① 見出し「学生情報登録」（グレーの帯を廃止し、繊細な下線と文字のみに） */
.main-content h2 {
    margin-top: 0;
    margin-bottom: 35px;
    padding: 0 0 15px 0;
    background-color: transparent;
    border-bottom: 2px solid #edf0ee; /* 洗練された細い下線 */
    color: #2c5234; /* メインの深緑 */
    font-size: 22px;
    font-weight: 500;
    letter-spacing: 0.05em;
}

/* ② 登録完了メッセージ（白カードの上に、優しく目を引くソフトミント） */
.success-alert {
    background-color: #edf7ed;  /* パッと明るく清潔感のある淡いミントグリーン */
    color: #2c5234;             /* 文字は読みやすい深緑に */
    border-left: 4px solid #4a7c59; /* 左端にアクセント線をプラス */
    padding: 20px 24px;         /* 余白を広げてゆったりと */
    margin-bottom: 40px;        /* 下のリンクとの間隔 */
    border-radius: 8px;         /* 角丸にして今風の柔らかさに */
    font-size: 15px;            /* 文字をわずかに大きく */
    font-weight: 600; 
    text-align: left;           /* 左寄せにすることで、モダンなツール感を演出 */
    box-shadow: 0 4px 15px rgba(140, 160, 140, 0.04);
}

/* ③④ リンクのグループ（間隔を少し詰めて、ボタンとして配置しやすく） */
.link-group {
    display: flex;
    gap: 16px; /* ボタン同士の間隔 */
}

/* 古臭い「青文字＋下線」を廃止し、洗練された「並ぶボタン」へ変更 */
.link-group a {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 40px;
    padding: 0 24px;
    background-color: #ffffff; /* 白ベースのボタン */
    color: #4a7c59;            /* 文字を優しい緑に */
    text-decoration: none;     /* 下線を消去 */
    border: 1px solid #edf0ee; /* 繊謝な枠線 */
    border-radius: 8px;        /* 角丸 */
    font-size: 14px; 
    font-weight: 500;
    letter-spacing: 0.03em;
    box-shadow: 0 2px 8px rgba(140, 160, 140, 0.04);
    transition: all 0.2s ease;
}

/* リンクボタンホバー時：メインの緑ボタンに鮮やかに切り替わる */
.link-group a:hover {
    background-color: #4a7c59; 
    color: #ffffff; 
    border-color: #4a7c59;
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.15);
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