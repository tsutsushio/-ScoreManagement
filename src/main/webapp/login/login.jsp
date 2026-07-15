<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - ログイン</title>
<style>
/* 全体：画面の縦横をいっぱい使い、他の画面と文字フォントを統一 */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif;
    background-color: #f4f6f4; /* ★全体をリラックスできる薄い緑に変更 */
    color: #2b2d42; /* 文字色を優しいチャコールに */
}

body {
    display: flex;
    flex-direction: column; 
}

/* メインエリア：ログインカードを画面の縦横中央に綺麗に配置する */
.main-content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px 20px;
    background-color: #f4f6f4; /* 背景色を統一 */
    box-sizing: border-box;
}

/* ログインカード（お堅いグレー線を廃止し、プレーンで上質な白い1枚のカードへ） */
.login-container {
    width: 100%;
    max-width: 440px; /* 少しシャープに縮めて洗練された印象に */
    background: #ffffff;
    border: 1px solid #edf0ee;
    border-radius: 16px; /* 角丸を大きめにしてトレンド感のある柔らかさに */
    box-sizing: border-box;
    /* 海外SaaS風の、ものすごく薄くて広い上質な影 */
    box-shadow: 0 10px 40px rgba(140, 160, 140, 0.08); 
    overflow: hidden; /* ヘッダーの角丸をきれいに見せる */
}

/* ①「ログイン」のヘッダータイトル部分 */
.login-container h1 {
    margin: 0;
    background-color: #ffffff; /* グレー背景を廃止し、白でクリーンに */
    color: #2c5234; /* メインの深緑 */
    font-size: 20px;
    text-align: center;
    font-weight: 600;
    letter-spacing: 0.05em;
    padding: 30px 30px 10px 30px; /* 上下にゆとりを持たせる */
    border-bottom: none; /* 境界線を消去 */
}

/* フォーム全体のパディング */
form {
    padding: 30px;
}

/* 入力グループ（唐突な青色を廃止し、システム共通の薄いアッシュグレーに変更） */
.input-group {
    margin-bottom: 20px;
    background-color: #f1f3f1; /* 薄いアッシュグリーングレーの背景 */
    border: 1px solid transparent; /* 通常時は線を消す */
    border-radius: 8px; /* 角丸 */
    padding: 8px 16px; /* 少し広げて入力しやすく */
    position: relative;
    transition: all 0.25s ease;
}

/* 入力グループの中にマウスやカーソルが当たった時（フォーカス時）のエフェクト */
.input-group:focus-within {
    background-color: #ffffff;
    border-color: #4a7c59; /* アクセントのグリーン */
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

/* ラベル：入力欄内の上部に小さく配置 */
.input-group label {
    display: block;
    font-size: 11px;
    color: #8a958f; /* 馴染むニュアンスグレー */
    font-weight: 600;
    margin-bottom: 4px;
    letter-spacing: 0.03em;
}

/* 入力欄本体：背景を透明にして枠線を消去 */
.input-group input[type="text"],
.input-group input[type="password"] {
    width: 100%;
    padding: 4px 0; /* ほんの少し高さを広げる */
    box-sizing: border-box;
    border: none;
    background-color: transparent;
    font-size: 14px;
    color: #2b2d42;
}

/* フォーカス時のアウトラインを無効化 */
.input-group input[type="text"]:focus,
.input-group input[type="password"]:focus {
    outline: none;
}

/* パスワードを表示チェックボックス（グリーンに合わせた優しいトーン） */
.checkbox-group {
    display: flex;
    justify-content: flex-start; /* 中央寄せから「左寄せ」にしてフォームの並びを綺麗に */
    align-items: center;
    margin-top: 15px;
    margin-bottom: 25px;
    font-size: 13px;
    color: #4a7c59; /* 親しみやすい緑色 */
    font-weight: 500;
    cursor: pointer;
}

.checkbox-group input {
    margin-right: 8px;
    accent-color: #4a7c59; /* チェックボックス自体の色もほんnり緑に */
}

/* ⑥ログインボタン（フラットで洗練されたメインの深緑ボタン仕様） */
.login-btn {
    display: block;
    width: 100%; /* 30%から100%に広げ、海外ツールのような押しやすいモダンなボタンに */
    padding: 12px;
    border: none;
    border-radius: 8px;
    background: #2c5234; /* メインの深緑 */
    color: #ffffff;
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.05em;
    cursor: pointer;
    text-align: center;
    transition: all 0.2s ease;
}

.login-btn:hover {
    background: #1e3b24; /* ホバー時はより深い緑に */
    box-shadow: 0 4px 12px rgba(44, 82, 52, 0.2);
}

/* エラーメッセージ（バリデーション赤文字） */
.error-msg {
    background: #fff5f5; /* 優しい薄赤 */
    color: #e63946; /* スタイリッシュで目に留まりやすい「くすみ赤」 */
    border-left: 4px solid #e63946; /* 左端の線だけ赤にしてスマートに */
    padding: 14px;
    border-radius: 8px;
    margin: 0 30px 20px 30px; /* フォームの上部に綺麗に収まるマージンに調整 */
    font-weight: 600;
    font-size: 13px;
    text-align: left; /* 左寄せにして読みやすく */
    box-shadow: 0 2px 10px rgba(230, 57, 70, 0.03);
}


</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="main-content">

    <div class="login-container">
        
        <h1>ログイン</h1>
        
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/action/LoginExecute.action" method="post">
            
            <div class="input-group">
                <label for="id">ユーザーID</label>
                <input type="text" id="id" name="id" placeholder="IDを入力" maxlength="10" value="${id}" required>
            </div>

            <div class="input-group">
                <label for="password">パスワード</label>
                <input type="password" id="password" name="password" placeholder="パスワードを入力" maxlength="30" required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="togglePassword">
                <label for="togglePassword">パスワードを表示</label>
            </div>

            <input type="submit" value="ログイン" class="login-btn">
        </form>
        
    </div>
</div>

<%@ include file="/footer.jsp" %>

<script>
    // チェックボックスの変更イベントで表示/非表示を切り替える
    const toggle = document.getElementById("togglePassword");
    const password = document.getElementById("password");

    toggle.addEventListener("change", function () {
        if (toggle.checked) {
            password.type = "text"; // チェックを入れたら見えるようにする
        } else {
            password.type = "password"; // 外したら隠す
        }
    });
</script>
</body>
</html>
