<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>

<style>

body {
    font-family: "Yu Gothic", sans-serif;
    background-color: #f5f7fb;
    margin: 0;
    
    /* 💡 画面全体を縦並びのフレックスボックスにする */
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* height から min-height に変更 */
}

/* 💡 中央のボックスを画面の真ん中に配置するための外枠 */
.main-wrapper {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px 0;
}

.done-box{
    background:white;
    padding:40px;
    border-radius:16px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    text-align:center;
    width:400px;
}

/* 💡 2つのボタンが縦に並ぶように微調整 */
.done-box a {
    display: block; /* inline-block から block に変更 */
    margin: 10px auto; /* ボタン上下に隙間を作る */
    width: fit-content;
    padding: 12px 24px;
    background:#66a3ff;
    color:white;
    text-decoration:none;
    border-radius:10px;
    transition:0.2s;
}

.done-box{
    background:white;
    padding:40px;
    border-radius:16px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    text-align:center;
    width:400px;
}

.done-box h2{
    color:#4a90e2;
    margin-bottom:20px;
}

.done-box p{
    font-size:18px;
    margin-bottom:30px;
}

.done-box a{
    display:inline-block;
    padding:12px 24px;
    background:#66a3ff;
    color:white;
    text-decoration:none;
    border-radius:10px;
    transition:0.2s;
}

.done-box a:hover{
    background:#4d8cff;
}

</style>

</head>
<body>

<!-- 💡 wrapper で囲うことで、コンテンツが画面中央に配置されます -->
<div class="main-wrapper">
    <div class="done-box">
        <h2>登録完了</h2>
        <p>成績を登録しました！</p>
        
        <a href="${pageContext.request.contextPath}/action/Menu.action">
            メニューへ戻る
        </a>
        <a href="${pageContext.request.contextPath}/action/TestRegist.action">
            続けて登録
        </a>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>