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

/* ヘッダー全体のスタイリング調整 */
header {
    background-color: #fff;
    padding: 15px 30px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

header h1 {
    margin: 0;
    font-size: 22px;
    color: #333;
}

.main {
    max-width: 1100px;
    margin: 30px auto;
    padding: 0 20px;
}

.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
    display: inline-flex;
    align-items: center;
}

.back-link a:hover {
    color: #2f5fb8;
    text-decoration: underline;
}

h2 {
    margin: 0 0 25px;
    padding: 14px 20px;
    background: #fff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 24px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.list-box {
    background: #fff;
    padding: 24px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

/* floatを廃止し、タイトルとボタンの並びをFlexboxで制御するラッパー */
.list-header {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin-bottom: 20px;
}

.create-link {
    display: inline-block;
    padding: 10px 24px;
    background-color: #6ea8ff;
    color: #fff;
    border: 2px solid #2f5fb8;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
    transition: all 0.2s ease;
}

.create-link:hover {
    background-color: #4a7bd8;
    color: #fff;
    box-shadow: 0 4px 10px rgba(74,123,216,0.35);
    transform: translateY(-1px);
}

/* テーブルが画面からはみ出さないためのコンテナ */
.table-container {
    width: 100%;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead {
    background: linear-gradient(
        135deg,
        #6ea8ff,
        #4a7bd8
    );
    color: #fff;
}

th {
    padding: 16px 12px;
    font-size: 14px;
    font-weight: bold;
    letter-spacing: 0.5px;
}

/* コード類は中央、テキストは左寄せが見やすいため調整 */
td {
    padding: 16px 12px;
    border-bottom: 1px solid #eee;
    font-size: 14px;
}

.td-code {
    text-align: center;
    font-weight: 500;
}

.td-name {
    text-align: left;
}

tbody tr:nth-child(even) {
    background-color: #f8fbff;
}

tbody tr:hover {
    background-color: #eef5ff;
}

/* アクションボタンの幅を固定し、押しやすく調整 */
.action {
    width: 80px;
    text-align: center;
}

.action a {
    color: #4a7bd8;
    font-weight: bold;
    text-decoration: none;
    display: inline-block;
    padding: 4px 8px;
    transition: color 0.2s;
}

.action a:hover {
    text-decoration: underline;
}

.action-delete a {
    color: #d9534f;
}

.action-delete a:hover {
    color: #b52b27;
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
    
    <div class="list-box">
    
        <div class="list-header">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action" class="create-link">
                新規登録
            </a>
        </div>
    
        <div class="table-container">
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
                            <td class="td-code">${subject.cd}</td>
                            <td class="td-name">${subject.name}</td>
        
                            <td class="action">
                                <a href="${pageContext.request.contextPath}/action/SubjectUpdate.action?cd=${subject.cd}">
                                    変更
                                </a>
                            </td>
        
                            <td class="action action-delete">
                                <a class="delete-link"
                                   href="${pageContext.request.contextPath}/action/SubjectDelete.action?cd=${subject.cd}"
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