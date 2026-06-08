<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/header.jsp" %>

<style>

/* ===== 画面全体 ===== */
html,
body{
    height:100%;
    margin:0;
    font-family:"Yu Gothic","Meiryo",sans-serif;
}

/* ヘッダー＋コンテンツ＋フッター */
.page-wrapper{
    min-height:100vh;
    display:flex;
    flex-direction:column;
}

/* ===== メイン領域 ===== */
.content{
    flex:1;
    display:flex;
}

/* ===== サイドバー ===== */
.sidebar{
    width:220px;
    padding:20px;
    border-right:1px solid #ddd;
    background:#fafafa;
}

.sidebar ul{
    list-style:none;
    margin:0;
    padding:0;
}

.sidebar > ul > li{
    margin-bottom:15px;
}

.sub-menu{
    margin-top:5px;
    margin-left:15px;
}

.sub-menu li{
    margin-bottom:5px;
}

.sidebar a{
    color:#3366cc;
    text-decoration:none;
}

.sidebar a:hover{
    text-decoration:underline;
}

/* ===== 右コンテンツ ===== */
.list-box{
    flex:1;
    padding:20px;
}

.page-title{
    background:#eeeeee;
    padding:12px 15px;
    font-size:24px;
    font-weight:bold;
    margin-bottom:15px;
}

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

/* ===== テーブル ===== */
table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#f5f5f5;
    text-align:left;
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

</style>

<div class="page-wrapper">

    <div class="content">

        <!-- 左メニュー -->
        <div class="sidebar">

            <ul>

                <li><strong>メニュー</strong></li>

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

</div>

<%@ include file="/footer.jsp" %>