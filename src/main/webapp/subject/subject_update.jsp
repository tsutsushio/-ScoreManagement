<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目変更</title>

<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;
}

.container {
    display: flex;
    min-height: 100vh;
}

.main-content {
    flex: 1;
    padding: 40px 20px;
    background-color: #f4f7fb;
    display: flex;
    justify-content: center;
}

.content-wrapper {
    width: 100%;
    max-width: 600px;
}

.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
}

.title-area {
    margin-bottom: 25px;
    padding: 14px 20px;
    background: #ffffff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 24px;
    font-weight: bold;
}

.form-area {
    background: #ffffff;
    padding: 30px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
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
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
}

.form-row input[readonly] {
    background-color: #f1f3f5;
}

.error {
    background: #ffe5e5;
    color: #d33;
    padding: 12px;
    margin-bottom: 20px;
    border-left: 5px solid #ff6b6b;
}

.button-area {
    text-align: center;
    margin-top: 30px;
}

.button-area input[type="submit"] {
    padding: 10px 24px;
}

.button-area a {
    margin-left: 10px;
    text-decoration: none;
}
</style>
</head>

<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="content-wrapper">

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

    </div>

</div>

</body>
</html>