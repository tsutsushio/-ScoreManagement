<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

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


</style>

<header>
<h1>得点管理システム</h1>
        <div class="user-info">
            ${loginUser.name} 様 
            <a href="${pageContext.request.contextPath}/action/Logout.action">ログアウト</a>
        </div>
</header>
        
