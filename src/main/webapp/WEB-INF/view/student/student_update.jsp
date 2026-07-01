
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報変更</title>

<style>
/* 全体レイアウト：他の画面と共通の縦幅いっぱいベース */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	font-family: "Yu Gothic", sans-serif;
	background-color: #ffffff;
}

body {
	display: flex;
	flex-direction: column; /* 上からヘッダー、コンテンツの順 */
}

/* メインコンテナ（サイドバーとコンテンツの並び） */
.container {
	display: flex;
	flex: 1;
	width: 100%;
	align-items: stretch;
}

/* 右側メインエリア */
.main-content {
	flex: 1;
	padding: 20px 40px;
	background-color: #ffffff;
	box-sizing: border-box;
}

/* ① 見出し「学生情報変更」（グレーの帯） */
.main-content h2 {
	margin-top: 0;
	margin-bottom: 25px;
	padding: 10px 15px;
	background-color: #f2f2f2;
	color: #333;
	font-size: 18px;
	font-weight: bold;
}

/* フォームコンテナ */
.form-container {
	max-width: 800px;
	width: 100%;
}

/* ②④⑥⑧ 各入力項目の縦並びグループ設定 */
.form-group {
	display: flex;
	flex-direction: column;
	gap: 6px;
	margin-bottom: 20px;
}

.form-group label {
	font-size: 13px;
	color: #333;
	font-weight: bold;
}

/* 読み取り専用（readonly）の入力枠の見た目 */
.form-group input[type="text"][readonly] {
	background-color: #e9ecef; /* 少し暗いグレー */
	color: #495057; /* 文字色を少し薄く */
	cursor: not-allowed; /* マウスカーソルを「禁止」マークにする */
}

.form-group input[type="text"][readonly]:focus {
	outline: none; /* 黒いフォーカス枠を消す */
	border-color: #ccc; /* 枠線の色が変わるのを防ぐ */
}

/* ⑦⑨ 入力欄（テキスト・セレクト共通の見た目） */
.form-group input[type="text"], .form-group select {
	width: 100%;
	padding: 8px 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
	box-sizing: border-box;
	background-color: #ffffff;
	color: #333;
}

/* ⑩⑪ 在学中フラグ（ラベルの右側にチェックボックスを配置） */
.checkbox-group {
	display: flex;
	align-items: center;
	gap: 6px;
	margin-bottom: 25px;
}

.checkbox-group label {
	font-size: 13px;
	color: #333;
	font-weight: bold;
}

.checkbox-group input[type="checkbox"] {
	margin: 0;
	cursor: pointer;
}

/* ⑫ 「変更」ボタン（鮮やかな青色の四角ボタン仕様） */
.btn-submit {
	background-color: #0066ff;
	color: #ffffff;
	border: none;
	border-radius: 4px;
	padding: 8px 16px;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	margin-bottom: 15px;
	transition: background-color 0.2s;
}

.btn-submit:hover {
	background-color: #0044cc;
}

/* ⑬ 「戻る」リンク（青文字下線） */
.back-link-box {
	margin-top: 5px;
}

.back-link {
	color: #0066ff;
	font-size: 14px;
	text-decoration: underline;
}

.back-link:hover {
	color: #0044cc;
}

/* サーバー側エラーメッセージ */
.error-msg {
	color: #d9534f;
	font-size: 13px;
	margin-top: 4px;
	font-weight: bold;
}

/* 削除ボタン用フォームの配置 */
.delete-form {
	margin-top: 40px;
	border-top: 1px dashed #ccc;
	padding-top: 20px;
}

.btn-delete {
	background-color: #dc3545;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
	font-weight: bold;
	transition: background-color 0.2s;
}

.btn-delete:hover {
	background-color: #bd2130;
}
</style>
</head>
<body>

	<%@ include file="/header.jsp"%>

	<div class="container">

		<%@ include file="/sidebar.jsp"%>

		<div class="main-content">

			<h2>学生情報変更</h2>

			<div class="form-container">
				<form
					action="${pageContext.request.contextPath}/action/StudentUpdateExecute.action"
					method="post">

					<div class="form-group">
						<label>入学年度</label> <input type="text" name="entYear"
							value="${student.entYear}" readonly>
					</div>

					<div class="form-group">
						<label>学生番号</label> <input type="text" name="no"
							value="${student.no}" readonly>
					</div>

					<div class="form-group">
						<label>氏名</label> <input type="text" name="name" maxlength="10"
							value="${student.name}" required>
					</div>

					<div class="form-group">
						<label>クラス</label> <select name="classNum">
							<c:forEach var="c" items="${classList}">
								<option value="${c}" ${student.classNum == c ? 'selected' : ''}>${c}</option>
							</c:forEach>
						</select>
					</div>

					<div class="checkbox-group">
						<label for="isAttend">在学中</label> <input type="checkbox"
							id="isAttend" name="isAttend" value="true"
							${student.isAttend ? 'checked' : ''}>
					</div>

					<button type="submit" class="btn-submit">変更</button>

				</form>

				<div class="back-link-box">
					<a
						href="${pageContext.request.contextPath}/action/StudentList.action"
						class="back-link">戻る</a>
				</div>

				<form
					action="${pageContext.request.contextPath}/action/StudentDelete.action"
					method="post"
					onsubmit="return confirm('本当にこの学生データを削除してよろしいですか？\n※この操作は取り消せません。');"
					class="delete-form">
					<input type="hidden" name="no" value="${student.no}">
					<button type="submit" class="btn-delete">この学生データを削除する</button>
				</form>
			</div>

		</div>
	</div>
	<%@ include file="/footer.jsp"%>

</body>
</html>