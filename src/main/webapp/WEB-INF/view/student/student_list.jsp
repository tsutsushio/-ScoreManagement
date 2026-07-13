<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生一覧</title>
<style>
/* 全体レイアウト */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	font-family: "Yu Gothic", sans-serif;
	background-color: #ffffff;
}

body {
	display: flex;
	flex-direction: column;
}

.container {
	display: flex;
	flex: 1;
	width: 100%;
	align-items: stretch;
}

.main-content {
	flex: 1;
	padding: 20px 40px;
	background-color: #ffffff;
	box-sizing: border-box;
}

.main-content h2 {
	margin-top: 0;
	margin-bottom: 25px;
	padding: 10px 15px;
	background-color: #f2f2f2;
	color: #333;
	font-size: 18px;
	font-weight: bold;
}

.search-wrapper {
	position: relative;
	margin-bottom: 20px;
	padding-top: 25px;
}

.create-link {
	position: absolute;
	top: 0;
	right: 0;
	color: #0066ff;
	font-size: 14px;
	text-decoration: underline;
}

.search-row {
	display: flex;
	align-items: center;
	gap: 15px;
	background-color: #ffffff;
}

.input-item {
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.input-item label {
	font-size: 12px;
	color: #666;
}

.input-item select {
	padding: 4px 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	min-width: 140px;
}

.checkbox-label {
	display: flex;
	align-items: center;
	gap: 5px;
	font-size: 13px;
	color: #333;
	margin-top: 18px;
	cursor: pointer;
}

.search-btn {
	background-color: #555555;
	color: #ffffff;
	border: none;
	border-radius: 4px;
	padding: 6px 16px;
	font-size: 13px;
	cursor: pointer;
	margin-top: 18px;
}

.result-count {
	font-size: 13px;
	color: #333;
	margin: 15px 0 10px 0;
}

.student-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

.student-table th {
	border-bottom: 2px solid #333;
	padding: 8px 10px;
	text-align: left;
	font-size: 14px;
	color: #333;
}

.student-table td {
	padding: 10px;
	font-size: 14px;
	border-bottom: 1px solid #eee;
}

.error-message {
	font-size: 14px;
	color: #d33;
	margin-top: 15px;
	font-weight: bold;
}

/* テーブルの偶数行（2, 4, 6行目...）の背景色を薄いグレーにする */
table tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* 【プロの小技】マウスを乗せた行の色を変えるとさらに分かりやすいです */
table tr:hover {
    background-color: #f0f5fa; /* ほんのり薄い青色 */
}
</style>
</head>
<body>

	<%@ include file="/header.jsp"%>

	<div class="container">
		<%@ include file="/sidebar.jsp"%>

		<div class="main-content">
			<h2>学生管理</h2>

			<div class="search-wrapper">
				<a
					href="${pageContext.request.contextPath}/action/StudentCreate.action"
					class="create-link">新規登録</a>

				<form
					action="${pageContext.request.contextPath}/action/StudentList.action"
					method="post">
					<div class="search-row">
						<div class="input-item">
							<label>入学年度</label> <select name="entYear">
								<option value="0">--------</option>
								<c:forEach var="y" begin="2014" end="2024">
									<option value="${y}"
										<c:if test="${param.entYear == y}">selected</c:if>>${y}</option>
								</c:forEach>
							</select>
						</div>

						<div class="input-item">
							<label>クラス</label> <select name="classNum">
								<option value="--------">--------</option>
								<c:forEach var="c" items="101,102,201,202">
									<option value="${c}"
										<c:if test="${param.classNum == c}">selected</c:if>>${c}</option>
								</c:forEach>
							</select>
						</div>

						<label class="checkbox-label"> <input type="checkbox"
							name="isAttend" value="true"
							<c:if test="${param.isAttend == 'true'}">checked</c:if>>
							在学中
						</label>

						<button type="submit" class="search-btn">絞込み</button>
					</div>
				</form>

				<%-- エラーメッセージ表示エリア --%>
				<c:if test="${not empty error}">
					<div class="error-message">${error}</div>
				</c:if>
			</div>

			<%-- 学生一覧表示エリア --%>
			<c:choose>
				<c:when test="${not empty studentList}">
					<p class="result-count">検索結果：${studentList.size()}件</p>
					<table class="student-table">
						<thead>
							<tr>
								<th>入学年度</th>
								<th>学生番号</th>
								<th>氏名</th>
								<th>クラス</th>
								<th style="text-align: center;">在学中</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="student" items="${studentList}">
								<tr>
									<td>${student.entYear}</td>
									<td>${student.no}</td>
									<td><c:out value="${student.name}" /></td>
									<td>${student.classNum}</td>
									<td style="text-align: center;">${student.isAttend ? '〇' : '×'}</td>
									<td><a
										href="${pageContext.request.contextPath}/action/StudentUpdate.action?no=${student.no}">変更</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:when>
				<c:otherwise>
					<%-- リストが空の場合はメッセージを表示 --%>
					<p>学生情報が存在しませんでした</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<%@ include file="/footer.jsp"%>
</body>
</html>