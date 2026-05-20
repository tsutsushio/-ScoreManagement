<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目新規登録</title>

<style>
body {
    margin: 0;
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background:
        radial-gradient(circle at top right, rgba(0, 220, 255, 0.12), transparent 40%),
        linear-gradient(135deg, #07111f 0%, #0a1f38 35%, #0f3b63 70%, #1ec8ff 100%);
    color: #eafcff;
    min-height: 100vh;
}

/* ヘッダー */
header {
    background:
        linear-gradient(90deg, rgba(0, 10, 25, 0.95), rgba(0, 80, 130, 0.85));
    border-bottom: 2px solid #30d8ff;
    box-shadow:
        0 0 12px rgba(48, 216, 255, 0.45),
        0 4px 20px rgba(0, 0, 0, 0.45);
    color: #ffffff;
    padding: 18px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
}

header::after {
    content: "";
    position: absolute;
    inset: 0;
    background:
        repeating-linear-gradient(
            -45deg,
            transparent 0 10px,
            rgba(255, 255, 255, 0.03) 10px 12px
        );
    pointer-events: none;
}

header h1 {
    margin: 0;
    font-size: 28px;
    font-weight: bold;
    letter-spacing: 2px;
    text-shadow:
        0 0 6px rgba(48, 216, 255, 0.9),
        0 0 18px rgba(48, 216, 255, 0.6);
}

.user-info {
    font-size: 14px;
    position: relative;
    z-index: 1;
}

.user-info a {
    color: #7ff6ff;
    margin-left: 15px;
    text-decoration: none;
    font-weight: bold;
    text-shadow: 0 0 8px rgba(127, 246, 255, 0.8);
}

.user-info a:hover {
    color: #ffffff;
    text-decoration: underline;
}

/* メイン */
.main {
    padding: 30px;
}

/* 戻るリンク */
.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: #8df8ff;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
    text-shadow: 0 0 8px rgba(141, 248, 255, 0.8);
}

.back-link a:hover {
    color: #ffffff;
    text-decoration: underline;
}

/* タイトル */
.title-area {
    background:
        linear-gradient(135deg, rgba(0, 25, 55, 0.95), rgba(0, 110, 180, 0.9));
    border-left: 6px solid #4ef2ff;
    border-right: 2px solid rgba(78, 242, 255, 0.6);
    color: #ffffff;
    padding: 18px 22px;
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 25px;
    border-radius: 0 12px 12px 0;
    box-shadow:
        0 0 18px rgba(78, 242, 255, 0.35),
        0 8px 24px rgba(0, 0, 0, 0.35);
    text-shadow: 0 0 8px rgba(78, 242, 255, 0.8);
    letter-spacing: 2px;
}

/* フォームエリア */
.form-area {
    width: 600px;
    margin: 0 auto;
    background:
        linear-gradient(180deg, rgba(5, 20, 40, 0.92), rgba(10, 35, 65, 0.9));
    border: 1px solid rgba(78, 242, 255, 0.35);
    padding: 30px;
    border-radius: 14px;
    box-shadow:
        0 0 20px rgba(30, 200, 255, 0.18),
        0 10px 30px rgba(0, 0, 0, 0.35);
    box-sizing: border-box;
    backdrop-filter: blur(6px);
}

/* 入力行 */
.form-row {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.form-row label {
    width: 120px;
    font-weight: bold;
    color: #ffffff;
    text-shadow: 0 0 6px rgba(95, 246, 255, 0.7);
}

.form-row input[type="text"] {
    flex: 1;
    padding: 12px;
    font-size: 14px;
    color: #eafcff;
    background-color: rgba(0, 20, 40, 0.85);
    border: 1px solid rgba(95, 246, 255, 0.35);
    border-radius: 6px;
    box-sizing: border-box;
    box-shadow: inset 0 0 8px rgba(0, 0, 0, 0.35);
    outline: none;
    transition: 0.2s ease;
}

.form-row input[type="text"]:focus {
    border-color: #7ff6ff;
    box-shadow:
        0 0 10px rgba(127, 246, 255, 0.6),
        inset 0 0 8px rgba(0, 0, 0, 0.35);
}

/* エラー表示 */
.error {
    color: #ff8ab8;
    font-weight: bold;
    margin-bottom: 20px;
    text-shadow: 0 0 8px rgba(255, 138, 184, 0.7);
}

/* ボタンエリア */
.button-area {
    text-align: center;
    margin-top: 30px;
}

/* 登録ボタン */
.button-area input {
    display: inline-block;
    background: linear-gradient(135deg, #00b7ff, #6ef6ff);
    color: #00111f;
    padding: 10px 30px;
    border: none;
    border-radius: 999px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 0 14px rgba(110, 246, 255, 0.6);
    transition: 0.2s ease;
}

.button-area input:hover {
    transform: translateY(-2px) scale(1.03);
    box-shadow: 0 0 20px rgba(110, 246, 255, 0.85);
}

/* 戻るボタン */
.button-area a {
    display: inline-block;
    padding: 10px 30px;
    margin-left: 10px;
    font-size: 14px;
    font-weight: bold;
    text-decoration: none;
    color: #eafcff;
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(95, 246, 255, 0.3);
    border-radius: 999px;
    transition: 0.2s ease;
}

.button-area a:hover {
    background: rgba(95, 246, 255, 0.12);
    color: #ffffff;
    box-shadow: 0 0 12px rgba(95, 246, 255, 0.4);
}
</style>
</head>

<body>

<header>
    <h1>得点管理システム</h1>

    <div class="user-info">
        ${loginUser.name} 様
        <a href="${pageContext.request.contextPath}/action/Logout.action">
            ログアウト
        </a>
    </div>
</header>

<div class="main">

    <!-- 左上の戻るリンク -->
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/action/SubjectList.action">
            ← 科目一覧へ戻る
        </a>
    </div>

    <!-- タイトル -->
    <div class="title-area">
        科目新規登録
    </div>

    <!-- フォーム -->
    <div class="form-area">

        <!-- エラーメッセージ -->
        <c:if test="${not empty errorMessage}">
            <div class="error">
                ${errorMessage}
            </div>
        </c:if>

        <!-- 登録フォーム -->
        <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.action"
              method="post">

            <div class="form-row">
                <label for="cd">科目コード</label>
                <input type="text"
                       id="cd"
                       name="cd"
                       value="${cd}"
                       maxlength="3"
                       required>
            </div>

            <div class="form-row">
                <label for="name">科目名</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${name}"
                       maxlength="50"
                       required>
            </div>

            <!-- ボタン -->
            <div class="button-area">
                <input type="submit" value="登録">

                <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                    戻る
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>