<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - メインメニュー</title>

<style>
    /* 全体 */
    body {
        margin: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #f5f7fb;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* ヘッダー */
    header {
        background-color: #e6f0ff;
        border-bottom: 2px solid #c8dcff;
        padding: 18px 32px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    header h1 {
        margin: 0;
        font-size: 28px;
        color: #333;
    }

    .user-info {
        font-size: 14px;
        color: #555;
    }

    .user-info a {
        margin-left: 16px;
        color: #0066cc;
        text-decoration: none;
        font-weight: bold;
    }

    .user-info a:hover {
        text-decoration: underline;
    }

    /* 全体レイアウト */
    .container {
        display: flex;
        flex: 1;
    }

    /* サイドバー */
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

    /* メインエリア */
    .main-content {
        flex: 1;
        padding: 40px;
        background-color: #f5f7fb;
    }

    .main-content h2 {
        margin-top: 0;
        margin-bottom: 30px;
        padding: 12px 18px;
        background-color: #ffffff;
        border-left: 6px solid #66a3ff;
        border-radius: 8px;
        color: #333;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }

    /* カード配置 */
    .card-container {
        display: flex;
        justify-content: center;
        align-items: stretch;
        gap: 30px;
        flex-wrap: wrap;
    }

    /* カード */
    .menu-card {
        width: 240px;
        min-height: 220px;
        border-radius: 16px;
        padding: 24px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        box-shadow: 0 6px 14px rgba(0,0,0,0.12);
        transition: 0.2s;
    }

    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.18);
    }

    .menu-card h3 {
        margin: 0 0 24px;
        color: #333;
        font-size: 22px;
    }

    /* カード内ボタン */
    .menu-links {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 14px;
    }

    .menu-links a {
        display: block;
        width: 100%;
        padding: 12px 0;
        text-align: center;
        background-color: rgba(255,255,255,0.9);
        color: #0066cc;
        text-decoration: none;
        border-radius: 10px;
        font-weight: bold;
        transition: 0.2s;
    }

    .menu-links a:hover {
        background-color: #ffffff;
        transform: scale(1.03);
    }

    /* カード色 */
    .card-student {
        background: linear-gradient(135deg, #f3bfd0, #e7a7be);
    }

    .card-score {
        background: linear-gradient(135deg, #cfeec7, #b8e3ad);
    }

    .card-subject {
        background: linear-gradient(135deg, #d7d7e8, #c2c2d9);
    }

    /* フッター */
    footer {
        background-color: #e0e0e0;
        text-align: center;
        padding: 14px;
        font-size: 12px;
        color: #666;
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


<div class="container">

    <!-- サイドバー -->
    <div class="sidebar">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/action/Menu.action">
                    メニュー
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/action/StudentList.action">
                    学生管理
                </a>
            </li>

            <li>
                成績管理
                <ul class="sub-menu">
                    <li><a href="#">成績登録</a></li>
                    <li><a href="#">成績参照</a></li>
                </ul>
            </li>

            <li>
                <a href="#">科目管理</a>
            </li>
        </ul>
    </div>

    <!-- メイン -->
    <div class="main-content">
        <h2>メインメニュー</h2>

        <div class="card-container">

            <!-- 学生管理 -->
            <div class="menu-card card-student">
                <h3>学生管理</h3>

                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/StudentList.action">
                        学生一覧
                    </a>
                </div>
            </div>

            <!-- 成績管理 -->
            <div class="menu-card card-score">
                <h3>成績管理</h3>

                <div class="menu-links">
                    <a href="#">成績登録</a>
                    <a href="#">成績参照</a>
                </div>
            </div>

            <!-- 科目管理 -->
            <div class="menu-card card-subject">
                <h3>科目管理</h3>

                <div class="menu-links">
                    <a href="#">科目一覧</a>
                </div>
            </div>

        </div>
    </div>

</div>

<footer>
    &copy; 2026 得点管理システム
</footer>

</body>
</html>
