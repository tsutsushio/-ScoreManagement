<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生徒管理システム - ログイン</title>
<style>
    /* 全体の背景設定（薄い緑色で画面全体を覆い、中央揃えにする） */
    body {
        font-family: 'Helvetica Neue', Arial, sans-serif;
        background-color: #e8f5e9; /* 背景：とても薄い緑 */
        margin: 0;
        height: 100vh; /* 画面の高さを100%に */
        display: flex;
        justify-content: center; /* 左右の中央揃え */
        align-items: center;     /* 上下の中央揃え */
    }

    /* ログインフォームを囲む白いボックス */
    .login-container {
        background-color: #ffffff; /* 白 */
        padding: 50px 60px;
        border-radius: 12px; /* 角を丸く */
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* ふんわりとした影 */
        text-align: center;
        width: 100%;
        max-width: 400px; /* ボックスの最大幅 */
    }

    /* タイトル（生徒管理システム） */
    .login-container h1 {
        font-size: 28px;
        margin-top: 0;
        margin-bottom: 30px;
        color: #2e7d32; /* メインカラー：濃い緑 */
        letter-spacing: 2px;
    }

    /* エラーメッセージ（間違えた時用の赤文字） */
    .error-msg {
        color: #d32f2f;
        margin-bottom: 20px;
        font-size: 14px;
        font-weight: bold;
    }

    /* 入力フォームのグループ */
    .input-group {
        margin-bottom: 25px;
        text-align: left;
    }

    .input-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
        color: #388e3c; /* ラベル：中くらいの緑 */
    }
    
    .password-wrapper {
    position: relative;
}

.toggle-password {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    font-size: 18px;
    user-select: none;
}
    /* 入力フィールド（テキストボックスとパスワード） */
    .input-group input[type="text"],
    .input-group input[type="password"] {
        width: 100%;
        padding: 12px;
        border: 2px solid #a5d6a7; /* 枠線：薄い緑 */
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 16px;
        transition: border-color 0.3s;
    }

    /* 入力フィールドを選択（クリック）した時 */
    .input-group input[type="text"]:focus,
    .input-group input[type="password"]:focus {
        outline: none;
        border-color: #4caf50; /* 枠線：鮮やかな緑に変化 */
    }

    /* ログインボタン */
    .login-btn {
        width: 100%;
        padding: 14px;
        background-color: #4caf50; /* ボタン：鮮やかな緑 */
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-top: 10px;
    }

    /* ログインボタンにマウスを乗せた時 */
    .login-btn:hover {
        background-color: #388e3c; /* 少し暗い緑にして押せる感を出す */
    }
</style>
</head>
<body>

    <div class="login-container">
        
        <h1>生徒管理システム</h1>
        
        <p class="error-msg">${error}</p>

        <form action="${pageContext.request.contextPath}/action/Login.action" method="post">
            
            <div class="input-group">
                <label for="id">ユーザーID</label>
                <input type="text" id="id" name="id" placeholder="IDを入力" required>
            </div>

            <div class="input-group password-group">
			    <label for="password">パスワード</label>
			    <div class="password-wrapper">
			        <input type="password" id="password" name="password" placeholder="パスワードを入力" required>
			        <span id="togglePassword" class="toggle-password">🤔</span>
			    </div>
			</div>

            <input type="submit" value="ログイン" class="login-btn">
        </form>
        
    </div>
<script>
    const toggle = document.getElementById("togglePassword");
    const password = document.getElementById("password");

    toggle.addEventListener("click", function () {
        if (password.type === "password") {
            password.type = "text";
            toggle.textContent = "👁"; // 見える
        } else {
            password.type = "password";
            toggle.textContent = "🙄"; // 見えない
        }
    });
</script>
</body>
</html>