<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目新規登録</title>

<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #ffffff;
}

body {
    display: flex;
    flex-direction: column;
}

.container {
    display: flex;
    flex: 1;
    width: 100%;
    align-items: stretch;
}

.main-content {
    flex: 1;
    padding: 20px 40px;
    background-color: #ffffff;
    box-sizing: border-box;
}

.main-content h2 {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 10px 15px;
    background-color: #f2f2f2;
    color: #333;
    font-size: 18px;
    font-weight: bold;
}

.form-container {
    max-width: 800px;
    width: 100%;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 6px;
    margin-bottom: 20px;
}

.form-group label {
    font-size: 13px;
    color: #333;
    font-weight: bold;
}

.form-group input[type="text"] {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
}

.form-group input::placeholder {
    color: #aaa;
}

.btn-submit {
    background-color: #6c757d;
    color: #ffffff;
    border: none;
    border-radius: 4px;
    padding: 10px 24px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
}

.btn-submit:hover {
    background-color: #5a6268;
}

.back-link-box {
    margin-top: 5px;
}

.back-link {
    color: #0066ff;
    font-size: 14px;
    text-decoration: underline;
}

.back-link:hover {
    color: #0044cc;
}

.error-msg {
    color: #d9534f;
    font-size: 13px;
    margin-top: 4px;
    font-weight: bold;
    background: #ffe5e5;
    border-left: 5px solid #ff6b6b;
    padding: 10px 14px;
    border-radius: 4px;
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>科目情報登録</h2>

        <div class="form-container">

            <c:if test="${not empty errorMessage}">
                <div class="error-msg">
                    ${errorMessage}
                </div>
                <br>
            </c:if>

            <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.action" method="post">

                <div class="form-group">
                    <label for="cd">科目コード</label>
                    <input type="text" id="cd" name="cd"
                           value="${cd}" maxlength="3"
                           placeholder="3文字の科目コードを入力してください"
                           required>
                </div>

                <div class="form-group">
                    <label for="name">科目名</label>
                    <input type="text" id="name" name="name"
                           value="${name}" maxlength="20"
                           placeholder="科目名を入力してください"
                           required>
                </div>

                <button type="submit" class="btn-submit">登録</button>

            </form>

            <div class="back-link-box">
                <a href="${pageContext.request.contextPath}/action/SubjectList.action"
                   class="back-link">戻る</a>
            </div>

        </div>

    </div>

</div>

<%@ include file="/footer.jsp" %>

</body>
</html>