<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="学生追加" />
<%@ include file="/header.jsp" %>
<%@ include file="nav.jsp" %>

<style>
    body { font-family: sans-serif; margin: 20px; }
    .form-box { background-color: #f9f9f9; padding: 25px; border-radius: 8px; border: 1px solid #ccc; max-width: 400px; }
    .form-box label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
    .form-box input[type="text"], 
    .form-box input[type="password"], 
    .form-box input[type="number"], 
    .form-box select {
        width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 16px;
    }
    .submit-btn { background-color: #007bff; color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; width: 100%; font-size: 16px; }
    .submit-btn:hover { background-color: #0056b3; }
    .wrapper {display: flex; justify-content: center;}
	.container {width: 100%; max-width: 400px;}
</style>
<div class="wrapper">
	<div class="container">
	    <h1>学生の新規登録</h1>
	    <div class="form-box">
	        <form action="${pageContext.request.contextPath}/action/StudentCreateExecute.action" method="post">
	            
	            <label>学籍番号（数字）</label>
	            <input type="number" name="id" required placeholder="例: 24001">
	            
	            <label>氏名</label>
	            <input type="text" name="name" required placeholder="例: 岡山 太郎">
	            
	            <label>初期パスワード</label>
	            <input type="password" name="password" required placeholder="初期パスワードを入力">
	            
	            <label>学年</label>
	            <select name="grade" required>
	                <option value="1">1年</option>
	                <option value="2">2年</option>
	                <option value="3">3年</option>
	                <option value="4">4年</option>
	            </select>
	
	            <label>所属コース</label>
	            <select name="course_id" required>
	                <option value="">コースを選択してください</option>
	                <c:forEach var="course" items="${courseList}">
	                    <option value="${course.id}">${course.courseName}</option>
	                </c:forEach>
	            </select>
	            
	            <input type="submit" value="この内容で登録する" class="submit-btn">
	        </form>
	    </div>
	</div>
</div>
    <br>
    

<%@ include file="/footer.html" %>