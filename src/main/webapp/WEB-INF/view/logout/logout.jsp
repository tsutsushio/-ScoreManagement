<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="pageTitle" value="ログアウト" />

<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生徒管理システム - ログアウト</title>
<style>
    body { 
        font-family: sans-serif;
        background-color: #ffffff; 
        margin: 0;
        padding: 0;
    }

    /* 全体の配置調整用コンテナ */
    .logout-container {
        width: 80%;
        max-width: 800px;
        margin: 40px auto;
        padding: 0 20px;
    }

    /* ① ログアウトヘッダー（グレーの帯） */
    .logout-header {
        background-color: #f2f2f2;
        padding: 10px 20px;
        font-size: 18px;
        font-weight: bold;
        color: #333;
        margin-bottom: 15px;
    }

    /* ② ログアウトメッセージ（緑の帯） */
    .logout-alert {
        background-color: #92c5ad; /* 画像の落ち着いた緑色 */
        color: #333;
        text-align: center;
        padding: 8px 10px;
        font-size: 13px;
        margin-bottom: 40px;
    }

    /* ③ ログインリンク */
    .login-link-group {
        font-size: 14px;
    }
    .login-link-group a {
        color: #0066ff;
        text-decoration: underline;
    }
    .login-link-group a:hover {
        color: #0044cc;
    }
</style>
</head>
<body>

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