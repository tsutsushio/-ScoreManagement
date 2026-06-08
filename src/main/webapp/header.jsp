<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* header.jsp内でのbodyへのmargin/padding指定は、
   読み込み先のメイン画面全体を破壊する原因になるため削除しました 
*/

/* 上部バー（普通に上部に配置し、横幅100%） */
.top-bar {
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
}

/* 左側：タイトル文字 */
.nav-left {
    font-size: 24px;
    font-weight: bold;
    color: #2d4f7c;
    margin: 0;
    padding: 0;
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
        <%
            Object userObj = session.getAttribute("loginUser");
            boolean isLogin = false;

            if (userObj != null) {
                try {
                    String userName = String.valueOf(
                        userObj.getClass().getMethod("getName").invoke(userObj)
                    );
                    
                    if (userName != null && !userName.trim().isEmpty() && !userName.equals("null")) {
                        isLogin = true;
                    }
                } catch (Exception e) {
                    isLogin = true;
                }
            }

            if (isLogin) {
        %>
            <span class="user-name">${loginUser.name}様</span>
            <a href="Logout.action" class="logout-link">ログアウト</a>
        <%
            }
        %>
    </div>

</div>