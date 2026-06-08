<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報変更</title>
<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #f4f7f9;
    color: #333;
}

body {
    display: flex;
    flex-direction: column; /* 上からヘッダー、コンテンツの順 */
}

/* 全体レイアウト（サイドバーとメインコンテンツの横並びコンテナ） */
.container {
    display: flex;
    flex: 1;            /* 画面の残りの高さをすべて使う */
    width: 100%;
    align-items: stretch;
}

/* メインエリア：この中でフォームを中央寄せにする */
.main-content {
    flex: 1;
    padding: 40px 20px;
    box-sizing: border-box;
    background-color: #f4f7f9;
    
    /* フォームと戻るリンクを中央に集めるための設定 */
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 戻るリンクをカードの幅（450px）に合わせて左側に配置 */
.back-link { 
    display: inline-block;
    margin-bottom: 15px; 
    text-decoration: none; 
    color: #3498db; 
    font-size: 14px;
    font-weight: bold;
    transition: color 0.2s;
    align-self: center; /* 親の中央寄せに追従させつつ、幅をカードと同期 */
    max-width: 450px;
    width: 100%;
}

.back-link:hover { 
    color: #2980b9;
    text-decoration: underline;
}

/* フォーム全体を包むカード */
.form-container {
    background: #ffffff;
    padding: 35px 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    width: 100%;
    max-width: 450px;
    box-sizing: border-box;
}

/* タイトルヘッダー */
h2 { 
    font-size: 22px;
    color: #2c3e50;
    margin-top: 0;
    margin-bottom: 25px;
    text-align: center;
    padding-bottom: 12px;
    border-bottom: 2px solid #f4f7f9;
}

.form-group { 
    margin-bottom: 20px; 
}

label { 
    font-size: 14px;
    font-weight: bold;
    color: #34495e;
    display: inline-block;
    margin-bottom: 8px; 
}

/* 変更不可の項目（入学年度・学生番号） */
.readonly-text {
    font-size: 16px;
    color: #7f8c8d;
    margin: 0;
    padding: 8px 12px;
    background-color: #f8f9fa;
    border-radius: 6px;
    border: 1px dashed #cfd8dc;
}

/* 入力フォーム・セレクトボックス */
.form-group input[type="text"], 
.form-group select {
    width: 100%;
    height: 42px;
    padding: 0 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fff;
    box-sizing: border-box;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.form-group input[type="text"]:focus,
.form-group select:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    outline: none;
}

/* 在学中チェックボックス */
.checkbox-group {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    margin-bottom: 25px;
    padding: 5px 0;
}

.checkbox-group label {
    margin-bottom: 0;
    cursor: pointer;
}

.checkbox-group input[type="checkbox"] {
    width: 18px;
    height: 18px;
    cursor: pointer;
    accent-color: #3498db;
}

/* エラーメッセージ */
.error-msg {
    color: #e74c3c;
    font-size: 13px;
    display: block;
    margin-top: 6px;
    font-weight: 500;
}

/* 変更ボタン */
.btn-submit {
    width: 100%;
    height: 45px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
}

.btn-submit:hover { 
    background-color: #2980b9; 
}

/* 削除ボタン用フォームの調整 */
form[action*="StudentDelete.action"] {
    border-top: 1px dashed #e2e8f0;
    margin-top: 25px !important;
    padding-top: 20px;
}

/* 削除ボタン本体 */
form[action*="StudentDelete.action"] button {
    width: 100%;
    height: 40px;
    background-color: #fff !important;
    color: #e74c3c !important;
    border: 1px solid #e74c3c !important;
    border-radius: 6px !important;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: all 0.2s;
}

form[action*="StudentDelete.action"] button:hover {
    background-color: #e74c3c !important;
    color: #fff !important;
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">←ホームに戻る</a>

        <div class="form-container">
            <h2>学生情報変更</h2>

            <form action="${pageContext.request.contextPath}/action/StudentUpdateExecute.action" method="post">
                
                <div class="form-group">
                    <label>入学年度</label>
                    <p class="readonly-text">${student.entYear}</p>
                    <input type="hidden" name="entYear" value="${student.entYear}">
                </div>

                <div class="form-group">
                    <label>学生番号</label>
                    <p class="readonly-text">${student.no}</p>
                    <input type="hidden" name="no" value="${student.no}">
                </div>

                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="${student.name}" required>
                    <c:if test="${not empty errors.name}">
                        <span class="error-msg">${errors.name}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>クラス</label>
                    <select name="classNum">
                        <c:forEach var="c" items="${classList}">
                            <option value="${c}" ${student.classNum == c ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="checkbox-group">
                    <label>在学中</label>
                    <input type="checkbox" name="isAttend" value="true" ${student.isAttend ? 'checked' : ''}>
                </div>

                <button type="submit" class="btn-submit">変更</button>
            </form>
            
            <form action="${pageContext.request.contextPath}/action/StudentDelete.action" method="post" onsubmit="return confirm('本当にこの学生データを削除してよろしいですか？\n※この操作は取り消せません。');">
                <input type="hidden" name="no" value="${student.no}">
                <button type="submit">削除する</button>
            </form>
        </div>

    </div> </div> </body>
</html>