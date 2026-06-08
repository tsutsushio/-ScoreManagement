<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style>
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:20px 30px;
    background:#e9eef5;
    border-bottom:1px solid #ccc;
}

.header-title{
    font-size:32px;
    font-weight:bold;
}

.nav-right{
    display:flex;
    align-items:center;
    gap:15px;
}
</style>

<div class="header">

    <div class="header-title">
        得点管理システム
    </div>

    <div class="nav-right">

        <span class="date-display">
            <fmt:formatDate
                value="<%= new java.util.Date() %>"
                pattern="yyyy年M月d日(E)"
                timeZone="Asia/Tokyo"/>
        </span>

        <span class="user-name">
            ${loginUser.name}様
        </span>

        <a href="${pageContext.request.contextPath}/action/Menu.action"
           class="nav-btn">
            ホーム
        </a>

        <a href="${pageContext.request.contextPath}/action/Logout.action"
           class="nav-btn">
            ログアウト
        </a>

    </div>

</div>