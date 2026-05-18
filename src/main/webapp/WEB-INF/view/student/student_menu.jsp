<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生メニュー</title>
    </head>
<body>
    <div style="margin: 20px;">
        <h1>学生用ポータルサイト</h1>
        
        <p>ようこそ、<strong>${loginStudent.name}</strong> さん！</p>

        <hr>

        <h2>あなたの基本情報</h2>
        <ul>
            <li><strong>学籍番号：</strong> ${loginStudent.no}</li>
            <li><strong>氏名：</strong> ${loginStudent.name}</li>
            <li><strong>入学年度：</strong> ${loginStudent.entYear} 年度</li>
            <li><strong>クラス：</strong> ${loginStudent.classNum}</li>
        </ul>

        <hr>

        <h2>メニュー</h2>
        <ul>
            <li><a href="#">最新の成績を見る（準備中）</a></li>
            <li><a href="#">パスワードを変更する（準備中）</a></li>
        </ul>

        <br>
        <p><a href="../login/login.jsp">ログアウトして戻る</a></p>
    </div>
</body>
</html>