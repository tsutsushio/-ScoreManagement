<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>
    登録完了
</title>

<style>

body {
    margin: 0;
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background:
        radial-gradient(circle at top right, rgba(0, 220, 255, 0.12), transparent 40%),
        linear-gradient(135deg, #07111f 0%, #0a1f38 35%, #0f3b63 70%, #1ec8ff 100%);
    color: #eafcff;
    min-height: 100vh;

    display: flex;
    justify-content: center;
    align-items: center;
}

/* 完了ボックス */

.done-box {

    width: 420px;

    padding: 35px;

    background:
        linear-gradient(
            180deg,
            rgba(5, 20, 40, 0.92),
            rgba(10, 35, 65, 0.9)
        );

    border:
        1px solid rgba(78, 242, 255, 0.35);

    border-radius: 14px;

    box-shadow:
        0 0 20px rgba(30, 200, 255, 0.18),
        0 10px 30px rgba(0, 0, 0, 0.35);

    text-align: center;

    backdrop-filter: blur(6px);
}

/* タイトル */

.done-box h2 {

    margin-top: 0;

    margin-bottom: 20px;

    font-size: 30px;

    letter-spacing: 2px;

    color: #ffffff;

    text-shadow:
        0 0 8px rgba(78, 242, 255, 0.8);
}

/* メッセージ */

.done-message {

    font-size: 16px;

    margin-bottom: 30px;

    color: #dffcff;
}

/* ボタンエリア */

.button-area {

    display: flex;

    justify-content: center;

    gap: 15px;
}

/* ボタン */

.button-area a {

    display: inline-block;

    background:
        linear-gradient(135deg, #00b7ff, #6ef6ff);

    color: #00111f;

    padding: 12px 22px;

    border-radius: 999px;

    text-decoration: none;

    font-size: 14px;

    font-weight: bold;

    box-shadow:
        0 0 14px rgba(110, 246, 255, 0.6);

    transition: 0.2s ease;
}

.button-area a:hover {

    transform:
        translateY(-2px)
        scale(1.03);

    box-shadow:
        0 0 20px rgba(110, 246, 255, 0.85);
}

</style>

</head>

<body>


<div class="done-box">

    <h2>
        登録完了
    </h2>

    <div class="done-message">

        ${message}

    </div>

    <div class="button-area">

        <!-- 続けて登録 -->
        <a
            href="${pageContext.request.contextPath}/action/SubjectCreate.action"
        >
            続けて登録
        </a>

        <!-- 一覧へ -->
        <a
            href="${pageContext.request.contextPath}/action/SubjectList.action"
        >
            一覧へ戻る
        </a>

    </div>

</div>

</body>
</html>