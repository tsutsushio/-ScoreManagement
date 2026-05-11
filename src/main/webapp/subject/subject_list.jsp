<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目管理</title>

<style>
body {
    margin: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f6f9;
}

/* ヘッダー */
header {
    background-color: #2f4050;
    color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

header h1 {
    margin: 0;
    font-size: 24px;
}

.user-info {
    font-size: 14px;
}

.user-info a {
    color: #fff;
    margin-left: 15px;
    text-decoration: none;
}

.user-info a:hover {
    text-decoration: underline;
}

/* メイン部分 */
.main {
    padding: 30px;
}

/* 戻るリンク */
.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a90e2;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

.back-link a:hover {
    text-decoration: underline;
}

/* タイトル */
.title-area {
    background-color: #ffffff;
    border-left: 6px solid #4a90e2;
    padding: 15px 20px;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 25px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

/* 一覧部分 */
.table-area {
    background-color: #fff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

/* 新規登録リンク */
.new-link {
    text-align: right;
    margin-bottom: 15px;
}

.new-link a {
    display: inline-block;
    background-color: #4a90e2;
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
    font-size: 14px;
}

.new-link a:hover {
    background-color: #357abd;
}

/* テーブル */
table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background-color: #eef3f8;
    color: #333;
    padding: 12px;
    border-bottom: 2px solid #d5dce5;
    text-align: left;
}

td {
    padding: 12px;
    border-bottom: 1px solid #e0e0e0;
}

tr:hover {
    background-color: #f8fbff;
}

.action {
    width: 80px;
    text-align: center;
}

.action a {
    color: #4a90e2;
    text-decoration: none;
    font-weight: bold;
}

.action a:hover {
    text-decoration: underline;
}

.action:last-child a {
    color: #d9534f;
}
</style>
</head>

<body>

<header>
    <h1>得点管理システム</h1>

    <div class="user-info">
        ${loginUser.name} 様
        <a href="${pageContext.request.contextPath}/action/Logout.action">
            ログアウト
        </a>
    </div>
</header>

<div class="main">

    <!-- 左上の戻るリンク -->
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/action/Menu.action">
            ← メインメニューへ戻る
        </a>
    </div>

    <!-- タイトル -->
    <div class="title-area">
        科目管理
    </div>

    <!-- 一覧表示エリア -->
    <div class="table-area">

        <!-- 新規登録 -->
        <div class="new-link">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action">
                新規登録
            </a>
        </div>

        <!-- 科目一覧テーブル -->
        <table>
            <thead>
                <tr>
                    <th>科目コード</th>
                    <th>科目名</th>
                    <th class="action"></th>
                    <th class="action"></th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="subject" items="${subjectList}">
                    <tr>
                        <td>${subject.cd}</td>
                        <td>${subject.name}</td>

                        <td class="action">
                            <a href="${pageContext.request.contextPath}/action/SubjectUpdate.action?cd=${subject.cd}">
                                変更
                            </a>
                        </td>

                        <td class="action">
                            <a href="${pageContext.request.contextPath}/action/SubjectDelete.action?cd=${subject.cd}"
                               onclick="return confirm('削除しますか？');">
                                削除
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </div>
</div>

</body>
</html>