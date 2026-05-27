<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>パスワード変更完了</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; text-align: center; padding-top: 50px; }
        .container { border: 1px solid #ccc; padding: 30px; display: inline-block; border-radius: 5px; background-color: #f9f9f9; }
        .success-msg { color: green; font-size: 1.2em; font-weight: bold; margin-bottom: 20px; }
    </style>
</head>
<body>

    <div class="container">
        <div class="success-msg">パスワードの変更が完了しました。</div>
        <p>次回ログイン時からは、新しいパスワードをご利用ください。</p>
        <br>
        <p><a href="../action/StudentMenu.action">学生メニューへ戻る</a></p>
    </div>

</body>
</html>