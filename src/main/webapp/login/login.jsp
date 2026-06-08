<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生徒管理システム - ログイン</title>
<style>
    /* 画像の「得点管理システム」のデザインに近づけるための簡易スタイル */
    body {
        font-family: sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .login-container {
        width: 400px;
        margin: 50px auto;
        background: #fff;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    h1 {
        text-align: center;
        font-size: 20px;
        margin-bottom: 20px;
        color: #333;
    }
    .input-group {
        margin-bottom: 15px;
    }
    .input-group label {
        display: block;
        margin-bottom: 5px;
        font-size: 14px;
        color: #666;
    }
    .input-group input[type="text"],
    .input-group input[type="password"] {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #f0f4f9; /* 画像の薄い青背景を再現 */
    }
    /* パスワードを表示チェックボックスのスタイル（中央寄せ・余白） */
    .checkbox-group {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
        font-size: 14px;
        color: #333;
    }
    .checkbox-group input {
        margin-right: 5px;
    }
    /* ログインボタンのスタイル */
    .login-btn {
        display: block;
        width: 50%;
        margin: 0 auto;
        padding: 12px;
        background-color: #0066ff; /* 画像の青色ボタン */
        color: #fff;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }
    .login-btn:hover {
        background-color: #0052cc;
    }
    .error-msg {
        color: red;
        text-align: center;
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
	            
	            <!-- ② ユーザーID入力欄 -->
	            <div class="input-group">
	                <label for="id">ユーザーID</label>
	                <input type="text" id="id" name="id" placeholder="IDを入力" required>
	            </div>
	
	            <!-- ③ パスワード入力欄 -->
	            <div class="input-group">
				    <label for="password">パスワード</label>
				    <input type="password" id="password" name="password" placeholder="パスワードを入力" required>
				</div>
	
	            <!-- ④⑤ パスワードを表示（チェックボックスをボタンの上に配置） -->
	            <div class="checkbox-group">
	                <input type="checkbox" id="togglePassword">
	                <label for="togglePassword">パスワードを表示</label>
	            </div>
	
	            <!-- ⑥ ログインボタン -->
	            <input type="submit" value="ログイン" class="login-btn">
	        </form>
	        
	    </div>

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
		<%@ include file="/footer.jsp" %>
	</body>
</html>
