<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>科目管理</title>

<style>

/* =========================
   全体
========================= */
body{
    margin:0;
    font-family:"Yu Gothic","Meiryo",sans-serif;
    color:#333;
}

/* =========================
   戻るリンク
========================= */
.back-link{
    padding:10px 20px;
}

.back-link a{
    color:#3366cc;
    text-decoration:none;
}

.back-link a:hover{
    text-decoration:underline;
}

/* =========================
   メイン領域
========================= */
.content{
    display:flex;
    min-height:500px;
}

/* =========================
   左メニュー
========================= */
    .sidebar {
        width: 220px;
        background-color: #ffffff;
        border-right: 1px solid #ddd;
        padding: 24px 20px;
        box-sizing: border-box;
    }

    .sidebar ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .sidebar li {
        margin-bottom: 16px;
        color: #333;
        font-weight: bold;
    }

    .sidebar a {
        color: #0066cc;
        text-decoration: none;
        font-weight: normal;
    }

    .sidebar a:hover {
        text-decoration: underline;
    }


.sub-menu{
    margin-top:5px;
    margin-left:15px;
}

.sub-menu li{
    margin:5px 0;
}

.sidebar a{
    color:#3366cc;
    text-decoration:none;
}

.sidebar a:hover{
    text-decoration:underline;
}

/* =========================
   右側コンテンツ
========================= */
.list-box{
    flex:1;
    padding:0 20px;
}

/* =========================
   タイトル
========================= */
.page-title{
    background:#eeeeee;
    padding:10px 15px;
    font-size:24px;
    font-weight:bold;
    margin-bottom:10px;
}

/* =========================
   新規登録
========================= */
.create-area{
    text-align:right;
    margin-bottom:10px;
}

.create-link{
    color:#3366cc;
    text-decoration:none;
}

.create-link:hover{
    text-decoration:underline;
}

/* =========================
   テーブル
========================= */
table{
    width:100%;
    border-collapse:collapse;
}

th{
    text-align:left;
    background:#fafafa;
    padding:10px;
    border-top:1px solid #ccc;
    border-bottom:1px solid #ccc;
}

td{
    padding:10px;
    border-bottom:1px solid #ddd;
}

.action{
    width:70px;
    text-align:center;
}

.action a{
    color:#3366cc;
    text-decoration:none;
}

.action a:hover{
    text-decoration:underline;
}

/* =========================
   フッター
========================= */
 footer {
        background-color: #e0e0e0;
        text-align: center;
        padding: 14px;
        font-size: 12px;
        color: #666;
    }

</style>
</head>

<body>

<div class="back-link">
    <a href="${pageContext.request.contextPath}/action/Menu.action">
        ← メインメニューへ戻る
    </a>
</div>

<div class="content">

    <!-- 左メニュー -->
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

    <!-- 右側 -->
    <div class="list-box">

        <div class="page-title">
            科目管理
        </div>

        <div class="create-area">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action"
               class="create-link">
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

<footer>
    &copy; 2026 得点管理システム
</footer>

</body>
</html>