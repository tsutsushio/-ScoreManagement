<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目変更</title>

<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #ffffff; /* 画像に合わせて背景を白に */
    color: #333;
}

body {
    display: flex;
    flex-direction: column; /* 上からヘッダー、コンテンツの順 */
}

/* 全体レイアウト（サイドバーとメインコンテンツの横並びコンテナ） */
.container {
    display: flex;
    flex: 1;            /* 画面の残りの高さをすべて使う */
    width: 100%;
    align-items: stretch;
}

/* メインエリア：この中でフォームを配置する */
.main-content {
    flex: 1;
    padding: 20px 40px;
    box-sizing: border-box;
    background-color: #ffffff;
}

/* タイトルエリア（①） */
.main-content h2 {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 12px 15px;
    background-color: #f2f2f2; /* 画像の薄いグレー */
    color: #333;
    font-size: 24px;
    font-weight: bold;
}

/* フォーム全体の最大幅設定 */
.form-container {
    max-width: 800px;
    width: 100%;
}

/* 各入力項目の行設定 */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 6px;
    margin-bottom: 20px;
}

/* ラベル（②、④） */
.form-group label {
    font-size: 14px;
    color: #333;
    font-weight: normal; /* 太字を解除 */
}

/* 科目コードの表示テキスト（③） */
.static-text {
    font-size: 14px;
    color: #333;
    padding: 4px 0;      /* テキスト位置の微調整用 */
}

/* 科目名の入力フォーム（⑤） */
.form-group input[type="text"] {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 4px; /* 緩やかな角丸 */
    font-size: 14px;
    box-sizing: border-box;
}

.form-group input[type="text"]:focus {
    outline: none;
    border-color: #007bff; /* フォーカス時の青枠 */
}

/* 変更ボタン（⑥） */
.btn-submit {
    background-color: #007bff; /* 画像と同じ鮮やかな青 */
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

/* 戻るリンクの位置（⑦） */
.back-link-box {
    margin-top: 5px;
}

/* 戻るリンクの装飾（⑦） */
.back-link {
    color: #007bff;
    font-size: 14px;
    text-decoration: underline;
}

.back-link:hover {
    color: #0056b3;
    text-decoration: none;
}

/* 科目名エラーメッセージ用赤文字 */
.error-msg {
    color: #ff0000;
    font-size: 14px;
    margin-top: 4px;
    font-weight: normal;
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <!-- タイトル（①） -->
        <h2>科目情報変更</h2>

        <div class="form-container">

            <form action="${pageContext.request.contextPath}/action/SubjectUpdateExecute.action" method="post">

                <!-- サーバーにCDを送るための隠しパラメータ -->
                <input type="hidden" name="cd" value="${subject.cd}">

                <!-- 科目コード行（②、③） -->
                <div class="form-group">
                    <label>科目コード</label>
                    <!-- 画像に合わせてinputタグからただのテキスト表示に変更 -->
                    <div class="static-text">${subject.cd}</div>
                </div>

                <!-- 科目名行（④、⑤） -->
                <div class="form-group">
                    <label for="name">科目名</label>
                    <!-- 入力文字数オーバー対応のためmaxlengthを削除、または大きめに設定 -->
                    <input type="text" id="name" name="name" value="${subject.name}" required>
                    
                    <!-- エラーメッセージを科目名のすぐ下に配置 -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-msg">
                            ${errorMessage}
                        </div>
                    </c:if>
                </div>

                <!-- 変更ボタン（⑥） -->
                <button type="submit" class="btn-submit">変更</button>

            </form>

            <!-- 戻るリンク（⑦） -->
            <div class="back-link-box">
                <a href="${pageContext.request.contextPath}/action/SubjectList.action" class="back-link">戻る</a>
            </div>

        </div>

    </div>

</div>

<%@ include file="/footer.jsp" %>

</body>
</html>
