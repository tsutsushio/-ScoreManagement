<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;

    background:#e9eef5;

    border-bottom:1px solid #ccc;

    padding:20px 30px;
}

.header-title{
    font-size:36px;
    font-weight:bold;
}

.header-menu{
    display:flex;
    align-items:center;
    gap:20px;
}

.user-name{
    color:#333;
}

.header-menu a{
    color:#3366cc;
    text-decoration:none;
}

.header-menu a:hover{
    text-decoration:underline;
}

</style>


<div class="header">

    <div class="header-title">
<!-- 上部バー -->
<div class="top-bar">
    <!-- 左側：タイトル -->
    <div class="nav-left">
        得点管理システム
    </div>

    <div class="header-menu">

        <span class="user-name">
            ${loginUser.name}様
        </span>

        <a href="${pageContext.request.contextPath}/action/Menu.action">
            ホーム
        </a>

        <a href="${pageContext.request.contextPath}/action/Logout.action">
            ログアウト
        </a>

    <!-- 右側：ユーザー情報とログアウトボタン -->
    <div class="nav-right">
        <span class="date-display">
            <fmt:formatDate value="<%= new java.util.Date() %>"
                            pattern="yyyy年M月d日（E）"
                            timeZone="Asia/Tokyo" />
        </span>
        
        <span>${loginUser.name} 様</span>
                <a href="${pageContext.request.contextPath}/action/Menu.action" class="nav-btn">
            ホーム
        </a>
        <a href="${pageContext.request.contextPath}/action/Logout.action"  class="nav-btn">
            ログアウト
        </a>
    </div>

</div>

</body>
</html>