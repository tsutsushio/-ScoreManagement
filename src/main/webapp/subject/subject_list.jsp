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
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;
    color: #333;
}

header {
    background: #fff;
    padding: 15px 30px;
    border-bottom: 1px solid #ddd;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

header h1 {
    margin: 0;
    color: #4a7bd8;
    font-size: 28px;
}

.main {
    max-width: 1300px;
    margin: 40px auto;
    padding: 0 20px;
}

.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
}

.back-link a:hover {
    text-decoration: underline;
}

h2 {
    margin: 0 0 25px;
    padding: 14px 20px;
    background: #fff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 28px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.content {
    display: flex;
    gap: 20px;
}

.sidebar {
    width: 220px;
    background: #fff;
    border-radius: 14px;
    padding: 20px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    height: fit-content;
}

.sidebar ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.sidebar > ul > li:first-child {
    font-size: 18px;
    color: #4a7bd8;
    margin-bottom: 15px;
    border-bottom: 2px solid #e6eefc;
    padding-bottom: 10px;
}

.sidebar > ul > li {
    margin-bottom: 15px;
    font-weight: bold;
}

.sub-menu {
    margin-top: 8px;
    margin-left: 15px;
}

.sub-menu li {
    margin: 8px 0;
    font-weight: normal;
}

.sub-menu a {
    color: #4a7bd8;
    text-decoration: none;
}

.sub-menu a:hover {
    text-decoration: underline;
}

.list-box {
    flex: 1;
    background: #fff;
    padding: 24px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

.create-link {
    float: right;
    margin-bottom: 15px;
    padding: 9px 20px;
    background-color: #6ea8ff;
    color: #fff;
    border: 2px solid #2f5fb8;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
}

.create-link:hover {
    background-color: #4a7bd8;
}

table {
    width: 100%;
    border-collapse: collapse;
    clear: both;
}

thead {
    background: linear-gradient(135deg,#6ea8ff,#4a7bd8);
    color: #fff;
}

th {
    padding: 14px 10px;
}

td {
    padding: 14px 10px;
    text-align: center;
    border-bottom: 1px solid #eee;
}

tbody tr:nth-child(even) {
    background-color: #f8fbff;
}

tbody tr:hover {
    background-color: #eef5ff;
}

.action a {
    color: #4a7bd8;
    font-weight: bold;
    text-decoration: none;
}

.action:last-child a {
    color: #d9534f;
}
</style>
</head>

<body>

<header>
    <h1>得点管理システム</h1>
</header>

<div class="main">

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/action/Menu.action">
            ← メインメニューへ戻る
        </a>
    </div>

    <h2>科目管理</h2>

    <div class="content">

        <div class="sidebar">
            <ul>
                <li>メニュー</li>

                <li>
                    学生管理
                    <ul class="sub-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/action/StudentList.action">
                                学生一覧
                            </a>
                        </li>
                    </ul>
                </li>

                <li>
                    成績管理
                    <ul class="sub-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/action/TestRegist.action">
                                成績登録
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/action/TestList.action">
                                成績参照
                            </a>
                        </li>
                    </ul>
                </li>

                <li>
                    科目管理
                    <ul class="sub-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                                科目一覧
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>

        <div class="list-box">

            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action"
               class="create-link">
                新規登録
            </a>

            <table>
                <thead>
                    <tr>
                        <th>科目コード</th>
                        <th>科目名</th>
                        <th>変更</th>
                        <th>削除</th>
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

</div>

</body>
</html>