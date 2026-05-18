<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目新規登録</title>

<style>
body {
    margin: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f6f9;
}

header {
    background-color: #2f4050;
    color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

header h1 {
    margin: 0;
    font-size: 24px;
}

.user-info {
    font-size: 14px;
}

.user-info a {
    color: #fff;
    margin-left: 15px;
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
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

.back-link a:hover {
    text-decoration: underline;
}

.title-area {
    background-color: #ffffff;
    border-left: 6px solid #4a90e2;
    padding: 15px 20px;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 25px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

.form-area {
    width: 600px;
    margin: 0 auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
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
    border: 1px solid #ccc;
    border-radius: 4px;
}

.error {
    color: #d9534f;
    font-weight: bold;
    margin-bottom: 20px;
    padding: 10px;
    background-color: #fff2f2;
    border: 1px solid #f5c2c2;
    border-radius: 4px;
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
    border-radius: 4px;
    background-color: #f5f5f5;
    color: #000;
    cursor: pointer;
}

.button-area input:hover,
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

    <!-- 戻るリンク -->
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/action/SubjectList.action">
            ← 科目一覧へ戻る
        </a>
    </div>

    <!-- タイトル -->
    <div class="title-area">
        科目新規登録
    </div>

    <!-- フォーム -->
    <div class="form-area">

        <!-- エラーメッセージ -->
        <c:if test="${not empty errorMessage}">
            <div class="error">
                ${errorMessage}
            </div>
        </c:if>

        <!-- 登録フォーム -->
        <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.action"
              method="post">

            <!-- 科目コード -->
            <div class="form-row">
                <label for="cd">科目コード</label>
                <input type="text"
                       id="cd"
                       name="cd"
                       value="${cd}"
                       maxlength="3">
            </div>

            <!-- 科目名 -->
            <div class="form-row">
                <label for="name">科目名</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${name}"
                       maxlength="50">
            </div>

            <!-- ボタン -->
            <div class="button-area">
                <input type="submit" value="登録">

                <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                    戻る
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>
