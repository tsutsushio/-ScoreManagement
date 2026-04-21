<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - メインメニュー</title>
<style>
    /* 全体のリセットと基本設定 */
    body {
        font-family: sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* ヘッダーのスタイル（上部の青い帯） */
    header {
        background-color: #e6f0ff; /* 薄い青色 */
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid #b3d4ff;
    }
    header h1 {
        margin: 0;
        font-size: 24px;
        color: #333;
    }
    .user-info {
        font-size: 14px;
        color: #555;
    }
    .user-info a {
        margin-left: 15px;
        color: #0066cc;
        text-decoration: none;
    }

    /* メインコンテンツのレイアウト（サイドバーと右側コンテンツ） */
    .container {
        display: flex;
        flex: 1;
    }

    /* サイドメニューのスタイル */
    .sidebar {
        width: 200px;
        background-color: #fff;
        padding: 20px;
        border-right: 1px solid #ddd;
    }
    .sidebar ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    .sidebar li {
        margin-bottom: 10px;
    }
    .sidebar a {
        text-decoration: none;
        color: #0066cc;
        display: block;
        padding: 5px 0;
    }
    .sidebar .sub-menu {
        margin-left: 15px;
        font-size: 0.9em;
    }

    /* 右側のメインエリアのスタイル */
    .main-content {
        flex: 1;
        padding: 30px;
        background-color: #fff;
    }
    .main-content h2 {
        background-color: #f0f0f0;
        padding: 10px 15px;
        margin-top: 0;
        border-radius: 4px;
        font-size: 18px;
        color: #333;
    }

    /* カード型メニューボタンのコンテナ */
    .card-container {
        display: flex;
        gap: 20px;
        margin-top: 20px;
    }

    /* 個別のカードスタイル */
    .menu-card {
        width: 200px;
        height: 120px;
        border-radius: 8px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-decoration: none;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .menu-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }
    .menu-card a {
        color: #0066cc;
        text-decoration: none;
        font-weight: bold;
        font-size: 16px;
        margin: 5px 0;
    }

    /* 各カードの背景色（画像に近い色を設定） */
    .card-student { background-color: #eebbcc; } /* 赤紫系 */
    .card-score { background-color: #cceebb; } /* 緑系 */
    .card-subject { background-color: #ccccdd; } /* グレー青系 */

    /* フッターのスタイル */
    footer {
        background-color: #e0e0e0;
        text-align: center;
        padding: 15px;
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
            <a href="${pageContext.request.contextPath}/action/Logout.action">ログアウト</a>
        </div>
    </header>

    <div class="container">
        <div class="sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/action/Menu.action">メニュー</a></li>
                <li><a href="${pageContext.request.contextPath}/action/StudentList.action">学生管理</a></li>
                <li>成績管理
                    <ul class="sub-menu">
                        <li><a href="#">成績登録</a></li>
                        <li><a href="#">成績参照</a></li>
                    </ul>
                </li>
                <li><a href="#">科目管理</a></li>
            </ul>
        </div>

        <div class="main-content">
            <h2>メニュー</h2>
            
            <div class="card-container">
                <div class="menu-card card-student">
                    <a href="${pageContext.request.contextPath}/action/StudentList.action">学生管理</a>
                </div>
                
                <div class="menu-card card-score">
                    <a href="#">成績登録</a>
                    <a href="#">成績参照</a>
                </div>
                
                <div class="menu-card card-subject">
                    <a href="#">科目管理</a>
                </div>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2026 得点管理システム
    </footer>

</body>
</html>
