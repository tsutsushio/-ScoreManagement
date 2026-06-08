<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

    </div>

</div>