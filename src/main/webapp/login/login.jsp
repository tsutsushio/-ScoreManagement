<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生徒管理システム - ログイン</title>
<style>
    /* ===== 全体 ===== */
body {
    font-family: 'Helvetica Neue', Arial, 
        "Hiragino Kaku Gothic ProN", 
        "Hiragino Sans", 
        sans-serif;

    /* 落ち着いたブルーグラデーション */
    background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);

    margin: 0;
    height: 100vh;

    display: flex;
    justify-content: center;
    align-items: center;
}

/* ===== ログイン枠 ===== */
.login-container {
    background-color: rgba(255, 255, 255, 0.97);

    padding: 50px 60px;
    border-radius: 18px;

    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);

    text-align: center;

    width: 100%;
    max-width: 420px;

    transition: transform 0.2s;
}

.login-container:hover {
    transform: translateY(-2px);
}

/* ===== タイトル ===== */
.login-container h1 {
    font-size: 26px;
    margin-bottom: 30px;

    color: #1565c0;

    letter-spacing: 1px;
    position: relative;
}

.login-container h1::after {
    content: "";
    display: block;

    width: 50px;
    height: 3px;

    background: #64b5f6;

    margin: 10px auto 0;
}

/* ===== エラーメッセージ ===== */
.error-msg {
    color: #c62828;
    background: #ffebee;

    padding: 10px;
    border-radius: 6px;

    font-size: 13px;
    font-weight: bold;

    margin-bottom: 20px;
}

/* ===== 入力欄グループ ===== */
.input-group {
    margin-bottom: 25px;
    text-align: left;
}

.input-group label {
    display: block;

    font-weight: bold;
    margin-bottom: 8px;

    color: #1565c0;
}

/* ===== パスワード表示ボタン ===== */
.password-wrapper {
    position: relative;
}

.toggle-password {
    position: absolute;

    right: 12px;
    top: 50%;

    transform: translateY(-50%);

    cursor: pointer;
    font-size: 20px;

    transition: transform 0.2s;
}

.toggle-password:hover {
    transform: translateY(-50%) scale(1.1);
}

/* ===== 入力欄 ===== */
.input-group input[type="text"],
.input-group input[type="password"] {
    width: 100%;

    padding: 14px;

    border: 1px solid #cfd8dc;
    border-radius: 10px;

    box-sizing: border-box;

    font-size: 16px;

    transition: all 0.25s ease;

    background-color: #f7fbff;
}

/* フォーカス時 */
.input-group input:focus {
    outline: none;

    border-color: #42a5f5;

    box-shadow: 0 0 0 4px rgba(66, 165, 245, 0.2);

    background-color: #ffffff;
}

/* ===== ログインボタン ===== */
.login-btn {
    width: 100%;

    padding: 15px;

    background: linear-gradient(to right, #42a5f5, #1e88e5);

    color: white;

    border: none;
    border-radius: 10px;

    font-size: 18px;
    font-weight: bold;

    cursor: pointer;

    box-shadow: 0 4px 15px rgba(30, 136, 229, 0.25);

    transition: transform 0.2s, box-shadow 0.2s;
}

.login-btn:hover {
    transform: translateY(-2px);

    box-shadow: 0 6px 20px rgba(30, 136, 229, 0.35);
}

.login-btn:active {
    transform: translateY(0);
}


</style>

</head>
	<body>
	
	    <div class="login-container">
	        
	        <h1>生徒管理システム</h1>
	        
			<c:if test="${not empty error}">
			    <p class="error-msg">${error}</p>
			</c:if>
	
	        <form action="${pageContext.request.contextPath}/action/LoginExecute.action" method="post">
	            
	            <div class="input-group">
	                <label for="id">ユーザーID</label>
	                <input type="text" id="id" name="id" placeholder="IDを入力" required>
	            </div>
	
	            <div class="input-group password-group">
				    <label for="password">パスワード</label>
				    <div class="password-wrapper">
				        <input type="password" id="password" name="password" placeholder="パスワードを入力" required>
				        <span id="togglePassword" class="toggle-password">🔒</span>
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
		            toggle.textContent = "🔓"; // 見える
		        } else {
		            password.type = "password";
		            toggle.textContent = "🔒"; // 見えない
		        }
		    });
		</script>
	</body>
</html>