<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<title>${pageTitle}</title>
</head>
<!-- 上部バー -->
<div class="top-bar">
  <div class="nav-left">出席管理システム</div>
</div>

<style>
/* 上部バー */
.top-bar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 60px;

  display: flex;
  align-items: center;
  justify-content: flex-start;

  padding: 0 20px; /* 画面端に余白を確保 */
  box-sizing: border-box;

  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(8px);
  border-bottom: 1px solid #ddd;

  z-index: 1000;
}

/* 左タイトル */
.nav-left {
  font-weight: bold;
  color: #333;
  font-size: 18px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* コンテンツ被り防止 */
body {
  margin-top: 60px; /* バー分の余白を確保 */
}
</style>
<body>
	<br>