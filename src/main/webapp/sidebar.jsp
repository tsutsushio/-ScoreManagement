<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/* サイドバー全体のスタイル */
.sidebar {
    width: 220px;          /* 幅を220pxに統一 */
    background-color: #ffffff;
    padding: 20px;
    border-right: 1px solid #ddd;
    box-sizing: border-box; /* パディングを含めた幅にする */
}

/* リスト全体の余白リセット */
.sidebar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

/* メニュー項目ごとの上下の隙間 */
.sidebar li {
    margin-bottom: 12px;
    color: #333333;
    font-weight: bold;
}

/* 各メニューのリンク */
.sidebar a {
    text-decoration: none;
    color: #0066cc;
    display: block;
    padding: 6px 0;
    font-weight: normal; /* リンクは通常の太さに */
}

.sidebar a:hover {
    text-decoration: underline;
    color: #003399;
}

/* 成績管理の下にあるサブメニュー */
.sidebar .sub-menu {
    margin-left: 15px;
    margin-top: 5px;
    font-size: 0.9em;
}

.sidebar .sub-menu li {
    margin-bottom: 5px; /* サブメニュー内の隙間は少し狭く */
}
</style>

<div class="sidebar">
    <ul>
        <li><a href="${pageContext.request.contextPath}/action/Menu.action">メニュー</a></li>
        <li><a href="${pageContext.request.contextPath}/action/StudentList.action">学生管理</a></li>
        <li>
            成績管理
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/action/TestRegist.action">成績登録</a></li>
                <li><a href="${pageContext.request.contextPath}/action/TestList.action">成績参照</a></li>
            </ul>
        </li>
        <li><a href="${pageContext.request.contextPath}/action/SubjectList.action">科目管理</a></li>
    </ul>
</div>