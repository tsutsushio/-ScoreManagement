<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/header.jsp" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>成績参照</title>

<style>

body{
    margin:0;
    background:#f3f3f3;
    font-family:"Yu Gothic","Meiryo",sans-serif;
    font-size:13px;
    color:#333;
}

/* 全体 */
.layout{
    display:flex;
    min-height:100vh;
}

/* サイドバー */
.sidebar-area{
    width:220px;
    background:#ffffff;
    border-right:1px solid #dcdcdc;
}

/* メイン */
.main-content{
    flex:1;
    padding:15px 20px;
}

/* コンテンツ */
.container{
    background:#fff;
    border:1px solid #d9d9d9;
    min-height:500px;
}

/* タイトル部分 */
.title-area{
    background:#efefef;
    border-bottom:1px solid #d9d9d9;
    padding:12px 20px;
}

/* タイトル */
h2{
    margin:0;
    font-size:24px;
    font-weight:bold;
    color:#333;
}

/* 本文 */
.content-area{
    padding:25px 30px;
}

/* セクション名 */
.section-title{
    font-size:14px;
    margin-bottom:12px;
    color:#555;
}

/* テーブル */
.search-table{
    border-collapse:collapse;
    margin-bottom:25px;
}

.search-table th{
    font-weight:normal;
    text-align:left;
    padding-right:10px;
    white-space:nowrap;
    font-size:13px;
}

.search-table td{
    padding-right:15px;
}

/* セレクト */
select{
    width:120px;
    height:30px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    background:#fff;
    font-size:13px;
    padding:0 8px;
}

/* 入力欄 */
input[type="text"]{
    width:240px;
    height:30px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:0 10px;
    font-size:13px;
}

/* ボタン */
.search-btn{
    width:55px;
    height:30px;
    border:none;
    background:#6c757d;
    color:#fff;
    border-radius:3px;
    font-size:12px;
    cursor:pointer;
}

.search-btn:hover{
    background:#555;
}

/* 案内文 */
.message{
    color:#3b9be5;
    font-size:12px;
    margin-top:10px;
}

/* フォーカス */
select:focus,
input[type="text"]:focus{
    outline:none;
    border:1px solid #4d90fe;
}

</style>
</head>

<body>

<div class="layout">

    <!-- サイドバー -->
    <div class="sidebar-area">
        <%@ include file="/sidebar.jsp" %>
    </div>

    <!-- メイン -->
    <div class="main-content">

        <div class="container">

            <!-- タイトル帯 -->
            <div class="title-area">
                <h2>成績参照</h2>
            </div>

            <!-- 本文 -->
            <div class="content-area">

                <!-- 科目情報 -->
                <div class="section-title">科目情報</div>

                <form action="" method="post">

                    <table class="search-table">

                        <tr>

                            <th>入学年度</th>

                            <td>
    <select name="f1">
        <option value="">-----</option>
        <c:forEach var="year" items="${ent_year_set}">
            <%-- yearが単なる数値のリストの場合 --%>
            <option value="${year}">${year}</option>
        </c:forEach>
    </select>
</td>

<td>
    <select name="f2">
        <option value="">-----</option>
        <c:forEach var="c_num" items="${class_num_set}">
            <%-- c_numがStringのリストの場合 --%>
            <option value="${c_num}">${c_num}</option>
        </c:forEach>
    </select>
</td>

<td>
    <select name="f3">
        <option value="">-----</option>
        <c:forEach var="subject" items="${subjects}">
            <%-- subjectがSubjectBeanオブジェクトの場合 --%>
            <option value="${subject.cd}">${subject.name}</option>
        </c:forEach>
    </select>
    
    <button class="search-btn" type="submit">
     検索
    </button>
                                
</td>

                        </tr>

                    </table>

                    <!-- 学生情報 -->
                    <div class="section-title">
                        学生情報
                    </div>

                    <table class="search-table">

                        <tr>

                            <th>学生番号</th>

                            <td>
                                <input type="text"
                                       name="f4"
                                       maxlength="10"
                                       placeholder="学生番号を入力してください">
                            </td>

                            <td>
                                <button class="search-btn" type="submit">
                                    検索
                                </button>
                            </td>

                        </tr>

                    </table>

                </form>

                <!-- メッセージ -->
                <p class="message">
                    ※科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
                </p>

            </div>

        </div>

    </div>

</div>

<jsp:include page="/footer.html" />

</body>
</html>