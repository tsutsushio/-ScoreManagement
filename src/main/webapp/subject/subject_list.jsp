<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目管理</title>

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

    /* ① 見出し「科目管理」（グレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 25px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        color: #333;
        font-size: 18px;
        font-weight: bold;
    }

    /* 新規登録リンク（右上に配置） */
    .create-wrapper {
        margin-bottom: 10px;
        text-align: right;
    }
    .create-link {
        color: #0066ff;
        font-size: 14px;
        text-decoration: underline;
    }

    /* テーブルスタイル（フラットデザイン） */
    .subject-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 5px;
    }
    .subject-table th {
        border-bottom: 2px solid #333;
        padding: 10px;
        text-align: left;
        font-size: 14px;
        color: #333;
    }
    .subject-table td {
        padding: 10px;
        font-size: 14px;
        color: #333;
        border-bottom: 1px solid #eee;
    }

    /* 操作リンク */
    .action-link {
        color: #0066ff;
        text-decoration: underline;
    }
    .delete-link {
        color: #d9534f;
        text-decoration: underline;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>科目管理</h2>

        <div class="create-wrapper">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action" class="create-link">新規登録</a>
        </div>

        <table class="subject-table">
            <thead>
                <tr>
                    <th>科目コード</th>
                    <th>科目名</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="subject" items="${subjectList}">
                    <tr>
                        <td><c:out value="${subject.cd}"/></td>
                        <td><c:out value="${subject.name}"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/action/SubjectUpdate.action?cd=${subject.cd}" class="action-link">
                                変更
                            </a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/action/SubjectDelete.action?cd=${subject.cd}"
                               onclick="return confirm('本当に削除しますか？');" class="delete-link">
                                削除
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>