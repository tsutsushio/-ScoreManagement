<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績登録</title>

<style>
/* 全体のベーススタイル */
/* 1. body全体を縦並びのFlexboxにする */
body {
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #f8f9fa;
    color: #333333;
    margin: 0;
    padding: 20px 20px 0 20px; /* 下側の余白を0にします */
    
    /* ーーー ここから追加 ーーー */
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* 画面全体の高さを最低基準にする */
    box-sizing: border-box;
    /* ーーーーーーーーーーーーーー */
}

/* 2. メインコンテンツのコンテナを伸縮させる */
.container {
    max-width: 1000px;
    margin: 0 auto;
    width: 100%;
    
    /* ーーー ここから追加 ーーー */
    flex: 1; /* 余ったスペースをすべて埋めてフッターを押し下げる */
    /* ーーーーーーーーーーーーーー */
}

/* 3. フッター自体のスタイリング（追加） */
footer, 
#footer { /* JSP側でインクルードされているフッターの要素名に合わせてください */
    width: 100%;
    background-color: #f1f1f1; /* 背景色（画像に合わせた薄いグレー） */
    padding: 15px 0;
    text-align: center;
    font-size: 13px;
    color: #666666;
    margin-top: 40px; /* コンテンツとの間に最低限あける隙間 */
    box-sizing: border-box;
}

/* 戻るリンク */
.back-link {
    display: inline-block;
    color: #666666;
    text-decoration: none;
    font-size: 14px;
    margin-bottom: 20px;
}
.back-link:hover {
    text-decoration: underline;
}

/* コンテナ */
.container {
    max-width: 1000px;
    margin: 0 auto;
}

/* 画面タイトル (成績管理 / 成績登録) */
h2 {
    font-size: 20px;
    font-weight: bold;
    background-color: #f1f1f1;
    padding: 12px 20px;
    margin: 0 0 20px 0;
    border-radius: 4px;
    color: #333333;
}

/* 検索フォームエリア */
.search-form {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-end;
    gap: 15px;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 4px;
    padding: 20px;
    margin-bottom: 30px;
}

.search-item {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.search-item label {
    font-size: 14px;
    color: #666666;
}

/* 入力・選択コントロール共通 */
.search-item select,
.search-item input[type="number"] {
    height: 36px;
    padding: 0 10px;
    border: 1px solid #cccccc;
    border-radius: 4px;
    font-size: 15px;
    background-color: #ffffff;
    min-width: 100px;
    box-sizing: border-box;
}

/* 科目セレクトボックスの幅を広めに調整 */
.search-item select[name="subjectCd"] {
    min-width: 200px;
}

/* 検索ボタン */
.search-button button {
    height: 36px;
    padding: 0 20px;
    background-color: #555555;
    color: #ffffff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}
.search-button button:hover {
    background-color: #333333;
}

/* エラーメッセージ */
.error-msg {
    color: #de3545;
    background-color: #fbebeb;
    border: 1px solid #f5c6cb;
    padding: 10px 15px;
    border-radius: 4px;
    margin-bottom: 15px;
    font-size: 14px;
}

/* 検索結果ボックス内のタイトルを通常の文字に変更 */
.result-box h2 {
    all: unset;
    display: block;
    font-size: 15px;
    color: #333333;
    margin-bottom: 15px;
}

/* 一覧テーブルスタイル */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    font-size: 15px;
}

table th, table td {
    padding: 12px 10px;
    text-align: left;
    vertical-align: middle;
}

/* ヘッダー行 */
table th {
    font-weight: bold;
    color: #333333;
    border-bottom: 1px solid #333333;
}

/* データ行 */
table td {
    border-bottom: 1px solid #e0e0e0;
    color: #444444;
}

/* 点数入力ボックス */
table input[type="number"] {
    width: 140px;
    height: 32px;
    padding: 0 8px;
    border: 1px solid #cccccc;
    border-radius: 4px;
    font-size: 15px;
    box-sizing: border-box;
}

/* 登録して終了ボタン */
.register-btn {
    margin-top: 20px;
}

.register-btn button {
    height: 38px;
    padding: 0 20px;
    background-color: #6c757d;
    color: #ffffff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.register-btn button:hover {
    background-color: #5a6268;
}

/* 該当者なしメッセージ */
.no-result {
    color: #666666;
    font-size: 15px;
    padding: 10px 0;
}

</style>
</head>

<body>

<a href="${pageContext.request.contextPath}/action/Menu.action"
   class="back-link">
    ← メニューへ戻る
</a>

<div class="container">

    <h2>成績登録</h2>

    <form action="TestSearch.action"
          method="post"
          class="search-form">

        <div class="search-item">
            <label>入学年度</label>

            <select name="entYear" required>
                <option value="">--選択--</option>

                <c:forEach var="year" items="${entYearList}">
                    <option value="${year}"
                        <c:if test="${year == fEntYear}">
                            selected
                        </c:if>>
                        ${year}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="search-item">
            <label>クラス</label>

            <select name="classNum" required>
                <option value="">--選択--</option>

                <c:forEach var="cNum" items="${classList}">
                    <option value="${cNum}"
                        <c:if test="${cNum == fClassNum}">
                            selected
                        </c:if>>
                        ${cNum}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="search-item">
            <label>科目</label>

            <select name="subjectCd" required>
                <option value="">--選択--</option>

                <c:forEach var="subject" items="${subjectList}">
                    <option value="${subject.cd}"
                        <c:if test="${subject.cd == fSubjectCd}">
                            selected
                        </c:if>>
                        ${subject.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="search-item">
            <label>回数</label>

            <input
                type="number"
                name="no"
                min="1"
                required
                value="${fNo}">
        </div>

        <div class="search-button">
            <button type="submit">
                検索
            </button>
        </div>

    </form>

    <c:if test="${not empty testList}">

        <div class="result-box">

            <h2>検索結果</h2>

            <c:if test="${not empty errors.point}">
                <div class="error-msg">
                    ${errors.point}
                </div>
            </c:if>

            <form action="TestRegistExecute.action"
                  method="post">

                <table>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>点数</th>
                    </tr>

                    <c:forEach var="test" items="${testList}">
                        <tr>
                            <td>${test.student.entYear}</td>
                            <td>${test.classNum}</td>
                            <td>${test.student.no}</td>
                            <td>${test.student.name}</td>
                            <td>
                                <input
                                    type="number"
                                    name="point_${test.student.no}"
                                    value="${test.point}"
                                    min="0"
                                    max="100">
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <input
                    type="hidden"
                    name="subjectCd"
                    value="${fSubjectCd}">

                <input
                    type="hidden"
                    name="no"
                    value="${fNo}">

                <input
                    type="hidden"
                    name="classNum"
                    value="${fClassNum}">

                <div class="register-btn">
                    <button type="submit">
                        登録して終了
                    </button>
                </div>

            </form>

        </div>

    </c:if>

    <c:if test="${testList != null and empty testList}">
        <div class="result-box">
            <h2>検索結果</h2>
            <p class="no-result">該当者がいません</p>
        </div>
    </c:if>
    

</div>
    <%@ include file="/footer.jsp" %>
</body>
</html>