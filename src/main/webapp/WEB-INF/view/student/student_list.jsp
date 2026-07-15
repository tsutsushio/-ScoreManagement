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
	/* フォントをより洗練されたモダンな並びに */
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif;
	background-color: #f4f6f4; /* 全体の薄い緑背景 */
	color: #2b2d42; /* 文字色を優しいチャコールに */
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
	background-color: #fafbfc;
}

.main-content {
	flex: 1;
	padding: 40px 60px; /* 余白を贅沢に広げてプレミアムな空気感に */
	background-color: #fafbfc;
	box-sizing: border-box;
}

/* 見出し「学生一覧・検索」（グレーの帯を廃止し、繊細な下線と文字のみに） */
.main-content h2 {
	margin-top: 0;
	margin-bottom: 35px;
	padding: 0 0 15px 0;
	background-color: transparent;
	border-bottom: 2px solid #edf0ee; /* 洗練された細い下線 */
	color: #2c5234; /* メインの深緑 */
	font-size: 22px;
	font-weight: 500;
	letter-spacing: 0.05em;
}

.search-wrapper {
	position: relative;
	margin-bottom: 30px;
	padding-top: 50px; /* 新規登録ボタンが綺麗に収まるよう上の余白を調整 */
}

/* 「新規登録」リンク（青文字下線を廃止し、右上に浮かぶお洒落なグリーンボタンに） */
.create-link {
	position: absolute;
	top: 0;
	right: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 36px;
	padding: 0 18px;
	background-color: #4a7c59; /* アクセントのグリーン */
	color: #ffffff;
	text-decoration: none; /* 下線を消去 */
	border-radius: 8px; /* 角丸 */
	font-size: 13px;
	font-weight: 500;
	letter-spacing: 0.03em;
	box-shadow: 0 2px 8px rgba(74, 124, 89, 0.15);
	transition: all 0.2s ease;
}
.create-link:hover {
	background-color: #3b6347; /* ホバー時は少し深いオリーブに */
	box-shadow: 0 4px 12px rgba(74, 124, 89, 0.25);
	color: #ffffff;
}

/* 検索行（「ただの並び」から「プレーンな白い1枚のカード」へ） */
.search-row {
	display: flex;
	align-items: center;
	gap: 20px;
	background-color: #ffffff; /* 白いカードとして浮き立たせる */
	border: 1px solid #edf0ee;
	border-radius: 12px; /* 角丸を大きめにして柔らかく */
	padding: 24px 30px;
	box-sizing: border-box;
	/* 海外SaaS風の、ものすごく薄くて広い上質な影 */
	box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
}

.input-item {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.input-item label {
	font-size: 11px;
	color: #8a958f; /* 馴染むニュアンスグレー */
	font-weight: 600;
	letter-spacing: 0.05em;
}

/* セレクトボックス（背景にうっすら色がついたフラットデザインに） */
.input-item select {
	height: 40px; /* 高さを出してスマートに */
	padding: 0 12px;
	border: 1px solid transparent; /* 通常時は線を消す */
	border-radius: 8px;
	font-size: 14px;
	background-color: #f1f3f1; /* 薄いアッシュグリーングレーの背景 */
	color: #2b2d42;
	min-width: 150px;
	outline: none;
	box-sizing: border-box;
	transition: all 0.25s ease;
}
/* フォーカス時：背景が白になり、グリーンの細い線が浮き出る */
.input-item select:focus {
	background-color: #ffffff;
	border-color: #4a7c59;
	box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

/* チェックボックスのラベル（グリーンに合わせた優しいトーン） */
.checkbox-label {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 13px;
	color: #4a7c59; /* 親しみやすい緑色 */
	font-weight: 500;
	margin-top: 18px; /* ラベルの高さと並びを合わせる */
	cursor: pointer;
}
/* チェックボックス自体の色もモダンなブラウザならほんのり緑になります */
.checkbox-label input[type="checkbox"] {
	accent-color: #4a7c59; 
}

/* 「検索」ボタン（メインの深緑ボタン仕様） */
.search-btn {
	height: 40px;
	background-color: #2c5234; /* 深緑で引き締める */
	color: #ffffff;
	border: none;
	border-radius: 8px;
	padding: 0 24px;
	font-size: 14px;
	font-weight: 500;
	letter-spacing: 0.03em;
	cursor: pointer;
	margin-top: 18px; /* ラベルの高さと並びを合わせる */
	transition: all 0.2s ease;
}
.search-btn:hover {
	background-color: #1e3b24;
	box-shadow: 0 4px 12px rgba(44, 82, 52, 0.2);
}

/* 検索結果の件数表示（目立たせすぎず上品に） */
.result-count {
	font-size: 13px;
	color: #8a958f; /* ニュアンスグレー */
	font-weight: 500;
	margin: 25px 0 12px 10px; /* 少し位置をテーブルに近づける */
}

/* 学生一覧テーブル（「THE・表」っぽさを無くした、モダンでフラットなカード型デザイン） */
.student-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	background: #ffffff; /* 白いカードとして浮き立たせる */
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
	overflow: hidden;
	border: 1px solid #edf0ee;
}

/* ヘッダーの背景塗りをやめ、白背景にシンプルな文字ラインのみに */
.student-table th {
	background-color: #ffffff; 
	color: #8a958f; /* 薄い色にしてデータ（数字や名前）を引き立てる */
	padding: 18px 16px; 
	text-align: left; 
	font-weight: 600; 
	font-size: 12px;
	letter-spacing: 0.05em;
	border-bottom: 2px solid #edf0ee;
}

.student-table td {
	padding: 16px 16px; /* 余白を贅沢に取ってスッキリ見せる */
	font-size: 14px;
	color: #2b2d42;
	border-bottom: 1px solid #f4f6f5; 
}

/* エラーメッセージ（バリデーション赤文字） */
.error-message {
	font-size: 14px;
	color: #e63946; /* スタイリッシュで目に留まりやすい「くすみ赤」に変更 */
	margin-top: 20px;
	font-weight: 600;
}

/* テーブルの行を交互に薄い緑にして、横ラインのデータを見やすく（視認性向上） */
table tr:nth-child(even) {
    background-color: #f9fbf9;
}

/* マウスを乗せた行をうっすら明るい緑に変えて、今どこのデータを見ているか分かりやすく */
table tr:hover {
    background-color: #f1f6f1; 
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