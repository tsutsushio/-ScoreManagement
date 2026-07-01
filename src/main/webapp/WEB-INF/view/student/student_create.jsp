<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報登録</title>

<style>
    /* 全体レイアウト：画面の残りの高さをすべて使う基礎構造 */
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

    /* 左側サイドバーから独立した、右側メインエリア */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
        box-sizing: border-box;
    }

    /* 見出し「学生情報登録」（グレーの帯） */
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
        color: #666;
        font-weight: bold;
    }

    /* 入力欄（テキスト・セレクト共通の見た目） */
    .form-group input[type="text"],
    .form-group input[type="password"],
    .form-group select {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
        background-color: #ffffff;
        color: #333;
    }

    /* プレースホルダーの色調整 */
    .form-group input::placeholder {
        color: #aaa;
    }

    /* 「登録して終了」ボタン（グレーの四角ボタン仕様） */
    .btn-submit {
        background-color: #6c757d;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        padding: 10px 24px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        margin-bottom: 15px;
        transition: background-color 0.2s;
    }
    .btn-submit:hover {
        background-color: #5a6268;
    }

    /* 「戻る」リンク（ボタンの下の青文字下線） */
    .back-link-box {
        margin-top: 5px;
    }
    .back-link {
        color: #0066ff;
        font-size: 14px;
        text-decoration: underline;
    }
    .back-link:hover {
        color: #0044cc;
    }

    /* エラーメッセージ（バリデーション赤文字） */
    .error-msg {
        color: #d9534f;
        font-size: 13px;
        margin-top: 4px;
        font-weight: bold;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>学生情報登録</h2>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/action/StudentCreateExecute.action" method="post">
                
                <div class="form-group">
                    <label>入学年度</label>
                    <select name="entYear">
                        <option value="0">--------</option>
                        <c:forEach var="year" items="${entYearList}">
                            <option value="${year}" ${entYear == year ? 'selected' : ''}>${year}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty errors.entYear}">
                        <div class="error-msg">${errors.entYear}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="no" value="${no}" placeholder="学生番号を入力してください" required>
                    <c:if test="${not empty errors.no}">
                        <div class="error-msg">${errors.no}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="${name}" placeholder="氏名を入力してください" required>
                    <c:if test="${not empty errors.name}">
                        <div class="error-msg">${errors.name}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>クラス</label>
                    <select name="classNum">
                        <c:forEach var="c" items="${classList}">
                            <option value="${c}" ${classNum == c ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>パスワード</label>
                    <input type="password" name="password" placeholder="パスワードを入力してください（必要な場合）">
                    <c:if test="${not empty errors.password}">
                        <div class="error-msg">${errors.password}</div>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">登録して終了</button>
            </form>
            
            <div class="back-link-box">
                <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">戻る</a>
            </div>
        </div>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>