<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>成績登録</title>

<style>
/* 全体のレイアウト：既存ページと統一 */
body {
    font-family: "Yu Gothic", "Meiryo", sans-serif;
    background-color: #f5f7fb;
    display: flex;
    flex-direction: column; /* メニューに戻るボタンを上に配置するため */
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

/* フォームを囲む白いカード */
.container {
    background: white;
    padding: 40px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    width: 450px;
    box-sizing: border-box;
}

h2 {
    color: #4a90e2;
    margin-top: 0;
    margin-bottom: 25px;
    text-align: center;
    font-size: 24px;
}

/* 入力グループの調整 */
.form-group {
    margin-bottom: 18px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
    font-size: 14px;
}

/* 入力フォームの装飾 */
input[type="text"],
input[type="number"],
select {
    width: 100%;
    padding: 10px;
    border: 1px solid #dce4ec;
    border-radius: 8px;
    box-sizing: border-box;
    font-size: 16px;
    background-color: #fff;
    transition: border-color 0.2s;
}

input:focus, select:focus {
    outline: none;
    border-color: #66a3ff;
}

/* 登録ボタン */
button[type="submit"] {
    width: 100%;
    padding: 14px;
    background: #66a3ff;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
    margin-top: 10px;
}

button[type="submit"]:hover {
    background: #4d8cff;
}

/* エラーメッセージ */
.error {
    color: #e74c3c;
    font-size: 13px;
    margin-top: 4px;
    min-height: 1.2em;
}

/* メニューへ戻るリンク */
.back-link {
    margin-bottom: 20px;
    text-decoration: none;
    color: #4a90e2;
    font-size: 14px;
}

.back-link:hover {
    text-decoration: underline;
}
</style>


</head>

<body>

    <a href="${pageContext.request.contextPath}/action/Menu.action" class="back-link">
        ← メニューへ戻る
    </a>

    <div class="container">
        <h2>成績登録</h2>

        <form action="TestRegistExecute.action" method="post">
            <!-- 重複エラー等 -->
            <p class="error" style="text-align:center;">${errors.duplicate}</p>

            <div class="form-group">
                <label>学生番号</label>
                <input type="text" name="studentNo" value="${studentNo}">
                <div class="error">${errors.studentNo}</div>
            </div>

            <div class="form-group">
                <label>科目</label>
                <select name="subjectCd">
                    <option value="">--選択--</option>
                    <option value="B02" <c:if test="${subjectCd == 'B02'}">selected</c:if>>数学</option>
                    <option value="D02" <c:if test="${subjectCd == 'D02'}">selected</c:if>>英語</option>
                </select>
                <div class="error">${errors.subjectCd}</div>
            </div>

            <div class="form-group">
                <label>回数</label>
                <input type="number" name="no" value="${no}">
                <div class="error">${errors.no}</div>
            </div>

            <div class="form-group">
                <label>点数</label>
                <input type="number" name="point" value="${point}">
                <div class="error">${errors.point}</div>
            </div>

            <div class="form-group">
                <label>クラス番号</label>
                <input type="text" name="classNum" value="${classNum}">
            </div>

            <button type="submit">登録する</button>
        </form>
    </div>

</body>

</html>