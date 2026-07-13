<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
/* 上部バー（深い緑で画面最上部を引き締める） */
.top-bar {
    width: 100%;
    height: 65px; 

    display: flex;
    align-items: center;
    justify-content: space-between;

    padding: 0 40px; 
    box-sizing: border-box;

    /* ★ 背景を贅沢で深いオリーブグリーンに変更 */
    background: #2c5234; 

    border-bottom: none; /* 線を無くしてすっきりと */
    
    /* 深い色に合わせて、影も少し落ち着いたトーンに */
    box-shadow: 0 3px 15px rgba(20, 35, 25, 0.15);
    z-index: 1000;
}

/* 左側：タイトル文字（深緑に映えるクリアな白） */
.nav-left {
    font-size: 20px; 
    font-weight: 600; 
    letter-spacing: 0.06em; /* 文字間をほんの少し広げてより美しく */
    color: #ffffff !important; /* ★ 完全にクリアな白に変更 */
    margin: 0;
    padding: 0;
    background: transparent !important; 
    border: none !important;
}

/* 右側：ユーザー名とログアウトの並び */
.nav-right {
    display: flex;
    align-items: center;
    gap: 20px; 
    font-size: 14px;
}

/* ログインユーザ名（深緑の上でも優しく読める白） */
.user-name {
    color: rgba(255, 255, 255, 0.9); /* ★ ほんの少しだけ透過させた白で上品に */
    font-weight: 500;
}

/* ログアウトリンク（深緑に馴染むシースルーボタン風） */
.logout-link {
    color: rgba(255, 255, 255, 0.8); /* 普段は少し控えめな白文字 */
    text-decoration: none; 
    padding: 6px 16px;
    border: 1px solid rgba(255, 255, 255, 0.3); /* ★ うっすら見える白の枠線 */
    border-radius: 6px;
    background-color: transparent; /* 背景は透過させてヘッダーの深緑を活かす */
    font-weight: 500;
    transition: all 0.25s ease;
}

/* ログアウトボタンにマウスを乗せたとき */
.logout-link:hover {
    color: #ffffff; 
    background-color: #e63946; /* ★ ホバー時はパッと目を引く赤に変化 */
    border-color: #e63946;
    box-shadow: 0 4px 10px rgba(230, 57, 70, 0.2);
}

</style>


<div class="top-bar">

    <h1 class="nav-left">得点管理システム</h1>

    <div class="nav-right">
        <c:if test="${not empty sessionScope.loginUser and not empty sessionScope.loginUser.name and sessionScope.loginUser.name != 'null'}">
            <span class="user-name"><c:out value="${sessionScope.loginUser.name}"/>様</span>
            <a href="${pageContext.request.contextPath}/action/Logout.action" class="logout-link">ログアウト</a>
        </c:if>
    </div>

</div>