<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目管理</title>

<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;
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

/* メインエリア：幅を柔軟に広げ、スクロールに対応 */
.main-content {
    flex: 1;
    padding: 40px 30px;
    box-sizing: border-box;
    background-color: #f4f7fb;
    overflow-y: auto;   /* データが多くなって縦長になっても右側だけスクロール */
}

/* ラッパー：最大幅を設定して大画面でも間延びを防ぐ */
.main-wrapper {
    max-width: 1300px;
    margin: 0 auto;
    width: 100%;
}

/* メインメニューへ戻るリンク */
.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #4a7bd8;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

.back-link a:hover {
    text-decoration: underline;
}

/* タイトルエリア（青いアクセントライン） */
h2 {
    margin: 0 0 25px;
    padding: 14px 20px;
    background: #fff;
    border-left: 6px solid #6ea8ff;
    border-radius: 10px;
    font-size: 26px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

/* テーブルを包む白いカード（クラス名の競合を防止） */
.list-card {
    background: #fff;
    padding: 24px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

/* 新規登録ボタン */
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
    transition: background-color 0.2s;
}

.create-link:hover {
    background-color: #4a7bd8;
}

/* テーブルスタイル */
table {
    width: 100%;
    border-collapse: collapse;
    clear: both; /* ボタンの回り込みを解除 */
}

thead {
    background: linear-gradient(135deg,#6ea8ff,#4a7bd8);
    color: #fff;
}

th {
    padding: 14px 10px;
    font-size: 15px;
}

td {
    padding: 14px 10px;
    text-align: center;
    border-bottom: 1px solid #eee;
    font-size: 15px;
}

tbody tr:nth-child(even) {
    background-color: #f8fbff;
}

tbody tr:hover {
    background-color: #eef5ff;
}

/* アクション（変更・削除）リンク */
.action a {
    color: #4a7bd8;
    font-weight: bold;
    text-decoration: none;
}

.action a:hover {
    text-decoration: underline;
}

/* 削除リンクのみ赤色にする指定 */
.action-delete a {
    color: #d9534f;
}
</style> </head>
<body> <%@ include file="/header.jsp" %>

<div class="container"> <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <div class="main-wrapper">

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/action/Menu.action">
                    ← メインメニューへ戻る </a>
            </div>

            <h2>科目管理</h2>

            <div class="list-card">

                <a href="${pageContext.request.contextPath}/action/SubjectCreate.action" class="create-link">
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

                                <td class="action action-delete">
                                    <a href="${pageContext.request.contextPath}/action/SubjectDelete.action?cd=${subject.cd}"
                                       onclick="return confirm('本当に削除しますか？');">
                                        削除
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div> </div> </div> </div> </body>
</html>