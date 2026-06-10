<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>科目変更完了</title>

<style>

body {
    font-family: "Yu Gothic", sans-serif;
    margin: 40px;
    background-color: #f4f7fb;
}

.done-box {
    width: 420px;
    padding: 30px;
    margin: 80px auto;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    text-align: center;
}

.done-title {
    font-size: 24px;
    font-weight: bold;
    color: #4a7bd8;
    margin-bottom: 20px;
}

.done-message {
    font-size: 16px;
    margin-bottom: 30px;
}

.button {
    display: inline-block;
    padding: 10px 24px;
    background-color: #4a7bd8;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
}

.button:hover {
    background-color: #3563c8;
}

</style>
</head>
<body>

<div class="done-box">

    <div class="done-title">
        科目変更完了
    </div>

    <div class="done-message">
        科目情報を変更しました。
    </div>

    <a class="button"
       href="${pageContext.request.contextPath}/action/SubjectList.action">
        科目一覧へ戻る
    </a>

</div>

</body>
</html>