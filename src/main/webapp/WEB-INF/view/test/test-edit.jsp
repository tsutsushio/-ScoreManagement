<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績編集</title>

<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background-color: #f5f7fb;
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
    background-color: #f5f7fb;
    overflow-y: auto;   /* コンテンツが溢れた場合は右側だけスクロール */
    
    /* フォームと戻るリンクを中央に集めるための設定 */
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 戻るリンクをカードの幅（600px）に合わせて配置 */
.back-link {
    margin-bottom: 20px;
    text-decoration: none;
    color: #4a90e2;
    font-size: 14px;
    align-self: center; /* 親の中央寄せに追従させつつ、幅をカードと同期 */
    max-width: 600px;
    width: 100%;
}

.back-link:hover {
    text-decoration: underline;
}

/* 白いカード（クラス名競合防止のため .container から変更） */
.form-container {
    background: white;
    padding: 40px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 600px;
    box-sizing: border-box;
}

/* タイトル */
h2 {
    color: #4a90e2;
    margin-top: 0;
    margin-bottom: 25px;
    text-align: center;
    font-size: 24px;
}

/* フォームの各項目を囲むエリア */
.form-group {
    margin-bottom: 25px;
}

/* ラベル */
label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #555;
    font-size: 14px;
}

/* 入力フォーム */
input[type="text"],
input[type="number"],
select {
    width: 100%;
    padding: 12px;
    border: 1px solid #dce4ec;
    border-radius: 8px;
    box-sizing: border-box;
    font-size: 16px;
    background-color: #fff;
    transition: border-color 0.2s;
}

input:focus,
select:focus {
    outline: none;
    border-color: #66a3ff;
}

/* 登録ボタン */
.submit-btn {
    display: flex;
    justify-content: center;
    margin-top: 30px;
}

button[type="submit"] {
    padding: 12px 20px;
    background: #66a3ff;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
    width: 100%;
}

button[type="submit"]:hover {
    background: #4d8cff;
}

/* エラーメッセージ（入力欄の下に出す用） */
.error-text {
    color: #e74c3c;
    font-size: 13px;
    font-weight: bold;
    margin-top: 5px;
}
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <a href="${pageContext.request.contextPath}/action/Menu.action" class="back-link">
            ← メニューへ戻る
        </a>

        <div class="form-container">
            <h2>成績編集</h2>

            <form action="TestEditExecute.action" method="post">

                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="studentNo" value="${studentNo}" maxlength="10" required>
                    <div class="error-text">${errors.studentNo}</div>
                </div>

                <div class="form-group">
                    <label>科目</label>
                    <select name="subjectCd" required>
                        <option value="">--選択--</option>
                        
                        <c:forEach var="subject" items="${subjectList}">
                            <option value="${subject.cd}" <c:if test="${subject.cd == subjectCd}">selected</c:if>>
                                ${subject.name}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="error-text">${errors.subjectCd}</div>
                </div>

                <div class="form-group">
                    <label>回数</label>
                    <input type="number" name="no" value="${no}" min="1" required>
                    <div class="error-text">${errors.no}</div>
                </div>

                <div class="form-group">
                    <label>点数</label>
                    <input type="number" name="point" value="${point}" min="0" max="100" required>
                    <div class="error-text">${errors.point}</div>
                </div>

                <div class="form-group">
                    <label>クラス番号</label>
                    <input type="text" name="classNum" value="${classNum}" maxlength="5" required>
                    <div class="error-text">${errors.classNum}</div>
                </div>

                <div class="submit-btn">
                    <button type="submit">更新する</button>
                </div>
                
            </form>
        </div> </div> </div> </body>
</html>