<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>科目管理</title>

<style>
/* 全体のベーススタイル */
body {
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #ffffff;
    color: #333333;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* フッターを下部に固定 */
    box-sizing: border-box;
}

/* メインレイアウト（左メニューと右コンテンツ） */
.content {
    display: flex;
    flex: 1;
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
    gap: 40px; /* メニューとコンテンツの間の隙間 */
}


/* ーーー 右側メインコンテンツ ーーー */
.list-box {
    flex: 1;
}

/* 画面タイトル (科目管理) */
.page-title {
    font-size: 20px;
    font-weight: bold;
    background-color: #f1f1f1;
    padding: 12px 20px;
    margin: 0 0 20px 0;
    border-radius: 4px;
    color: #333333;
}

/* 新規登録エリア */
.create-area {
    margin-bottom: 15px;
}

.create-link {
    color: #0066cc;
    text-decoration: underline;
    font-size: 14px;
}

.create-link:hover {
    color: #0033aa;
}

/* ーーー テーブル ーーー */
table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
}

/* ヘッダー行 */
th {
    background: transparent; /* 背景グレーを無くして画像通りに */
    text-align: left;
    padding: 12px 10px;
    font-weight: bold;
    color: #333333;
    border-top: none;
    border-bottom: 2px solid #333333; /* 下線を太く */
}

/* データ行 */
td {
    padding: 12px 10px;
    border-bottom: 1px solid #eeeeee; /* 薄いシャープな下線 */
    color: #555555;
    vertical-align: middle;
}

/* アクション列（変更・削除） */
.action {
    width: 60px;
    text-align: center;
}

.action a {
    color: #0066cc;
    text-decoration: underline;
}

.action a:hover {
    color: #0033aa;
}

/* ーーー フッター ーーー */
footer, #footer {
    width: 100%;
    background-color: #f1f1f1;
    padding: 15px 0;
    text-align: center;
    font-size: 13px;
    color: #666666;
    margin-top: auto; /* コンテンツが少なくても最下部に固定 */
    border-top: 1px solid #e0e0e0;
    box-sizing: border-box;
}
</style>

</head>
<body>

<div class="content">


    <!-- 右側 -->
    <div class="list-box">
        <div class="page-title">
            科目管理
        </div>

        <div class="create-area">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action" class="create-link">
                新規登録
            </a>
        </div>

        <table>
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

<%@ include file="/footer.jsp" %>
</body>
</html>
