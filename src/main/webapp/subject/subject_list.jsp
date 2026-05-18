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
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background:
        radial-gradient(circle at top right, rgba(0, 220, 255, 0.12), transparent 40%),
        linear-gradient(135deg, #07111f 0%, #0a1f38 35%, #0f3b63 70%, #1ec8ff 100%);
    color: #eafcff;
    min-height: 100vh;
}

/* ヘッダー */
header {
    background:
        linear-gradient(90deg, rgba(0, 10, 25, 0.95), rgba(0, 80, 130, 0.85));
    border-bottom: 2px solid #30d8ff;
    box-shadow:
        0 0 12px rgba(48, 216, 255, 0.45),
        0 4px 20px rgba(0, 0, 0, 0.45);
    color: #ffffff;
    padding: 18px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
}

header::after {
    content: "";
    position: absolute;
    inset: 0;
    background:
        repeating-linear-gradient(
            -45deg,
            transparent 0 10px,
            rgba(255, 255, 255, 0.03) 10px 12px
        );
    pointer-events: none;
}

header h1 {
    margin: 0;
    font-size: 28px;
    font-weight: bold;
    letter-spacing: 2px;
    text-shadow:
        0 0 6px rgba(48, 216, 255, 0.9),
        0 0 18px rgba(48, 216, 255, 0.6);
}

.user-info {
    font-size: 14px;
    position: relative;
    z-index: 1;
}

.user-info a {
    color: #7ff6ff;
    margin-left: 15px;
    text-decoration: none;
    font-weight: bold;
    text-shadow: 0 0 8px rgba(127, 246, 255, 0.8);
}

.user-info a:hover {
    color: #ffffff;
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
    color: #8df8ff;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
    text-shadow: 0 0 8px rgba(141, 248, 255, 0.8);
}

.back-link a:hover {
    color: #ffffff;
    text-decoration: underline;
}

/* タイトル */
.title-area {
    background:
        linear-gradient(135deg, rgba(0, 25, 55, 0.95), rgba(0, 110, 180, 0.9));
    border-left: 6px solid #4ef2ff;
    border-right: 2px solid rgba(78, 242, 255, 0.6);
    color: #ffffff;
    padding: 18px 22px;
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 25px;
    border-radius: 0 12px 12px 0;
    box-shadow:
        0 0 18px rgba(78, 242, 255, 0.35),
        0 8px 24px rgba(0, 0, 0, 0.35);
    text-shadow:
        0 0 8px rgba(78, 242, 255, 0.8);
    letter-spacing: 2px;
}

/* 一覧部分 */
.table-area {
    background:
        linear-gradient(180deg, rgba(5, 20, 40, 0.92), rgba(10, 35, 65, 0.9));
    border: 1px solid rgba(78, 242, 255, 0.35);
    padding: 25px;
    border-radius: 14px;
    box-shadow:
        0 0 20px rgba(30, 200, 255, 0.18),
        0 10px 30px rgba(0, 0, 0, 0.35);
    backdrop-filter: blur(6px);
}

/* 新規登録リンク */
.new-link {
    text-align: right;
    margin-bottom: 15px;
}

.new-link a {
    display: inline-block;
    background:
        linear-gradient(135deg, #00b7ff, #6ef6ff);
    color: #00111f;
    padding: 10px 18px;
    border-radius: 999px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
    box-shadow:
        0 0 14px rgba(110, 246, 255, 0.6);
    transition: 0.2s ease;
}

.new-link a:hover {
    transform: translateY(-2px) scale(1.03);
    box-shadow:
        0 0 20px rgba(110, 246, 255, 0.85);
}

/* テーブル */
table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background-color: #0d6fb8; /* 統一した青色 */
    color: #ffffff;
    padding: 12px;
    border-bottom: 2px solid #5ff6ff;
    border-right: 1px solid rgba(255, 255, 255, 0.25); /* 列の区切り線 */
    text-align: left;
    text-shadow: 0 0 6px rgba(95, 246, 255, 0.7);
}

td {
    padding: 12px;
    border-bottom: 1px solid rgba(95, 246, 255, 0.15);
    border-right: 1px solid rgba(95, 246, 255, 0.15); /* 科目コードと科目名の区切り線 */
    color: #eafcff;
}

/* 一番右の列には右線を付けない */
th:last-child,
td:last-child {
    border-right: none;
}

tr:hover {
    background-color: rgba(95, 246, 255, 0.08);
}

/* 操作列 */
.action {
    width: 80px;
    text-align: center;
}

.action a {
    color: #7ff6ff;
    text-decoration: none;
    font-weight: bold;
    text-shadow: 0 0 8px rgba(127, 246, 255, 0.7);
}

.action a:hover {
    color: #ffffff;
    text-decoration: underline;
}

/* 削除リンク */
.action:last-child a {
    color: #ff6fae;
    text-shadow: 0 0 8px rgba(255, 111, 174, 0.7);
}

.action:last-child a:hover {
    color: #ffd3e7;
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