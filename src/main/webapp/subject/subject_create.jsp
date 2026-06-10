<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目新規登録</title>

<style>
/* 画面全体で高さを100%に保ち、余計な隙間を消す */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", Meiryo, sans-serif;
    background-color: #ffffff;
    color: #333;
}

/* ヘッダー・メイン・フッターを縦並びにする設定 */
body {
    display: flex;
    flex-direction: column;
}

/* メインコンテンツエリア：残りの高さをすべて使い、上下に余白を作る */
.main {
    flex: 1;
    width: 100%;
    max-width: 800px; /* 横に広がりすぎないよう最大幅を設定して見やすく */
    margin: 0 auto;
    padding: 30px 20px; /* 上下に適度な余白 */
    box-sizing: border-box;
}

/* タイトルエリア（①） */
.title-area {
    margin-bottom: 25px;
    padding: 15px 20px;
    background: #f2f2f2;
    font-size: 22px;
    font-weight: bold;
    border-left: 4px solid #007bff; /* 左側に青のアクセントを入れて見やすく */
}

/* フォーム全体エリア（②〜⑥） */
.form-area {
    width: 100%;
    margin: 0;
    background: transparent;
    padding: 0;
    box-shadow: none;
    box-sizing: border-box;
}

/* 各入力項目の行設定 */
.form-row {
    display: block;
    margin-bottom: 20px; /* 項目間のスキマを少し広げて見やすく */
}

/* ラベル（②、④） */
.form-row label {
    display: block;
    width: auto;
    margin-bottom: 8px;
    font-size: 14px;
    color: #333;
    font-weight: bold; /* 文字を太くして視認性を向上 */
}

/* 入力フォーム（③、⑤） */
.form-row input[type="text"] {
    width: 100%;
    padding: 12px; /* パディングを少し広げて押しやすく */
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
    transition: border-color 0.2s; /* フォーカス時のアニメーション */
}

.form-row input[type="text"]:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.2); /* フォーカス時に薄い青の光を足して見やすく */
}

/* 個別エラーメッセージ（①、②の赤文字用） */
.error-msg {
    display: block;
    margin-top: 6px;
    color: #ff0000;
    font-size: 13px;
    font-weight: normal;
}

/* ボタンエリア（⑥） */
.button-area {
    text-align: left;
    margin-top: 25px;
    margin-bottom: 20px;
}

/* 登録ボタン（⑥） */
.button-area input[type="submit"] {
    padding: 10px 24px; /* ボタンを少し大きくして押しやすく */
    border: none;
    border-radius: 4px;
    background: #007bff;
    color: #fff;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.2s;
}

.button-area input[type="submit"]:hover {
    background: #0056b3;
}

/* 戻るリンク（⑦） */
.back-link {
    margin-top: 20px;
    text-align: left;
}

.back-link a {
    color: #007bff;
    text-decoration: underline;
    font-size: 14px;
    font-weight: normal;
}

.back-link a:hover {
    color: #0056b3;
    text-decoration: none;
}
</style>
</head>

<body>

<%@ include file="/header.jsp" %>

<div class="main">

    <!-- タイトル -->
    <div class="title-area">
        科目情報登録
    </div>

    <!-- フォーム -->
    <div class="form-area">

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
                       placeholder="科目コードを入力してください"
                       required>
                
                <!-- 科目コードに関するエラーがある場合に表示（文字数・重複など） -->
                <c:if test="${not empty cdError}">
                    <span class="error-msg">${cdError}</span>
                </c:if>
            </div>

            <div class="form-row">
                <label for="name">科目名</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${name}"
                       maxlength="20"
                       placeholder="科目名を入力してください"
                       required>
                
                <!-- 科目名に関するエラーがある場合に表示（必要な場合） -->
                <c:if test="${not empty nameError}">
                    <span class="error-msg">${nameError}</span>
                </c:if>
            </div>

            <!-- ボタン -->
            <div class="button-area">
                <input type="submit" value="登録">
            </div>

        </form>
    </div>

    <!-- 左下の戻るリンク（⑦） -->
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/action/SubjectList.action">
            戻る
        </a>
    </div>
</div>

<%@ include file="/footer.jsp" %>

</body>
</html>
