<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績参照</title>

<style>

body{
    font-family:
    "Yu Gothic",sans-serif;
    background:#f5f7fa;
}

.container{
    width:900px;
    margin:auto;
}

.search-box{
    background:white;
    padding:20px;
    border-radius:10px;
    margin-top:20px;
}

table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

th,td{
    border:1px solid #ccc;
    padding:10px;
    text-align:center;
}

th{
    background:#e8eef5;
}

.error{
    color:#0099ff;
    margin-top:10px;
}

</style>
</head>

<body>
<a href="${pageContext.request.contextPath}/action/Menu.action"
   class="back-link">
    ← メニューへ戻る
</a>

<div class="container">

<h2>成績参照</h2>

<div class="search-box">

<h3>科目情報</h3>

<form action="TestList.action"
      method="post">

<input type="hidden"
       name="f"
       value="sj">

入学年度

<select name="f1">
<option value="">--------</option>

<c:forEach
items="${yearList}"
var="year">

<option value="${year}">
${year}
</option>

</c:forEach>
</select>

クラス

<select name="f2">

<option value="">
--------
</option>

<c:forEach
items="${classList}"
var="cls">

<option value="${cls}">
${cls}
</option>

</c:forEach>

</select>

科目

<select name="f3">

<option value="">
--------
</option>

<c:forEach
items="${subjectList}"
var="sub">

<option value="${sub.cd}">
${sub.name}
</option>

</c:forEach>

</select>

<button type="submit">
検索
</button>

</form>

<c:if test="${not empty error}">
<p class="error">
${error}
</p>
</c:if>

<c:if test="${not empty testList}">

<table>

<tr>
<th>入学年度</th>
<th>クラス</th>
<th>学生番号</th>
<th>氏名</th>
<th>回数</th>
<th>点数</th>
</tr>

<c:forEach
items="${testList}"
var="test">

<tr>

<td>
${test.student.entYear}
</td>

<td>
${test.classNum}
</td>

<td>
${test.student.no}
</td>

<td>
${test.student.name}
</td>

<td>
${test.no}
</td>

<td>
${test.point}
</td>

</tr>

</c:forEach>

</table>

</c:if>

</div>
</div>

</body>
</html>