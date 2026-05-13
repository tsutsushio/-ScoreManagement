
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>科目新規登録</title>
<style>
    body {
        font-family: sans-serif;
        background: #fff;
        margin: 0;
    }

    .title-area {
        background: #e5e5e5;
        padding: 12px 20px;
        font-size: 24px;
        font-weight: bold;
    }

    .form-area {
        width: 600px;
        margin: 30px auto;
        border: 1px solid #ccc;
        padding: 30px;
        box-sizing: border-box;
    }

    .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    .form-row label {
        width: 120px;
        font-weight: bold;
    }

    .form-row input {
        flex: 1;
        padding: 8px;
        font-size: 14px;
    }

    .error {
        color: red;
        margin-bottom: 20px;
    }

    .button-area {
        text-align: center;
        margin-top: 30px;
    }

    .button-area input,
    .button-area a {
        display: inline-block;
        padding: 10px 30px;
        margin: 0 10px;
        font-size: 14px;
        text-decoration: none;
        border: 1px solid #888;
        background: #f5f5f5;
        color: #000;
        cursor: pointer;
    }
</style>
</head>
<body>

    <div class="title-area">
        科目新規登録
    </div>

    <div class="form-area">

        <c:if test="${not empty errorMessage}">
            <div class="error">
                ${errorMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.java" method="post">

            <div class="form-row">
                <label for="cd">科目コード</label>
                <input type="text" id="cd" name="cd" value="${cd}" maxlength="3" required>
            </div>

            <div class="form-row">
                <label for="name">科目名</label>
                <input type="text" id="name" name="name" value="${name}" maxlength="50" required>
            </div>

            <div class="button-area">
                <input type="submit" value="登録">

                <a href="${pageContext.request.contextPath}/action/SubjectList.java">
                    戻る
                </a>
            </div>

        </form>
    </div>

</body>
</html>
