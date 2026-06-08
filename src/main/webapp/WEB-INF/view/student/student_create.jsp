<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報登録</title>
<style>
    /* 全体レイアウト */
    body {
        margin: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #ffffff;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* メインコンテナ（サイドバーとコンテンツの並び） */
    .container {
        display: flex;
        flex: 1;
    }

    /* 左側サイドバーメニュー（これまでの画面と共通） */
    .sidebar {
        width: 220px;
        background-color: #ffffff;
        border-right: 1px solid #ddd;
        padding: 24px 20px;
        box-sizing: border-box;
    }
    .sidebar ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }
    .sidebar li {
        margin-bottom: 16px;
        color: #333;
        font-weight: bold;
    }
    .sidebar a {
        color: #0066cc;
        text-decoration: none;
        font-weight: normal;
        font-size: 14px;
    }
    .sidebar a:hover {
        text-decoration: underline;
    }
    .sub-menu {
        margin-top: 8px;
        margin-left: 15px;
    }
    .sub-menu li {
        margin-bottom: 8px;
        font-size: 14px;
        font-weight: normal;
    }

    /* 右側メインエリア */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
    }

    /* 見出し「学生情報登録」（グレーの帯） */
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

    /* 各入力項目の縦並びグループ設定 */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-bottom: 20px;
    }

    .form-group label {
        font-size: 13px;
        color: #666;
    }

    /* 入力欄（テキスト・セレクト共通の見た目） */
    .form-group input[type="text"],
    .form-group select {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
        background-color: #ffffff;
        color: #333;
    }

    /* プレースホルダーの色調整 */
    .form-group input::placeholder {
        color: #aaa;
    }

    /* 「登録して終了」ボタン（グレーの四角ボタン） */
    .btn-submit {
        background-color: #6c757d;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        padding: 8px 16px;
        font-size: 14px;
        cursor: pointer;
        margin-bottom: 15px;
    }
    .btn-submit:hover {
        background-color: #5a6268;
    }

    /* 「戻る」リンク（ボタンの下の青文字下線） */
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

    /* エラーメッセージ（バリデーション用） */
    .error-msg {
        color: #d9534f;
        font-size: 12px;
        margin-top: 2px;
    }
</style>
</head>
<body>

<div class="container">



    <!-- 右側メインエリア -->
    <div class="main-content">

        <!-- 見出し「学生情報登録」 -->
        <h2>学生情報登録</h2>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/action/StudentCreateExecute.action" method="post">
                
                <!-- 入学年度 -->
                <div class="form-group">
                    <label>入学年度</label>
                    <select name="entYear">
                        <option value="0">--------</option>
                        <c:forEach var="year" items="${entYearList}">
                            <option value="${year}" ${entYear == year ? 'selected' : ''}>${year}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty errors.entYear}">
                        <span class="error-msg">${errors.entYear}</span>
                    </c:if>
                </div>

                <!-- 学生番号 -->
                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="no" value="${no}" placeholder="学生番号を入力してください">
                    <c:if test="${not empty errors.no}">
                        <span class="error-msg">${errors.no}</span>
                    </c:if>
                </div>

                <!-- 氏名 -->
                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="${name}" placeholder="氏名を入力してください">
                    <c:if test="${not empty errors.name}">
                        <span class="error-msg">${errors.name}</span>
                    </c:if>
                </div>

                <!-- クラス -->
                <div class="form-group">
                    <label>クラス</label>
                    <select name="classNum">
                        <c:forEach var="c" items="${classList}">
                            <option value="${c}" ${classNum == c ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- パスワード（画面外で必須な場合のための隠し要素。不要なら行ごと削除してOKです） -->
                <input type="hidden" name="password" value="defaultPassword123">

                <!-- 登録ボタン -->
                <button type="submit" class="btn-submit">登録して終了</button>
            </form>
            
            <!-- 戻るリンク -->
            <div class="back-link-box">
                <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">戻る</a>
            </div>
        </div>

    </div>
</div>

<!-- フッターの読み込み -->
<%@ include file="/footer.jsp" %>

</body>
</html>
