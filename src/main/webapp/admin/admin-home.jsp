<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="管理者ホーム" />
<%@ include file="/header.jsp" %>
<%@ include file="/logout-nav.jsp" %>

<style>
    /* 全体のレイアウト */
    body { 
        font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; 
        background-color: #f8f9fa; 
        margin: 0;
        padding: 40px 80px;
        color: #333;
    }

    h1 {
        font-size: 1.8rem;
        color: #2c3e50;
        margin-bottom: 30px;
        border-bottom: 2px solid #dee2e6;
        padding-bottom: 10px;
    }

    /* 成功メッセージのバッジ化 */
    .success-msg { 
        display: inline-block;
        background-color: #e7f3ff;
        color: #007bff; 
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        margin-bottom: 20px;
    }

    /* ユーザー情報のカードデザイン */
    .user-info { 
        background-color: #ffffff; 
        padding: 25px; 
        border-radius: 12px; 
        box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        border-left: 6px solid #007bff; 
        margin-bottom: 30px;
    }
    
    .user-info h2 {
        margin-top: 0;
        font-size: 1.4rem;
        color: #007bff;
    }

    .user-info ul {
        list-style: none;
        padding: 0;
        margin: 15px 0 0 0;
        display: flex;
        gap: 30px;
    }

    .user-info li {
        font-size: 0.95rem;
        color: #6c757d;
    }

    /* メニューボックス：タイル形式に変更 */
    .menu-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }

    .menu-card {
        background-color: #ffffff;
        padding: 25px;
        border-radius: 12px;
        border: 1px solid #e9ecef;
        transition: transform 0.2s, box-shadow 0.2s;
        text-align: center;
        text-decoration: none;
        color: inherit;
        display: block;
    }

    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        border-color: #007bff;
    }

    .menu-card h3 {
        margin: 0 0 10px 0;
        font-size: 1.1rem;
        color: #343a40;
    }

    .menu-card p {
        font-size: 0.85rem;
        color: #adb5bd;
        margin: 0;
    }

    /* フッターリンク */
    .footer-nav {
        margin-top: 50px;
        padding-top: 20px;
        border-top: 1px solid #dee2e6;
        display: flex;
        justify-content: flex-end;
        gap: 20px;
    }

/* 右上に固定表示するログアウトボタン */
.logout-only {
  position: fixed; /* 常に画面上部に固定 */
  top: 0;
  right: 0;       /* 画面右端に合わせる */
  height: 60px;
  display: flex;
  align-items: center;
  padding-right: 20px; /* 端からの余白 */
  z-index: 1001;        /* 他のバーより前面 */
}

/* ボタンスタイル */
.logout-only .btn-logout {
  position: relative;
  text-decoration: none;
  padding: 8px 12px;
  font-weight: 500;
  color: #dc3545;
  transition: color 0.3s;
  white-space: nowrap;
  box-sizing: border-box;
}

</style>

    <h1>Administrator Dashboard</h1>
    
    <div class="success-msg">認証済み：セッションが有効です</div>
    
    <div class="user-info">
        <h2>ようこそ、${loginUser.name} 様</h2>
        <ul>
            <li><strong>ID:</strong> ${loginUser.id}</li>
            <li><strong>権限:</strong> 管理者モード (Level ${loginUser.authorityId})</li>
        </ul>
    </div>

    <div class="menu-grid">
        <a href="${pageContext.request.contextPath}/action/StudentCreate.action" class="menu-card">
            <h3>学生の新規登録</h3>
            <p>新しい学生アカウントを発行します</p>
        </a>
        <a href="${pageContext.request.contextPath}/action/TeacherCreate.action" class="menu-card">
            <h3>教員の新規登録</h3>
            <p>新しい教員アカウントを発行します</p>
        </a>
        <a href="${pageContext.request.contextPath}/action/UserList.action" class="menu-card">
            <h3>学生・教員情報の編集・削除（一覧表示）</h3>
        </a>
        <a href="${pageContext.request.contextPath}/action/SystemManage.action" class="menu-card">
            <h3>システム設定</h3>
            <p>コースと教員の紐付け・権限管理</p>
        </a>
    </div>


<%@ include file="/footer.html" %>