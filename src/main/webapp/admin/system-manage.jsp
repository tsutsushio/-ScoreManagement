<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="システム管理" />
<%@ include file="/header.jsp" %>
<%@ include file="nav.jsp" %>

<style>
    body { font-family: sans-serif; margin: 20px; background-color: #f4f6f8; }
    .dashboard-container { display: flex; gap: 30px; flex-wrap: wrap; align-items: flex-start; }
    .card { background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); flex: 1; min-width: 450px; }
    h2 { color: #333; border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-top: 0; font-size: 20px; }
    
    table { width: 100%; border-collapse: collapse; margin-top: 15px; margin-bottom: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; vertical-align: middle; }
    th { background-color: #f2f2f2; }
    
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; font-size: 14px; }
    .form-group input[type="text"], .form-group input[type="number"], select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    
    .btn { padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; color: white; transition: 0.2s; }
    .btn-primary { background-color: #007bff; }
    .btn-primary:hover { background-color: #0056b3; }
    .btn-danger { background-color: #dc3545; }
    .btn-danger:hover { background-color: #c82333; }
    .btn-success { background-color: #28a745; }
    .btn-success:hover { background-color: #218838; }
    
    .debug-info { font-size: 12px; color: #777; display: block; margin-top: 4px; }
    
    /* ★ 休職中バッジのスタイル */
    .badge-leave { background-color: #ffc107; color: #212529; font-size: 11px; padding: 3px 6px; border-radius: 4px; margin-left: 8px; font-weight: bold; vertical-align: middle; }
</style>

<h1>システム管理ダッシュボード</h1>

<div class="dashboard-container">

    <div class="card">
        <h2>📚 コース管理（追加・削除）</h2>
        
        <div style="background-color: #e9ecef; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
            <form action="${pageContext.request.contextPath}/action/CourseCreateExecute.action" method="post">
                <strong>【新規コースの追加】</strong>
                <div class="form-group" style="margin-top: 10px;">
                    <label>コースID（数字）</label>
                    <input type="number" name="id" required placeholder="例: 5">
                </div>
                <div class="form-group">
                    <label>コース名</label>
                    <input type="text" name="course_name" required placeholder="例: AI・データサイエンスコース">
                </div>
                <input type="submit" value="コースを追加する" class="btn btn-primary" style="width: 100%;">
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>コース名</th>
                    <th style="text-align: center;">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="course" items="${courseList}">
                    <tr>
                        <td>${course.id}</td>
                        <td>${course.courseName}</td>
                        <td style="text-align: center;">
                            <form action="${pageContext.request.contextPath}/action/CourseDeleteExecute.action" method="post" onsubmit="return confirm('${course.courseName} を本当に削除しますか？\n※関連する教員や学生のコース設定はリセットされます。');">
                                <input type="hidden" name="id" value="${course.id}">
                                <input type="submit" value="削除" class="btn btn-danger">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty courseList}">
                    <tr><td colspan="3" style="text-align: center;">登録されているコースがありません。</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h2>👨‍🏫 教員の担当コース紐付け</h2>
        <p style="font-size: 14px; color: #555;">教員の担当コースを直接変更・設定できます。（※退職者は非表示）</p>
        
        <table>
            <thead>
                <tr>
                    <th>氏名 (教員番号)</th>
                    <th>担当コース変更</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="teacher" items="${teacherList}">
                    <tr style="${teacher.status == '一時休職' ? 'background-color: #fff8e1;' : ''}">
                        <td>
                            <strong>${teacher.name}</strong>
                            
                            <c:if test="${teacher.status == '一時休職'}">
                                <span class="badge-leave">一時休職中</span>
                            </c:if>
                            
                            <span class="debug-info">
                                ID: ${teacher.specificId}<br>
                                現在のコースID: <b style="color:red;">${teacher.courseId}</b>
                            </span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/action/TeacherCourseUpdateExecute.action" method="post" style="display: flex; gap: 8px; align-items: center;" onsubmit="return confirm('${teacher.name} 先生の担当コースを更新してもよろしいですか？');">
                                <input type="hidden" name="user_id" value="${teacher.userId}">
                                
                                <select name="course_id" style="width: auto; margin-bottom: 0;">
                                    <option value="">（未設定）</option>
                                    <c:forEach var="course" items="${courseList}">
                                        <option value="${course.id}" ${teacher.courseId == course.id ? 'selected' : ''}>
                                            ${course.courseName}
                                        </option>
                                    </c:forEach>
                                </select>
                                
                                <input type="submit" value="更新" class="btn btn-success">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty teacherList}">
                    <tr><td colspan="2" style="text-align: center;">表示できる教員がいません。</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

</div>

<br>


<%@ include file="/footer.html" %>