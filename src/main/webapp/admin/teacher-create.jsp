<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="教員追加" />
<%@ include file="/header.jsp" %>
<%@ include file="nav.jsp" %>

<style>
    body { font-family: sans-serif; margin: 20px; }
    .form-box { background-color: #f9f9f9; padding: 25px; border-radius: 8px; border: 1px solid #ccc; max-width: 400px; border-top: 5px solid #d2691e; }
    .form-box label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
    .form-box input[type="text"], .form-box input[type="password"], .form-box input[type="number"], .form-box select {
        width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 16px;
    }
    .submit-btn { background-color: #d2691e; color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; width: 100%; font-size: 16px; }
    .submit-btn:hover { background-color: #a0522d; }
    .wrapper {display: flex; justify-content: center;}
	.container {width: 100%; max-width: 400px;}
    .btn-sub {
    	color: #e89a5c;              /* 文字色 */

    	display: block;              /* 中央寄せ用 */
    	width: fit-content;
    	margin: 20px auto;           /* 上下余白＋中央寄せ */

    	padding: 10px 22px;
    	border-radius: 6px;
    	text-align: center;

    	transition: 0.2s;
	}
	
	/* ホバー時（分かりやすく） */
	.btn-sub:hover {
    	color: #a94e16;
	}
</style>
<div class="wrapper">
	<div class="container">
	    <h1>教員の新規登録</h1>
	    
	    <div class="form-box">
	        <form action="${pageContext.request.contextPath}/action/TeacherCreateExecute.action" method="post">
	            
	            <label>ログイン用 ユーザーID（数字）</label>
	            <input type="number" name="id" required placeholder="例: 1002">
	            
	            <label>教員番号（数字）</label>
	            <input type="number" name="teacher_num" required placeholder="例: 9901">
	            
	            <label>氏名</label>
	            <input type="text" name="name" required placeholder="例: 情報 花子">
	            
	            <label>初期パスワード</label>
	            <input type="password" name="password" required placeholder="初期パスワードを入力">
	            
	            <label>担当コース</label>
	            <select name="course_id" required>
	                <option value="0">（未設定）</option>
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