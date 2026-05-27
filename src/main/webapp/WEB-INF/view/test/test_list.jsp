<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/header.jsp" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>成績一覧（科目）</title> <style>
body{
    margin:0;
    background:#f3f3f3;
    font-family:"Yu Gothic","Meiryo",sans-serif;
    font-size:13px;
    color:#333;
}
.layout{
    display:flex;
    min-height:100vh;
}
.sidebar-area{
    width:220px;
    background:#ffffff;
    border-right:1px solid #dcdcdc;
}
.main-content{
    flex:1;
    padding:15px 20px;
}
.container{
    background:#fff;
    border:1px solid #d9d9d9;
    min-height:500px;
}
.title-area{
    background:#efefef;
    border-bottom:1px solid #d9d9d9;
    padding:12px 20px;
}
h2{
    margin:0;
    font-size:24px;
    font-weight:bold;
}
.content-area{
    padding:25px 30px;
}
.section-title{
    font-size:14px;
    margin:18px 0 10px;
    color:#555;
}
.search-table{
    border-collapse:collapse;
    margin-bottom:20px;
}
.search-table th{
    font-weight:normal;
    text-align:left;
    padding-right:10px;
    white-space:nowrap;
}
.search-table td{
    padding-right:15px;
}
select{
    width:120px;
    height:30px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:0 8px;
}
input[type="text"]{
    width:240px;
    height:30px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:0 10px;
}
.search-btn{
    width:60px;
    height:30px;
    border:none;
    background:#6c757d;
    color:#fff;
    border-radius:3px;
    cursor:pointer;
}
.search-btn:hover{
    background:#555;
}
.message{
    color:#3b9be5;
    font-size:12px;
    margin-top:10px;
}
select:focus,
input[type="text"]:focus{
    outline:none;
    border:1px solid #4d90fe;
}
/* 👇 設計図に合わせた成績一覧テーブル用のスタイル */
.result-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
    background: #fff;
    border: 1px solid #d9d9d9;
}
.result-table th {
    background: #efefef;
    border: 1px solid #d9d9d9;
    padding: 10px;
    text-align: left;
    font-weight: bold;
}
.result-table td {
    border: 1px solid #d9d9d9;
    padding: 10px;
}
</style>
</head>

<body>

<div class="layout">

    <div class="sidebar-area">
        <%@ include file="/sidebar.jsp" %>
    </div>

    <div class="main-content">

        <div class="container">

            <div class="title-area">
                <h2>成績一覧（科目）</h2>
            </div>

            <div class="content-area">

                <form action="TestList.action" method="get">

                    <div class="section-title">科目情報</div>

                    <table class="search-table">
                        <tr>
                            <th>入学年度</th>
                            <td>
                                <select name="f1">
                                    <option value="">-----</option>
                                    <c:forEach var="year" items="${ent_year_set}">
                                        <option value="${year}">${year}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            
                            <th>クラス</th>
                            <td>
                                <select name="f2">
                                    <option value="">-----</option>
                                    <c:forEach var="c_num" items="${class_num_set}">
                                        <option value="${c_num}">${c_num}</option>
                                    </c:forEach>
                                </select>
                            </td>

                            <th>科目</th>
                            <td>
                                <select name="f3">
                                    <option value="">-----</option>
                                    <c:forEach var="subject" items="${subjects}">
                                        <option value="${subject.cd}">${subject.name}</option>
                                    </c:forEach>
                                </select>

                                <button class="search-btn" type="submit" name="method" value="subject">検索</button>
                            </td>
                        </tr>
                    </table>

                    <div class="section-title">学生情報</div>

                    <table class="search-table">
                        <tr>
                            <th>学生番号</th>
                            <td>
                                <input type="text" name="f4" maxlength="10" placeholder="学生番号を入力してください">
                            </td>
                            <td>
                                <button class="search-btn" type="submit" name="method" value="student">検索</button>
                            </td>
                        </tr>
                    </table>
                    
                    <input type="hidden" name="f" value="sj">
                    <input type="hidden" name="f" value="st">

                </form>

                <c:if var="isSubject" test="${not empty subject_name}">
                    <div style="font-size: 13px; margin: 20px 0 5px;">科目：${subject_name}</div>
                </c:if>

                <c:if test="${not empty subject_tests}">
                    <table class="result-table">
                        <thead>
                            <tr>
                                <th>入学年度</th> <th>クラス</th>   <th>学生番号</th> <th>氏名</th>     <th>1回</th>      <th>2回</th>      </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${subject_tests}">
                                <tr>
                                    <td>${test.entYear}</td> <td>${test.classNum}</td> <td>${test.studentNo}</td> <td>${test.studentName}</td> <td>
                                        <c:choose>
                                            <c:when test="${not empty test.points[1]}">${test.points[1]}点</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty test.points[2]}">${test.points[2]}点</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${not empty tests}">
                    <div class="section-title" style="margin-top:30px;">🔎 学生の成績検索結果</div>
                    <table class="result-table">
                        <thead>
                            <tr>
                                <th>科目名</th>
                                <th>回数</th>
                                <th>点数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>${test.subjectName}</td>
                                    <td>${test.num}回目</td>
                                    <td>${test.point}点</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <p class="message" style="margin-top: 20px;">
                    ※科目情報または学生情報を入力して検索してください
                </p>
                
            </div>
        </div>
    </div>
</div>

<jsp:include page="/footer.html" />

</body>
</html>