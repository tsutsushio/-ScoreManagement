<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="学生教員一覧" />
<%@ include file="/header.jsp" %>
<%@ include file="nav.jsp" %>

<style>
    body { font-family: sans-serif; margin: 20px; }
    .search-box { background-color: #f0f8ff; padding: 20px; border-radius: 8px; border: 1px solid #b0c4de; margin-bottom: 30px; }
    .search-box label { font-weight: bold; margin-right: 5px; }
    .search-box input, .search-box select { padding: 8px; margin-right: 15px; border: 1px solid #ccc; border-radius: 4px; margin-bottom: 10px; }
    .search-btn { background-color: #4682b4; color: white; padding: 8px 20px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
    .search-btn:hover { background-color: #4169e1; }
    
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
    th { background-color: #f2f2f2; color: #333; }
    .status-active { color: #28a745; font-weight: bold; } /* 在籍は緑 */
    .status-inactive { color: #dc3545; } /* 退学などは赤 */
    .btn-sub {
    	color: #3498db;              /* 文字色 */

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
    	color: #0d3c61;
	}
</style>

    <h1>学生・教員 一覧および検索</h1>

    <div class="search-box">
        <form action="${pageContext.request.contextPath}/action/UserList.action" method="get">
            
            <label>権限:</label>
            <select name="authority_id">
                <option value="">すべて</option>
                <option value="2">教員</option>
                <option value="3">学生</option>
            </select>

            <label>状態:</label>
            <select name="status">
                <option value="">すべて</option>
                <option value="在籍">在籍（在職）</option>
                <option value="退学">退学</option>
                <option value="退職">退職</option>
                <option value="一時休職">一時休職</option>
            </select>

            <label>番号:</label>
            <input type="number" name="specific_id" placeholder="学籍/教員番号">
            
            <label>氏名:</label>
            <input type="text" name="name" placeholder="名前の一部">
            
            <label>コース:</label>
            <select name="course_id">
                <option value="">すべて</option>
                <c:forEach var="course" items="${courseList}">
                    <option value="${course.id}" ${param.course_id == course.id ? 'selected' : ''}>
                        ${course.courseName}
                    </option>
                </c:forEach>
            </select>
            
            <input type="submit" value="検索" class="search-btn">
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>権限</th>
                <th>状態</th> <th>番号</th>
                <th>氏名</th>
                <th>所属コース</th>
                <th>学年</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.authName}</td>
                    <td class="${user.status == '在籍' ? 'status-active' : 'status-inactive'}">
                        ${user.status}
                    </td>
                    <td>${user.specificId}</td>
                    <td>${user.name}</td>
                    <td>${user.courseName != null ? user.courseName : '未設定'}</td>
                    <td>
                        <c:if test="${user.grade > 0}">${user.grade}年</c:if>
                        <c:if test="${user.grade == 0}">-</c:if>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/action/UserEdit.action?id=${user.userId}" 
                           style="background-color: #28a745; color: white; padding: 6px 12px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 14px;">
                           編集
                        </a>
                    </td>
                </tr>
            </c:forEach>
            
            <c:if test="${empty userList}">
                <tr><td colspan="7" style="text-align: center;">該当するデータがありません。</td></tr>
            </c:if>
        </tbody>
    </table>

    <br>

<%@ include file="/footer.html" %>