<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - エラー解決情報</title>

<style>

/* =========================
   全体
========================= */

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


/* =========================
   メインコンテナ
========================= */

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


/* =========================
   見出し
========================= */

.main-content h2 {
    font-size: 22px;
    font-weight: 500;
    letter-spacing: 0.05em;
    background-color: transparent;
    padding: 0 0 15px 0;
    margin: 0 0 35px 0;
    color: #2c5234;
    border-bottom: 2px solid #e8ece9;
}


/* =========================
   検索エリア
========================= */

.search-container {
    background: #ffffff;
    border-radius: 12px;
    padding: 25px 30px;
    margin-bottom: 25px;
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06);
}

.search-form {
    display: flex;
    align-items: center;
    gap: 12px;
}

.search-label {
    font-size: 13px;
    font-weight: 600;
    color: #8a958f;
}

.search-form select {
    width: 250px;
    height: 40px;
    padding: 0 12px;
    border: 1px solid transparent;
    border-radius: 8px;
    background-color: #f1f3f1;
    color: #2b2d42;
    font-size: 14px;
    outline: none;
}

.search-form select:focus {
    background-color: #ffffff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

.search-button {
    height: 40px;
    padding: 0 24px;
    background-color: #4a7c59;
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 14px;
    cursor: pointer;
}

.search-button:hover {
    background-color: #3b6347;
}


/* =========================
   投稿ボタン
========================= */

.create-wrapper {
    margin-bottom: 20px;
    text-align: right;
}

.create-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 40px;
    padding: 0 24px;
    background-color: #4a7c59;
    color: #ffffff;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.2s ease;
}

.create-link:hover {
    background-color: #3b6347;
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2);
}


/* =========================
   エラー一覧
========================= */

.error-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}


/* =========================
   エラーカード
========================= */

.error-card {
    background-color: #ffffff;
    border-radius: 12px;
    padding: 28px 32px;
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06);
}


/* 科目名 */

.error-subject {
    font-size: 13px;
    font-weight: 600;
    color: #4a7c59;
    margin-bottom: 10px;
}


/* エラータイトル */

.error-card h3 {
    margin: 0 0 25px 0;
    font-size: 18px;
    font-weight: 500;
    color: #2b2d42;
}


/* エラー内容・解決方法 */

.error-section {
    margin-top: 20px;
}


/* ラベル */

.error-label {
    font-size: 12px;
    font-weight: 600;
    color: #8a958f;
    margin-bottom: 8px;
}


/* 本文 */

.error-text,
.solution-text {
    font-size: 14px;
    line-height: 1.8;
    color: #2b2d42;
    white-space: normal;
    word-break: break-word;
}


/* データなし */

.no-data {
    background-color: #ffffff;
    border-radius: 12px;
    padding: 40px;
    text-align: center;
    color: #8a958f;
}




/* =========================
   データがない場合
========================= */

.no-data {
    text-align: center;
    padding: 40px;
    color: #8a958f;
    background-color: #ffffff;
}

</style>
</head>

<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>エラー解決情報</h2>


        <!-- =========================
             科目検索
        ========================== -->

        <div class="search-container">

            <form action="${pageContext.request.contextPath}/action/ErrorList.action"
                  method="get"
                  class="search-form">

                <label class="search-label" for="subjectCd">
                    科目
                </label>

                <select id="subjectCd" name="subjectCd">

                    <option value="">
                        すべての科目
                    </option>

                    <c:forEach var="subject" items="${subjectList}">

                        <option value="${subject.cd}"
                            <c:if test="${subject.cd == selectedSubjectCd}">
                                selected
                            </c:if>
                        >
                            ${subject.name}
                        </option>

                    </c:forEach>

                </select>

                <button type="submit" class="search-button">
                    検索
                </button>

            </form>

        </div>


        <!-- =========================
             エラー投稿ボタン
        ========================== -->

        <div class="create-wrapper">

            <a href="${pageContext.request.contextPath}/action/ErrorPostCreate.action"
               class="create-link">

                エラーを投稿

            </a>

        </div>


        <!-- =========================
             エラー一覧
        ========================== -->

            <div class="error-list">

            <c:if test="${not empty errorList}">

                <c:forEach var="error" items="${errorList}">

                    <div class="error-card">

                        <!-- 科目名 -->
                        <div class="error-subject">
                            <c:out value="${error.subjectName}"/>
                        </div>

                        <!-- エラータイトル -->
                        <h3>
                            <c:out value="${error.title}"/>
                        </h3>

                        <!-- エラー内容 -->
                        <div class="error-section">

                            <div class="error-label">
                                エラー内容
                            </div>

                            <div class="error-text">
                               <c:out value="${error.content}"/>
                            </div>

                         </div>

                        <!-- 解決方法 -->
                        <div class="error-section">

                            <div class="error-label">
                                解決方法
                            </div>

                            <div class="solution-text">
                                <c:out value="${error.solution}"/>
                            </div>

                        </div>

                    </div>
  
                </c:forEach>

            </c:if>


            <c:if test="${empty errorList}">

                <div class="no-data">
                    現在、投稿されているエラー情報はありません。
                </div>
 
            </c:if>

        </div>

    </div>

</div>

<%@ include file="/footer.jsp" %>

</body>
</html>