<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="情報編集" />
<%@ include file="/header.jsp" %>
<%@ include file="nav.jsp" %>

<style>
    body { font-family: sans-serif; margin: 20px; background-color: #f4f6f8; }
    .form-box { background-color: #fff; padding: 25px; border-radius: 8px; border: 1px solid #ccc; max-width: 450px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
    .form-box label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; margin-top: 15px;}
    .form-box input[type="text"], .form-box select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    
    .btn-submit { background-color: #007bff; color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; width: 100%; margin-top: 25px; transition: 0.2s;}
    .btn-submit:hover { background-color: #0056b3; }
    .wrapper {display: flex; justify-content: center;}
	.container {width: 100%; max-width: 400px;}
</style>
<div class="wrapper">
	<div class="container">
	    <h1>${editUser.authName}情報の編集</h1>
	    
	    <div class="form-box">
	        <form action="${pageContext.request.contextPath}/action/UserEditExecute.action" method="post">
	            
	            <input type="hidden" name="id" value="${editUser.userId}">
	            <input type="hidden" name="authName" value="${editUser.authName}">
	            
	            <label>番号（※変更不可）</label>
	            <input type="text" value="${editUser.specificId}" disabled style="background-color: #e9ecef;">
	            
	            <label>氏名</label>
	            <input type="text" name="name" value="${editUser.name}" required>
	            
	            <label>コース</label>
	            <select name="course_id" required>
	                <c:if test="${editUser.authName == '教員'}">
	                    <option value="0" ${editUser.courseId == 0 ? 'selected' : ''}>（未設定）</option>
	                </c:if>
	                
	                <c:forEach var="course" items="${courseList}">
	                    <option value="${course.id}" ${editUser.courseId == course.id ? 'selected' : ''}>
	                        ${course.courseName}
	                    </option>
	                </c:forEach>
	            </select>
	            
	            <c:if test="${editUser.authName == '学生'}">
	                <label>学年</label>
	                <select name="grade" required>
	                    <option value="1" ${editUser.grade == 1 ? 'selected' : ''}>1年</option>
	                    <option value="2" ${editUser.grade == 2 ? 'selected' : ''}>2年</option>
	                    <option value="3" ${editUser.grade == 3 ? 'selected' : ''}>3年</option>
	                    <option value="4" ${editUser.grade == 4 ? 'selected' : ''}>4年</option>
	                </select>
	            </c:if>
	
	            <hr style="margin-top: 20px; border: 0; border-top: 1px solid #ddd;">
	
	            <label style="color: #dc3545;">ステータス（在籍・退学など）</label>
	            
	            <c:if test="${editUser.authName == '学生'}">
	                <select name="status">
	                    <option value="在籍" ${editUser.status == '在籍' ? 'selected' : ''}>在籍</option>
	                    <option value="退学" ${editUser.status == '退学' ? 'selected' : ''}>退学</option>
	                </select>
	            </c:if>
	            
	            <c:if test="${editUser.authName == '教員'}">
	                <select name="status">
	                    <option value="在籍" ${editUser.status == '在籍' ? 'selected' : ''}>在職（在籍）</option>
	                    <option value="退職" ${editUser.status == '退職' ? 'selected' : ''}>退職</option>
	                    <option value="一時休職" ${editUser.status == '一時休職' ? 'selected' : ''}>一時休職</option>
	                </select>
	            </c:if>
	            
	            <input type="submit" value="この内容で更新する" class="btn-submit">
	        </form>
	    </div>

	    <br>
	    <a href="${pageContext.request.contextPath}/action/UserList.action" style="color: #007bff; text-decoration: none; font-weight: bold;">← 一覧画面へ戻る</a>
	</div>
</div>
<%@ include file="/footer.html" %>