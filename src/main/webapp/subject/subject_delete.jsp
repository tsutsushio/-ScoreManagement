<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/header.jsp" %>

<style>

.content{
    max-width:600px;
    margin:40px auto;
}

.page-title{
    background:#eeeeee;
    padding:12px 15px;
    font-size:24px;
    font-weight:bold;
    margin-bottom:20px;
}

.message-box{
    border:1px solid #cccccc;
    padding:30px;
    background:#fafafa;
    text-align:center;
}

.message{
    font-size:18px;
    margin-bottom:25px;
}

.back-btn{
    display:inline-block;
    padding:10px 20px;
    background:#3366cc;
    color:white;
    text-decoration:none;
    border-radius:4px;
}

.back-btn:hover{
    background:#264d99;
}

</style>

<div class="content">

    <div class="page-title">
        科目削除
    </div>

    <div class="message-box">

        <div class="message">
            科目を削除しました。
        </div>

        <a href="${pageContext.request.contextPath}/action/SubjectList.action"
           class="back-btn">
            科目一覧へ戻る
        </a>

    </div>

</div>

<%@ include file="/footer.jsp" %>