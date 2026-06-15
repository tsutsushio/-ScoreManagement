<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
/* 上部バー（普通に上部に配置し、横幅100%） */
.top-bar {
    width: 100%;
    height: 60px;

    display: flex;
    align-items: center;
    justify-content: space-between;

    padding: 0 30px;
    box-sizing: border-box;

    /* 背景色を不透明な薄い青に統一 */
    background: #e6f0ff; 

    border-bottom: 1px solid #c9dfff;
    z-index: 1000;
}

/* 左側：タイトル文字 */
.nav-left {
    font-size: 24px;
    font-weight: bold;
    color: #2d4f7c;
    margin: 0;
    padding: 0;
    /* 他のCSSファイルからの干渉を防ぐため、背景を強制的に透明にする */
    background: transparent !important; 
    border: none !important;
}

/* 右側：ユーザー名とログアウトの並び */
.nav-right {
    display: flex;
    align-items: center;
    gap: 15px;
    font-size: 14px;
}

/* ログインユーザ名 */
.user-name {
    color: #333333;
    font-weight: bold;
}

/* ログアウトリンク */
.logout-link {
    color: #0066cc;
    text-decoration: underline;
}

.logout-link:hover {
    color: #003399;
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