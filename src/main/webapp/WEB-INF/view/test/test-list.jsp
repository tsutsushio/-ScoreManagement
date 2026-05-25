<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績参照</title>

<style>
<style>

/* ===== 全体 ===== */
body{
    font-family: "Yu Gothic","Meiryo",sans-serif;
    background-color:#f5f7fb;
    display:flex;
    flex-direction:column;
    align-items:center;
    min-height:100vh;
    margin:0;
    padding:30px 0;
}

/* 戻るリンク */
.back-link{
    margin-bottom:20px;
    text-decoration:none;
    color:#4a90e2;
    font-size:14px;
}

.back-link:hover{
    text-decoration:underline;
}

/* 白カード */
.container{
    background:white;
    padding:40px;
    border-radius:16px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    width:900px;
    box-sizing:border-box;
}

/* タイトル */
h2{
    color:#4a90e2;
    text-align:center;
    margin-top:0;
    margin-bottom:30px;
    font-size:26px;
}

/* 検索エリア */
.search-box{
    background:#fff;
}

/* 小タイトル */
.search-box h3{
    margin-top:0;
    margin-bottom:20px;
    color:#555;
    font-size:18px;
}

/* ===== 検索フォーム横並び ===== */
form{
    display:flex;
    align-items:flex-end;
    gap:16px;
    flex-wrap:wrap;
}

/* ラベル風 */
form::before{
    content:"";
}

/* テキスト */
.search-label{
    font-size:14px;
    color:#555;
    font-weight:bold;
}

/* select */
select{
    padding:10px;
    border:1px solid #dce4ec;
    border-radius:8px;
    font-size:15px;
    background:white;
    min-width:150px;
    transition:0.2s;
}

select:focus{
    outline:none;
    border-color:#66a3ff;
}

/* 検索ボタン */
button[type="submit"]{
    padding:12px 24px;
    background:#66a3ff;
    color:white;
    border:none;
    border-radius:10px;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
    transition:0.2s;
}

button[type="submit"]:hover{
    background:#4d8cff;
}

/* エラーメッセージ */
.error{
    color:#ff5c5c;
    margin-top:15px;
    font-size:14px;
    font-weight:bold;
}

/* ===== テーブル ===== */
table{
    width:100%;
    border-collapse:collapse;
    margin-top:30px;
    background:white;
    overflow:hidden;
    border-radius:12px;
}

/* ヘッダー */
th{
    background:#66a3ff;
    color:white;
    padding:14px;
    font-size:14px;
}

/* データ */
td{
    border:1px solid #dce4ec;
    padding:12px;
    text-align:center;
    font-size:14px;
}

/* 偶数行を少し色付け */
tr:nth-child(even){
    background:#f8fbff;
}

/* ホバー */
tr:hover{
    background:#eef5ff;
}

</style>
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