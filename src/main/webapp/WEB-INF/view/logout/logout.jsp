<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="ログアウト" />

<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生徒管理システム - ログアウト</title>
<style>
/* 全体：画面の縦横をいっぱい使い、他の画面と文字フォントを統一 */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif;
    background-color: #fafbfc; /* ★ログイン画面と同じ、少し落ち着いたセージグレー */
    color: #2b2d42; /* 文字色を優しいチャコールに */
}

body {
    display: flex;
    flex-direction: column; 
    justify-content: center; /* 画面の中央にログアウトカードを配置する構造に */
    align-items: center;
}

/* 全体の配置調整用コンテナ（「ただの枠」から「プレーンな白い1枚のカード」へ） */
.logout-container {
    width: 100%;
    max-width: 440px; /* ログイン画面のカード幅（440px）と完全に一致させて統一感を */
    background: #ffffff;
    border: 1px solid #e3e8e4;
    border-radius: 16px; /* 角丸を大きめにして柔らかく */
    padding: 40px; /* カード内の余白をしっかり取る */
    box-sizing: border-box;
    /* 上質な広い影を落として背景から浮かせる */
    box-shadow: 0 12px 32px rgba(100, 120, 105, 0.14); 
    margin: 0; /* 中央配置のためマージンリセット */
}

/* ① ログアウトヘッダー（グレーの帯を廃止し、クリーンな見出し文字へ） */
.logout-header {
    background-color: transparent; /* 背景のグレーを消去 */
    padding: 0;
    margin-bottom: 25px;
    font-size: 20px;
    font-weight: 600;
    letter-spacing: 0.05em;
    color: #2c5234; /* メインの深緑 */
    text-align: center; /* カードの中央に配置 */
}

/* ② ログアウトメッセージ（優しく目を引くソフトミント） */
.logout-alert {
    background-color: #edf7ed;  /* パッと明るく清潔感のある淡いミントグリーン */
    color: #2c5234;             /* 文字は読みやすい深緑に */
    border-left: 4px solid #4a7c59; /* 左端にアクセント線をプラス */
    padding: 16px 20px;         /* 余白を広げてゆったりと */
    margin-bottom: 30px;        /* 下のリンクとの間隔 */
    border-radius: 8px;         /* 角丸にして今風の柔らかさに */
    font-size: 14px;            
    font-weight: 600; 
    text-align: left;           /* 左寄せにすることでモダンなツール感を演出 */
    box-shadow: 0 4px 15px rgba(140, 160, 140, 0.04);
}

/* ③ ログインリンクエリア */
.login-link-group {
    font-size: 14px;
    display: flex;
    justify-content: center; /* ボタンを中央に配置 */
}

/* 古い青文字リンクを廃止し、洗練された「白いボタン」へ変更 */
.login-link-group a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%; /* カード幅いっぱいに広げてログインし直しやすく */
    height: 40px;
    padding: 0 24px;
    background-color: #ffffff; 
    color: #4a7c59;            /* 文字を優しい緑に */
    text-decoration: none;     /* 下線を消去 */
    border: 1px solid #edf0ee; /* 繊細な枠線 */
    border-radius: 8px;        /* 角丸 */
    font-weight: 500;
    letter-spacing: 0.03em;
    box-shadow: 0 2px 8px rgba(140, 160, 140, 0.04);
    transition: all 0.2s ease;
}

/* ログインボタンホバー時：メインの緑ボタンに鮮やかに切り替わる */
.login-link-group a:hover {
    background-color: #4a7c59; 
    color: #ffffff; 
    border-color: #4a7c59;
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.15);
}

</style>
</head>
<body>
<br>
    <div class="logout-container">
        
        <!-- ① ログアウト見出し -->
        <div class="logout-header">
            ログアウト
        </div>
        
        <!-- ② ログアウト完了メッセージ -->
        <div class="logout-alert">
            ログアウトしました
        </div>
        
        <!-- ③ ログイン画面へのリンク -->
        <div class="login-link-group">
            <a href="${pageContext.request.contextPath}/login/login.jsp">ログイン</a>
        </div>
        
    </div>
<%@ include file="/footer.jsp" %>
</body>
</html>