<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - エラー情報投稿</title>

<style>

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                 Roboto, "Helvetica Neue", Arial,
                 "Yu Gothic Medium", sans-serif;
    background-color: #fafbfc;
    color: #2b2d42;
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
    padding: 40px 60px;
    box-sizing: border-box;
}

.main-content h2 {
    font-size: 22px;
    font-weight: 500;
    letter-spacing: 0.05em;
    padding: 0 0 15px 0;
    margin: 0 0 35px 0;
    color: #2c5234;
    border-bottom: 2px solid #e8ece9;
}

.form-container {
    max-width: 800px;
    width: 100%;
    background: #ffffff;
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06);
    box-sizing: border-box;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-bottom: 25px;
}

.form-group label {
    font-size: 11px;
    color: #8a958f;
    font-weight: 600;
    letter-spacing: 0.05em;
}

.form-group input[type="text"],
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 10px 14px;
    border: 1px solid transparent;
    border-radius: 8px;
    font-size: 14px;
    background-color: #f1f3f1;
    color: #2b2d42;
    outline: none;
    box-sizing: border-box;
    transition: all 0.25s ease;
}

.form-group input[type="text"],
.form-group select {
    height: 40px;
}

.form-group textarea {
    min-height: 140px;
    resize: vertical;
}

.form-group input[type="text"]:focus,
.form-group select:focus,
.form-group textarea:focus {
    background-color: #fff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

.btn-submit {
    height: 40px;
    padding: 0 28px;
    background-color: #4a7c59;
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    margin-bottom: 20px;
}

.btn-submit:hover {
    background-color: #3b6347;
}

.back-link-box {
    margin-top: 10px;
}

.back-link {
    color: #8a958f;
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
}

.back-link:hover {
    color: #4a7c59;
}

</style>
</head>

<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>エラー情報投稿</h2>

        <div class="form-container">

            <form action="${pageContext.request.contextPath}/action/ErrorPostCreateExecute.action"
                  method="post">

                <!-- 科目 -->
                <div class="form-group">

                    <label for="subjectCd">科目</label>

                    <select id="subjectCd" name="subjectCd" required>

                        <option value="">
                            科目を選択してください
                        </option>

                        <c:forEach var="subject" items="${subjectList}">

                            <option value="${subject.cd}">
                                ${subject.name}
                            </option>

                        </c:forEach>

                    </select>

                </div>


                <!-- エラータイトル -->
                <div class="form-group">

                    <label for="title">エラータイトル</label>

                    <input type="text"
                           id="title"
                           name="title"
                           placeholder="エラータイトルを入力してください"
                           required>

                </div>


                <!-- エラー内容 -->
                <div class="form-group">

                    <label for="content">エラー内容</label>

                    <textarea id="content"
                              name="content"
                              placeholder="発生したエラーの内容を入力してください"
                              required></textarea>

                </div>


                <!-- 解決方法 -->
                <div class="form-group">

                    <label for="solution">エラーの解決方法</label>

                    <textarea id="solution"
                              name="solution"
                              placeholder="エラーの解決方法を入力してください"
                              required></textarea>

                </div>


                <button type="submit" class="btn-submit">
                    登録
                </button>

            </form>


            <div class="back-link-box">

                <a href="${pageContext.request.contextPath}/action/ErrorList.action"
                   class="back-link">
                    戻る
                </a>

            </div>

        </div>

    </div>

</div>

<%@ include file="/footer.jsp" %>

</body>
</html>