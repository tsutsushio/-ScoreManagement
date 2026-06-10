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
    padding: 12px 15px;
    background-color: #f2f2f2;
    color: #333;
    font-size: 24px;
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
    font-size: 14px;
    color: #333;
    font-weight: normal;
}

.form-group input[type="text"] {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
}

.form-group input[type="text"]:focus {
    outline: none;
    border-color: #007bff;
}

.form-group input::placeholder {
    color: #aaa;
}

.btn-submit {
    background-color: #007bff;
    color: #ffffff;
    border: none;
    border-radius: 4px;
    padding: 8px 16px;
    font-size: 14px;
    font-weight: normal;
    cursor: pointer;
    margin-bottom: 15px;
}

.btn-submit:hover {
    background-color: #0056b3;
}

.back-link-box {
    margin-top: 5px;
}

.back-link {
    color: #007bff;
    font-size: 14px;
    text-decoration: underline;
}

.back-link:hover {
    color: #0056b3;
    text-decoration: none;
}

.error-msg {
    color: #ff0000;
    font-size: 14px;
    margin-top: 4px;
    font-weight: normal;
    background: none;
    border-left: none;
    padding: 0;
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

            <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.action" method="post">

                <div class="form-group">
                    <label for="cd">科目コード</label>
                    <!-- maxlength="3" を削除 -->
                    <input type="text" id="cd" name="cd"
                           value="${cd}"
                           placeholder="科目コードを入力してください"
                           required>
                    
                    <!-- メッセージに「コード」または「重複」が含まれる場合は科目コードの下に表示 -->
                    <c:if test="${not empty errorMessage and (errorMessage.contains('コード') or errorMessage.contains('重複'))}">
                        <div class="error-msg">
                            ${errorMessage}
                        </div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="name">科目名</label>
                    <!-- maxlength="20" を削除 -->
                    <input type="text" id="name" name="name"
                           value="${name}"
                           placeholder="科目名を入力してください"
                           required>
                    
                    <!-- メッセージに「科目名」が含まれる場合は科目名の下に表示 -->
                    <c:if test="${not empty errorMessage and errorMessage.contains('科目名')}">
                        <div class="error-msg">
                            ${errorMessage}
                        </div>
                    </c:if>
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
