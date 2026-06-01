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
    padding: 0;
    font-family: "Yu Gothic", sans-serif;
    background-color: #f4f7fb;

    display: flex;
    justify-content: center;
    align-items: center;

    min-height: 100vh;
    color: #333;
}

.done-box {
    width: 450px;

    background: #ffffff;

    padding: 35px;

    border-radius: 14px;

    box-shadow:
        0 4px 12px rgba(0,0,0,0.08);

    text-align: center;
}

.done-box h2 {
    margin: 0 0 20px;

    padding: 14px 20px;

    background: #fff;

    border-left: 6px solid #6ea8ff;

    border-radius: 10px;

    font-size: 28px;

    text-align: left;

    box-shadow:
        0 2px 8px rgba(0,0,0,0.08);
}

.done-message {
    font-size: 16px;

    color: #444;

    margin: 30px 0;
}

.button-area {
    display: flex;

    justify-content: center;

    gap: 15px;
}

.button-area a {
    display: inline-block;

    padding: 10px 22px;

    background-color: #6ea8ff;

    color: #ffffff;

    border: 2px solid #2f5fb8;

    border-radius: 8px;

    text-decoration: none;

    font-size: 14px;

    font-weight: bold;

    transition: 0.2s;
}

.button-area a:hover {
    background-color: #4a7bd8;

    box-shadow:
        0 4px 10px rgba(74,123,216,0.35);
}

@media screen and (max-width: 600px) {


    .done-box {
        width: calc(100% - 40px);
    }

    .button-area {
        flex-direction: column;
    }

    .button-area a {
        width: 100%;
        box-sizing: border-box;
    }
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