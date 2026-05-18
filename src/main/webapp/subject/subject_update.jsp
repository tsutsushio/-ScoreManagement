<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目変更</title>

<style>
body {
    margin: 0;
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background-color: #f4f6f9;
    color: #333;
}

header {
    background-color: #2f4050;
    color: #ffffff;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

header h1 {
    margin: 0;
    font-size: 24px;
    font-weight: bold;
}

.user-info {
    font-size: 14px;
}

.user-info a {
    margin-left: 15px;
    color: #ffffff;
    text-decoration: none;
}

.user-info a:hover {
    text-decoration: underline;
}

.main {
    padding: 30px;
}

.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a90e2;
    font-size: 14px;
    font-weight: bold;
    text-decoration: none;
}

.back-link a:hover {
    text-decoration: underline;
}

.title-area {
    margin-bottom: 25px;
    padding: 15px 20px;
    background-color: #ffffff;
    border-left: 6px solid #4a90e2;
    border-radius: 4px;
    font-size: 24px;
    font-weight: bold;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
}

.form-area {
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 8px;
    box-sizing: border-box;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.form-row {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.form-row label {
    width: 120px;
    margin-right: 15px;
    font-weight: bold;
    color: #444;
}

.form-row input {
    flex: 1;
    padding: 10px 12px;
    font-size: 14px;
    color: #333;
    border: 1px solid #cccccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.form-row input:focus {
    outline: none;
    border-color: #4a90e2;
    box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.15);
}

.form-row input[readonly] {
    background-color: #f8f9fa;
    color: #666666;
}

.error {
    margin-bottom: 20px;
    padding: 12px 15px;
    color: #d9534f;
    font-weight: bold;
    background-color: #fff2f2;
    border: 1px solid #f5c2c2;
    border-radius: 4px;
}

.button-area {
    margin-top: 30px;
    text-align: center;
}

.button-area input,
.button-area a {
    display: inline-block;
    min-width: 120px;
    padding: 10px 30px;
    margin: 0 10px;
    font-size: 14px;
    font-weight: bold;
    text-align: center;
    text-decoration: none;
    color: #333333;
    background-color: #f5f5f5;
    border: 1px solid #888888;
    border-radius: 4px;
    cursor: pointer;
    box-sizing: border-box;
    transition: background-color 0.2s ease;
}

.button-area input {
    color: #ffffff;
    background-color: #4a90e2;
    border-color: #4a90e2;
}

.button-area input:hover {
    background-color: #357abd;
}

.button-area a:hover {
    background-color: #e9e9e9;
}
</style>
</head>

<body>

<header>
    <h1>得点管理システム</h1>

    <div class="user-info">
        ${loginUser.name} 様
        <a href="${pageContext.request.contextPath}/action/Logout.action">
            ログアウト
        </a>
    </div>
</header>

<div class="main">

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/action/SubjectList.action">
            ← 科目一覧へ戻る
        </a>
    </div>

    <div class="title-area">
        科目変更
    </div>

    <div class="form-area">

        <c:if test="${not empty errorMessage}">
            <div class="error">
                ${errorMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/action/SubjectUpdateExecute.action"
              method="post">

            <input type="hidden" name="cd" value="${subject.cd}">

            <div class="form-row">
                <label>科目コード</label>
                <input type="text"
                       value="${subject.cd}"
                       readonly>
            </div>

            <div class="form-row">
                <label for="name">科目名</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${subject.name}"
                       maxlength="50"
                       required>
            </div>

            <div class="button-area">
                <input type="submit" value="変更">
                <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                    戻る
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>