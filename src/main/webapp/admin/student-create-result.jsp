<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="pageTitle" value="追加完了" />
<%@ include file="/header.jsp" %>

<style>
    body { font-family: 'Helvetica Neue', Arial, sans-serif; background-color: #f4f6f8; margin: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }
    .result-box { background-color: #ffffff; padding: 40px 50px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center; max-width: 500px; width: 100%; }
    .result-box h2 { color: #333; margin-top: 0; margin-bottom: 20px; font-size: 24px; border-bottom: 2px solid #e0e0e0; padding-bottom: 10px; }
    .msg { font-size: 1.1em; color: #555; margin-bottom: 30px; line-height: 1.5; }
    
    .btn-group { display: flex; flex-direction: column; gap: 15px; } /* ボタンを縦に並べる設定 */
    
    .btn { display: inline-block; padding: 12px 20px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 16px; transition: background-color 0.3s; }
    .btn-primary { background-color: #4caf50; color: white; border: 2px solid #4caf50; }
    .btn-primary:hover { background-color: #388e3c; }
    .btn-secondary { background-color: #ffffff; color: #555; border: 2px solid #ccc; }
    .btn-secondary:hover { background-color: #f0f0f0; }
</style>

<div class="result-box">
    
    <h2>${resultTitle}</h2>
    
    <p class="msg">${resultMessage}</p>
    
    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/action/StudentCreate.action" class="btn btn-primary">${retryBtnLabel}</a>
        
        <a href="${pageContext.request.contextPath}/action/AdminHome.action" class="btn btn-secondary">ホームに戻りますか？</a>
    </div>

</div>

<%@ include file="/footer.html" %>