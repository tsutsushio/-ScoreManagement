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
    background-color: #ffffff; /* 💡 背景を白にしてよりシンプルに */
    display: flex;
    justify-content: center;
}

.content-wrapper {
    width: 100%;
    max-width: 600px;
}

/* 💡 戻るリンクを画像のようなシンプルな青文字に */
.back-link {
    margin-bottom: 20px;
}
.back-link a {
    color: #007bff;
    text-decoration: none;
    font-size: 14px;
}
.back-link a:hover {
    text-decoration: underline;
}

/* 💡 タイトルエリアを画像①のようなシンプルなグレー背景に変更 */
.title-area {
    margin-bottom: 25px;
    padding: 12px 20px;
    background: #f1f3f5;
    border-radius: 4px;
    font-size: 20px;
    font-weight: bold;
    color: #333333;
}

/* 💡 外枠のシャドウや背景を無くして、極限までシンプルに */
.form-area {
    background: transparent;
    padding: 10px 0;
}

/* 💡 画像②④のように、ラベルと入力欄をゆったり配置 */
.form-row {
    margin-bottom: 24px;
}

.form-row label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #495057;
    font-size: 15px;
}

/* 💡 画像③⑤のような、すっきりした入力フォームのデザイン */
.form-row input[type="text"] {
    width: 100%;
    box-sizing: border-box;
    padding: 10px 14px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    font-size: 15px;
    background-color: #ffffff;
}

/* 💡 読み取り専用（科目コード）の背景を画像③のような薄いグレーに */
.form-row input[readonly] {
    background-color: #f8f9fa;
    color: #495057;
    border-color: #dee2e6;
}

/* 💡 ボタンエリアの配置を左寄せに変更 */
.button-area {
    text-align: left;
    margin-top: 30px;
}

/* 💡 画像⑥のような、パキッとした鮮やかな青色ボタン */
.button-area input[type="submit"] {
    background-color: #007bff;
    color: #ffffff;
    border: none;
    padding: 10px 24px;
    font-size: 15px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.2s;
}

.button-area input[type="submit"]:hover {
    background-color: #0056b3;
}

/* 💡 画像⑦のような、ボタンの下に配置するテキストリンクの「戻る」 */
.button-area a {
    display: block;
    margin-top: 15px;
    color: #007bff;
    text-decoration: none;
    font-size: 14px;
}

.button-area a:hover {
    text-decoration: underline;
}
</style>

</head>

<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="content-wrapper">

            <div class="title-area">
                科目情報変更
            </div>

                        <div class="form-area">

                <form action="${pageContext.request.contextPath}/action/SubjectUpdateExecute.action"
                      method="post">

                    <input type="hidden" name="cd" value="${subject.cd}">

                    <!-- 💡 科目コード部分 -->
                    <div class="form-row">
                        <label>科目コード</label>
                        <div style="flex: 1; display: flex; flex-direction: column;">
                            <input type="text" value="${subject.cd}" readonly>
                            
                            <!-- 科目コード用の個別エラー（重複など） -->
                            <c:if test="${not empty errorMessage and (errorMessage.contains('コード') or errorMessage.contains('重複'))}">
                                <div style="color: #ff0000; font-size: 0.85em; margin-top: 5px; font-weight: bold;">
                                    ${errorMessage}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 💡 科目名部分 -->
                    <div class="form-row">
                        <label for="name">科目名</label>
                        <div style="flex: 1; display: flex; flex-direction: column;">
                            <input type="text"
                                   id="name"
                                   name="name"
                                   value="${subject.name}"
                                   placeholder="科目名を入力してください"
                                   required>
                                   
                            <!-- 科目名用の個別エラー（20文字オーバーなど） -->
                            <c:if test="${not empty errorMessage and errorMessage.contains('科目名')}">
                                <div style="color: #ff0000; font-size: 0.85em; margin-top: 5px; font-weight: bold;">
                                    ${errorMessage}
                                </div>
                            </c:if>
                        </div>
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