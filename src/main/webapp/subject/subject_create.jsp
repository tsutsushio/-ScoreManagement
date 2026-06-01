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
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;
    color: #333;
}

.main {
    max-width: 900px;
    margin: 40px auto;
    padding: 0 20px;
}

.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
}

.back-link a:hover {
    color: #2f5fb8;
    text-decoration: underline;
}

.title-area {
    margin-bottom: 25px;
    padding: 14px 20px;
    background: #ffffff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 28px;
    font-weight: bold;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.form-area {
    max-width: 600px;
    margin: 0 auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
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
    color: #444;
}

.form-row input[type="text"] {
    flex: 1;
    padding: 10px 14px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    box-sizing: border-box;
    transition: 0.2s;
}

.form-row input[type="text"]:focus {
    outline: none;
    border-color: #6ea8ff;
    box-shadow: 0 0 0 3px rgba(110,168,255,0.2);
}

.error {
    background: #ffe5e5;
    color: #d33;
    border-left: 5px solid #ff6b6b;
    padding: 14px 18px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-weight: bold;
}

.button-area {
    text-align: center;
    margin-top: 30px;
}

.button-area input[type="submit"] {
    padding: 10px 24px;
    border: none;
    border-radius: 8px;
    background: linear-gradient(135deg, #6ea8ff, #4a7bd8);
    color: #fff;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

.button-area input[type="submit"]:hover {
    box-shadow: 0 4px 10px rgba(74,123,216,0.35);
}

.button-area a {
    display: inline-block;
    margin-left: 10px;
    padding: 10px 24px;
    border: 1px solid #6ea8ff;
    border-radius: 8px;
    background: #f0f6ff;
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
    transition: 0.2s;
}

.button-area a:hover {
    background: #6ea8ff;
    color: #fff;
}

@media screen and (max-width: 768px) {

    .form-row {
        flex-direction: column;
        align-items: stretch;
    }

    .form-row label {
        width: auto;
        margin-bottom: 8px;
    }

    .form-area {
        width: 100%;
    }
}
</style>
</head>

<body>

<header>
    <h1>得点管理システム</h1>

</header>

<div class="main">


    <!-- 左上の戻るリンク -->
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

            <div class="form-row">
                <label for="cd">科目コード</label>
                <input type="text"
                       id="cd"
                       name="cd"
                       value="${cd}"
                       maxlength="3"
                       required>
            </div>

            <div class="form-row">
                <label for="name">科目名</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${name}"
                       maxlength="20"
                       required>
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