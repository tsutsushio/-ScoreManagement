<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle}</title>

<style>
/* 全体 */
body {
    margin: 0;
    padding-top: 70px; /* ヘッダー分 */
    font-family: "Yu Gothic", sans-serif;
    background: #f8fbff;
}

/* 上部バー */
.top-bar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 30px;
    box-sizing: border-box;
    background: rgba(230, 240, 255, 0.9);
    backdrop-filter: blur(8px);
    border-bottom: 1px solid #c9dfff;
    z-index: 1000;
}

/* 左側（タイトル） */
.nav-left {
    font-size: 20px;
    font-weight: bold;
    color: #2d4f7c;
}

/* 右側（ユーザー情報・メニュー） */
.nav-right {
    display: flex;
    align-items: center;
    gap: 15px;
}

/* ユーザー名表示 */
.user-info {
    font-size: 14px;
    color: #2d4f7c;
    font-weight: bold;
}

/* ボタン */
.nav-btn {
    text-decoration: none;
    padding: 8px 16px;
    background: white;
    color: #2d4f7c;
    border-radius: 10px;
    border: 1px solid #bcd6ff;
    font-size: 14px;
    font-weight: bold;
    transition: 0.2s;
}

/* ホバー */
.nav-btn:hover {
    background: #dbe9ff;
    transform: translateY(-1px);
}
</style>
</head>

<body>

<!-- 上部バー -->
<div class="top-bar">

    <!-- タイトル -->
    <div class="nav-left">
        得点管理システム
    </div>

    <!-- メニュー・ユーザー情報 -->
    <div class="nav-right">
        <!-- ログインユーザー名の表示 -->
        <div class="user-info">
            ${loginUser.name} 様
        </div>
        <a href="${pageContext.request.contextPath}/action/Menu.action" class="nav-btn">ホーム</a>
        <a href="${pageContext.request.contextPath}/action/Logout.action" class="nav-btn">ログアウト</a>
    </div>

</div>

</body>
</html>