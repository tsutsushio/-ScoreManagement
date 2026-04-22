<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生登録完了</title>
<style>
    /* 完了画面用のシンプルなレイアウト */
    body {
        font-family: sans-serif;
        background-color: #f9f9f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .message-box {
        background-color: white;
        padding: 40px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        text-align: center;
        width: 350px;
    }
    h2 {
        color: #333;
        margin-top: 0;
        margin-bottom: 20px;
    }
    p {
        color: #555;
        font-size: 16px;
        margin-bottom: 30px;
    }
    
    /* 2つのボタンを縦に並べるスタイル */
    .button-group {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }
    .btn {
        display: block;
        padding: 12px;
        text-decoration: none;
        border-radius: 4px;
        font-size: 16px;
        font-weight: bold;
        transition: background-color 0.2s;
    }
    /* 続けて登録するボタン（青） */
    .btn-primary {
        background-color: #007bff;
        color: white;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
    /* 学生一覧へ戻るボタン（グレー） */
    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }
    .btn-secondary:hover {
        background-color: #5a6268;
    }
</style>
</head>
<body>

    <div class="message-box">
        <h2>登録完了</h2>
        <p>学生の登録が完了しました。</p>
        
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/action/StudentCreate.action" class="btn btn-primary">続けて登録する</a>
            
            <a href="${pageContext.request.contextPath}/action/StudentList.action" class="btn btn-secondary">学生一覧へ</a>
        </div>
    </div>

</body>
</html>