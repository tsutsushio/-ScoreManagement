<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生一覧</title>

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

    /* メインコンテナ（サイドバーとコンテンツの横並び） */
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

    /* ① 見出し「学生管理」（グレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 25px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        color: #333;
        font-size: 18px;
        font-weight: bold;
    }

    /* 検索ボックスと登録リンクの親（リモート側の位置をキープ） */
    .search-wrapper {
        position: relative;
        margin-bottom: 20px;
        padding-top: 25px; /* 新規登録リンク用のスペース */
    }

    /* ⑧ 新規登録リンクの配置 */
    .create-link {
        position: absolute;
        top: 0;
        right: 0;
        color: #0066ff;
        font-size: 14px;
        text-decoration: underline;
    }

    /* 検索行（②〜⑦、⑨） */
    .search-row {
        display: flex;
        align-items: center;
        gap: 15px;
        background-color: #ffffff;
    }

    /* 入学年度・クラスの入力セット */
    .input-item {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    .input-item label {
        font-size: 12px;
        color: #666;
    }
    .input-item select {
        padding: 4px 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        min-width: 140px;
        background-color: #ffffff;
    }

    /* ⑥⑦ 在学中チェックボックス */
    .checkbox-label {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 13px;
        color: #333;
        margin-top: 18px; /* 入力欄のラベル分、下へ下げる */
        cursor: pointer;
    }

    /* ⑨ 絞込みボタン */
    .search-btn {
        background-color: #555555;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        padding: 6px 16px;
        font-size: 13px;
        cursor: pointer;
        margin-top: 18px; /* 入力欄のラベル分、下へ下げる */
        transition: background-color 0.2s;
    }
    .search-btn:hover {
        background-color: #333333;
    }

    /* ⑩ 検索結果件数テキスト */
    .result-count {
        font-size: 13px;
        color: #333;
        margin: 15px 0 10px 0;
    }

    /* ⑪ テーブルスタイル */
    .student-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    /* ⑫〜base ヘッダーセル */
    .student-table th {
        border-bottom: 2px solid #333;
        padding: 8px 10px;
        text-align: left;
        font-size: 14px;
        color: #333;
        font-weight: bold;
    }
    /* ⑰〜㉑ データセル */
    .student-table td {
        padding: 10px;
        font-size: 14px;
        color: #333;
        vertical-align: middle;
        border-bottom: 1px solid #eee;
    }
    /* ㉒ 変更リンク */
    .edit-link {
        color: #0066ff;
        text-decoration: underline;
    }
    .edit-link:hover {
        color: #003399;
    }

    /* ㉓ 該当データがない時のメッセージ */
    .error-message {
        font-size: 14px;
        color: #333;
        margin-top: 25px;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        
        <h2>学生管理</h2>

        <div class="search-wrapper">
            <a href="${pageContext.request.contextPath}/action/StudentCreate.action" class="create-link">新規登録</a>

            <form action="${pageContext.request.contextPath}/action/StudentList.action" method="post">
                <div class="search-row">

                    <div class="input-item">
                        <label>入学年度</label>
                        <select name="entYear">
                            <option value="0">--------</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                        </select>
                    </div>

                    <div class="input-item">
                        <label>クラス</label>
                        <select name="classNum">
                            <option value="--------">--------</option>
                            <option value="101">101</option>
                            <option value="102">102</option>
                            <option value="201">201</option>
                            <option value="202">202</option>
                        </select>
                    </div>

                    <label class="checkbox-label">
                        <input type="checkbox" name="isAttend" value="true">
                        在学中
                    </label>

                    <button type="submit" class="search-btn">絞込み</button>

                </div>
            </form>
        </div>

        <c:if test="${empty studentList}">
            <p class="error-message">学生情報が存在しませんでした</p>
        </c:if>

        <c:if test="${not empty studentList}">
            <p class="result-count">検索結果：${studentList.size()}件</p>

            <table class="student-table">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>クラス</th>
                        <th style="text-align: center;">在学中</th>
                        <th></th> </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${studentList}">
                        <tr>
                            <td>${student.entYear}</td>
                            <td>${student.no}</td>
                            <td><c:out value="${student.name}"/></td>
                            <td>${student.classNum}</td>
                            <td style="text-align: center;">
                                <c:choose>
                                    <c:when test="${student.isAttend}">〇</c:when>
                                    <c:otherwise>×</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a class="edit-link" href="${pageContext.request.contextPath}/action/StudentUpdate.action?no=${student.no}">
                                    変更
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>