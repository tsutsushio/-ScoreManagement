<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績編集</title>

<style>
    /* 全体レイアウト：他の画面と共通の縦幅いっぱいベース */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #ffffff;
    }

    body {
        display: flex;
        flex-direction: column; /* 上からヘッダー、コンテンツの順 */
    }

    /* メインコンテナ（サイドバーとコンテンツの並び） */
    .container {
        display: flex;
        flex: 1;
        width: 100%;
        align-items: stretch;
    }

    /* 右側メインエリア */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
        box-sizing: border-box;
    }

    /* ① 見出し「成績編集」（グレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 25px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        color: #333;
        font-size: 18px;
        font-weight: bold;
    }

    /* フォームコンテナ */
    .form-container {
        max-width: 800px;
        width: 100%;
    }

    /* 各入力項目の縦並びグループ設定 */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-bottom: 20px;
    }

    .form-group label {
        font-size: 13px;
        color: #333;
        font-weight: bold;
    }

    /* 入力欄（テキスト・数字・セレクト共通の見た目） */
    input[type="text"],
    input[type="number"],
    select {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
        background-color: #ffffff;
        color: #333;
    }

    /* 登録ボタン（共通の青いボタン仕様） */
    .btn-submit {
        background-color: #0066ff;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        padding: 8px 16px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        margin-bottom: 15px;
        transition: background-color 0.2s;
    }
    .btn-submit:hover {
        background-color: #0044cc;
    }

    /* エラーメッセージ（バリデーション赤文字） */
    .error-msg {
        color: #d9534f;
        font-size: 13px;
        margin-top: 4px;
        font-weight: bold;
    }
    
/* テーブルの偶数行（2, 4, 6行目...）の背景色を薄いグレーにする */
table tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* 【プロの小技】マウスを乗せた行の色を変えるとさらに分かりやすいです */
table tr:hover {
    background-color: #f0f5fa; /* ほんのり薄い青色 */
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>成績編集</h2>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/action/TestEditExecute.action" method="post">

                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="studentNo" value="${studentNo}" maxlength="10" required>
                    <div class="error-msg">${errors.studentNo}</div>
                </div>

                <div class="form-group">
                    <label>科目</label>
                    <select name="subjectCd" required>
                        <option value="">--選択--</option>
                        <c:forEach var="subject" items="${subjectList}">
                            <option value="${subject.cd}" <c:if test="${subject.cd == subjectCd}">selected</c:if>>
                                ${subject.name}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="error-msg">${errors.subjectCd}</div>
                </div>

                <div class="form-group">
                    <label>回数</label>
                    <input type="number" name="no" value="${no}" min="1" required>
                    <div class="error-msg">${errors.no}</div>
                </div>

                <div class="form-group">
                    <label>点数</label>
                    <input type="number" name="point" value="${point}" min="0" max="100" required>
                    <div class="error-msg">${errors.point}</div>
                </div>

                <div class="form-group">
                    <label>クラス番号</label>
                    <input type="text" name="classNum" value="${classNum}" maxlength="5" required>
                    <div class="error-msg">${errors.classNum}</div>
                </div>

                <button type="submit" class="btn-submit">更新する</button>
            </form>
        </div>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>