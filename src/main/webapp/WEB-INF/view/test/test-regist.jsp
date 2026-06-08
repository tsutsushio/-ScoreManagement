<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績登録</title>

<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background-color: #f5f7fb;
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

/* メインエリア：この中でフォームを中央寄せにする */
.main-content {
    flex: 1;
    padding: 40px 20px;
    box-sizing: border-box;
    background-color: #f5f7fb;
    overflow-y: auto;   /* 検索結果テーブルなどで縦長になった場合は右側だけスクロール */
    
    /* フォームと戻るリンクを中央に集めるための設定 */
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 戻るリンク：カードの左端のライン（最大900px）に綺麗に揃える */
.back-link {
    display: inline-block;
    margin-bottom: 20px;
    text-decoration: none;
    color: #4a90e2;
    font-size: 14px;
    align-self: center; /* 親の中央寄せに追従させつつ、幅をカードと同期 */
    max-width: 900px;
    width: 100%;
}

.back-link:hover {
    text-decoration: underline;
}

/* 白いカード（クラス名競合防止のため .container から変更） */
.form-container {
    background: white;
    padding: 40px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 900px;
    box-sizing: border-box;
}

/* タイトル */
h2 {
    color: #4a90e2;
    margin-top: 0;
    margin-bottom: 25px;
    text-align: center;
    font-size: 24px;
}

/* ラベル */
label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
    font-size: 14px;
}

/* 入力フォーム */
input[type="text"],
input[type="number"],
select {
    width: 100%;
    padding: 10px;
    border: 1px solid #dce4ec;
    border-radius: 8px;
    box-sizing: border-box;
    font-size: 16px;
    background-color: #fff;
    transition: border-color 0.2s;
}

input:focus,
select:focus {
    outline: none;
    border-color: #66a3ff;
}

/* ボタン共通 */
button[type="submit"] {
    padding: 12px 20px;
    background: #66a3ff;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

button[type="submit"]:hover {
    background: #4d8cff;
}

/* ===== 検索結果エリア ===== */
.result-box {
    margin-top: 20px;
    background: #fff;
    border-radius: 16px;
    padding: 30px;
    box-sizing: border-box;
}

/* ===== 検索フォーム横並び ===== */
.search-form {
    display: flex;
    align-items: flex-end;
    gap: 16px;
    flex-wrap: wrap;
    position: relative;
    z-index: 10;
}

.search-item {
    flex: 1;
    min-width: 140px;
}

.search-button {
    display: flex;
    align-items: flex-end;
}

.search-button button {
    width: auto;
    margin: 0;
    height: 45px;
    white-space: nowrap;
}

/* ===== テーブル ===== */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background: white;
}

th {
    background-color: #66a3ff;
    color: white;
    padding: 12px;
}

td {
    border: 1px solid #dce4ec;
    padding: 10px;
    text-align: center;
}

td input[type="number"] {
    width: 80px;
    margin: auto;
}

/* 登録ボタン中央 */
.register-btn {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.register-btn button {
    width: 250px;
}

/* 0件メッセージ */
.no-result {
    text-align: center;
    color: #666;
    font-size: 25px;
    padding: 24px 0;
    margin: 0;
}

/* 🌟 エラーメッセージのスタイル */
.error-msg {
    color: #e74c3c;
    background-color: #fdf0ed;
    border: 1px solid #e74c3c;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-weight: bold;
    text-align: center;
}

.result-box {
    position: relative;
    z-index: 1;
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <a href="${pageContext.request.contextPath}/action/Menu.action" class="back-link">
            ← メニューへ戻る
        </a>

        <div class="form-container">

            <h2>成績登録</h2>

            <form action="TestSearch.action" method="post" class="search-form">

                <div class="search-item">
                    <label>入学年度</label>
                    <select name="entYear" required>
                        <option value="">--選択--</option>
                        <c:forEach var="year" items="${entYearList}">
                            <option value="${year}" <c:if test="${year == fEntYear}">selected</c:if>>
                                ${year}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="search-item">
                    <label>クラス</label>
                    <select name="classNum" required>
                        <option value="">--選択--</option>
                        <c:forEach var="cNum" items="${classList}">
                            <option value="${cNum}" <c:if test="${cNum == fClassNum}">selected</c:if>>
                                ${cNum}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="search-item">
                    <label>科目</label>
                    <select name="subjectCd" required>
                        <option value="">--選択--</option>
                        <c:forEach var="subject" items="${subjectList}">
                            <option value="${subject.cd}" <c:if test="${subject.cd == fSubjectCd}">selected</c:if>>
                                ${subject.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="search-item">
                    <label>回数</label>
                    <input type="number" name="no" min="1" required value="${fNo}">
                </div>

                <div class="search-button">
                    <button type="submit">検索</button>
                </div>

            </form>

            <%-- 検索結果が存在する場合のリスト表示 --%>
            <c:if test="${not empty testList}">
                <div class="result-box">
                    <h2>検索結果</h2>

                    <c:if test="${not empty errors.point}">
                        <div class="error-msg">
                            ${errors.point}
                        </div>
                    </c:if>

                    <form action="TestRegistExecute.action" method="post">
                        <table>
                            <tr>
                                <th>入学年度</th>
                                <th>クラス</th>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th>点数</th>
                            </tr>

                            <c:forEach var="test" items="${testList}">
                                <tr>
                                    <td>${test.student.entYear}</td>
                                    <td>${test.classNum}</td>
                                    <td>${test.student.no}</td>
                                    <td>${test.student.name}</td>
                                    <td>
                                        <input type="number" name="point_${test.student.no}" value="${test.point}" min="0" max="100">
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>

                        <input type="hidden" name="subjectCd" value="${fSubjectCd}">
                        <input type="hidden" name="no" value="${fNo}">
                        <input type="hidden" name="classNum" value="${fClassNum}">

                        <div class="register-btn">
                            <button type="submit">登録して終了</button>
                        </div>
                    </form>
                </div>
            </c:if>

            <%-- 検索は走ったが該当者が0件だった場合のメッセージ表示 --%>
            <c:if test="${testList != null and empty testList}">
                <div class="result-box">
                    <h2>検索結果</h2>
                    <p class="no-result">該当者がいません</p>
                </div>
            </c:if>

        </div> </div> </div> </body>
</html>