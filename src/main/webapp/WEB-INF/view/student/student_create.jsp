<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報登録</title>
<style>
/* 全体：メインメニューと同じく縦いっぱいに広げる基礎を作る */
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

/* タイトルをカードの中に収まるように一旦非表示に */
h2 {
    display: none;
}

/* フォーム全体を包むカード（中央揃えのメイン枠） */
.form-container {
    background: #ffffff;
    padding: 35px 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    width: 100%;
    max-width: 450px; /* 変更画面と同じ幅に統一 */
    box-sizing: border-box;
}

/* カードの先頭にタイトルを美しく配置するための疑似要素 */
.form-container::before {
    content: "学生情報登録";
    display: block;
    font-size: 22px;
    font-weight: bold;
    color: #2c3e50;
    text-align: center;
    padding-bottom: 12px;
    margin-bottom: 25px;
    border-bottom: 2px solid #f4f7f9;
}

.form-group { 
    margin-bottom: 20px; 
}

.form-group label { 
    display: inline-block; 
    font-size: 14px;
    font-weight: bold; 
    margin-bottom: 8px; 
    color: #34495e; 
}

/* テキスト入力・パスワード・セレクトボックスをすべて統一 */
.form-group input[type="text"], 
.form-group input[type="password"], 
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

/* プレースホルダーの文字色を少し薄くして見やすく */
.form-group input::placeholder {
    color: #b0bec5;
}

.form-group input:focus,
.form-group select:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    outline: none;
}

/* エラーメッセージ（赤文字） */
.error-msg {
    color: #e74c3c;
    font-size: 13px;
    display: block;
    margin-top: 6px;
    font-weight: 500;
}

/* 登録ボタン */
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
    margin-top: 10px;
}

.btn-submit:hover { 
    background-color: #2980b9; 
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">戻る</a>

        <h2>学生情報登録</h2>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/action/StudentCreateExecute.action" method="post">
                
                <div class="form-group">
                    <label>入学年度</label>
                    <select name="entYear">
                        <option value="0">--------</option>
                        <c:forEach var="year" items="${entYearList}">
                            <option value="${year}" ${entYear == year ? 'selected' : ''}>${year}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty errors.entYear}">
                        <span class="error-msg">${errors.entYear}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="no" value="${no}" placeholder="学生番号を入力してください">
                    <c:if test="${not empty errors.no}">
                        <span class="error-msg">${errors.no}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="${name}" placeholder="氏名を入力してください">
                    <c:if test="${not empty errors.name}">
                        <span class="error-msg">${errors.name}</span>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>クラス</label>
                    <select name="classNum">
                        <c:forEach var="c" items="${classList}">
                            <option value="${c}" ${classNum == c ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>パスワード</label>
                    <input type="password" name="password" placeholder="パスワードを入力してください">
                    <c:if test="${not empty errors.password}">
                        <span class="error-msg">${errors.password}</span>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">登録</button>
            </form>
        </div>

    </div> </div> </body>
</html>