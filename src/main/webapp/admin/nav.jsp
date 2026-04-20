<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<div class="nav-right">
    <a href="${pageContext.request.contextPath}/action/AdminHome.action" class="nav-btn">HOME</a>
	<a href="${pageContext.request.contextPath}/action/Logout.action" class="nav-btn logout-btn">ログアウト</a>
</div>

<style>
	/* 右側ナビ */
	.nav-right {
	  position: fixed; /* 常に画面上部に固定 */
	  top: 0;
	  right: 0; /* 画面右端に合わせる */
	  height: 60px;
	  display: flex;
	  align-items: center;
	  gap: 12px;
	  padding-right: 20px; /* 余白 */
	  z-index: 1001; /* headerより前面 */
	}
	
	/* ボタン共通 */
	.nav-btn {
	  position: relative;
	  text-decoration: none;
	  padding: 8px 12px;
	  font-weight: 500;
	  color: #666;
	  transition: color 0.3s;
	  white-space: nowrap;
	  box-sizing: border-box;
	}
	
	/* 下線スライド */
	.nav-btn::after {
	  content: "";
	  position: absolute;
	  left: 0;
	  bottom: 0;
	  width: 0%;
	  height: 2px;
	  background-color: currentColor;
	  transition: width 0.3s;
	}
	
	.nav-btn:hover {
	  color: #333;
	}
	
	.nav-btn:hover::after {
	  width: 100%;
	}
	
	/* ログアウト色調整 */
	.logout-btn {
	  color: #dc3545;
	}
	
	.logout-btn:hover {
	  color: #a71d2a;
	}
</style>