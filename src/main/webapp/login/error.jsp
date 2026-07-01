<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラー</title>
<style>
    body { margin: 0; font-family: "Yu Gothic", sans-serif; background-color: #f5f7fb; display: flex; flex-direction: column; min-height: 100vh; }
    header { background-color: #e6edf7; padding: 20px 40px; border-bottom: 1px solid #d0d7e2; }
    
    .container { display: flex; flex: 1; }
    .sidebar { width: 200px; background-color: #f0f0f0; padding: 20px; border-right: 1px solid #ccc; }
    .main { flex: 1; text-align: center; padding: 80px 20px; color: #444; }
    
    footer { background-color: #e5e5e5; text-align: center; padding: 12px; color: #666; }
</style>
</head>
<body>

    <%@ include file="../header.jsp" %>

    <div class="container">
        <%@ include file="../sidebar.jsp" %>
        
        <div class="main">
            <div class="error-message">
                システムエラーが発生しました。<br>
            </div>
        </div>
    </div>

    <%@ include file="../footer.jsp" %>

</body>
</html>