<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="jakarta.tags.core" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績参照</title>

<style>
/* 全体のベーススタイル */
body {
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #ffffff;
    color: #333333;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    box-sizing: border-box;
}

/* ラッパー・コンテナ */
.main-wrapper {
    flex: 1;
    width: 100%;
    max-width: 1100px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
}

.container {
    width: 100%;
}

/* 戻るリンク */
.back-link {
    display: inline-block;
    color: #0066cc;
    text-decoration: underline;
    font-size: 14px;
    margin-bottom: 15px;
}

/* ① 画面タイトル (成績一覧 / 成績参照) */
h2 {
    font-size: 20px;
    font-weight: bold;
    background-color: #f1f1f1;
    padding: 12px 20px;
    margin: 0 0 20px 0;
    border-radius: 4px;
    color: #333333;
}

/* 検索エリア全体の外枠 */
.search-box {
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    padding: 25px;
    margin-bottom: 30px;
    background-color: #ffffff;
}

/* 「科目情報」「学生情報」の左側ラベル */
.search-box h3 {
    font-size: 14px;
    color: #666666;
    margin: 0;
    width: 120px;
    flex-shrink: 0;
    padding-top: 28px; /* 入力欄と高さを合わせるための微調整 */
    font-weight: normal;
}

/* 検索フォームの横並び設定 (Flexbox) */
.search-form, 
.student-form {
    display: flex;
    align-items: flex-end;
    gap: 15px;
    flex-wrap: wrap;
    margin-top: -20px; /* 見出しとの並び調整用 */
}

/* フォームを囲うラッパー（見出しと入力欄を横並びにする場合） */
/* ※画像のように「科目情報」の右側に入力欄を並べるため、Flexboxを適用 */
.search-box > form {
    display: flex;
    align-items: flex-end;
}

/* 各入力項目の縦並び設定 */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.form-group label {
    font-size: 13px;
    color: #888888;
    text-align: center; /* ヘッダーの文字を中央寄せに */
}

/* セレクトボックス・テキスト入力の共通デザイン */
.form-group select,
.student-no {
    height: 34px;
    padding: 0 10px;
    border: 1px solid #cccccc;
    border-radius: 4px;
    font-size: 14px;
    background-color: #ffffff;
    box-sizing: border-box;
    min-width: 100px;
}

/* 科目選択ボックスの幅を広く設定 */
select[name="f3"] {
    min-width: 240px;
}

/* 学生番号入力ボックスの幅 */
.student-no {
    min-width: 200px;
}
.student-no::placeholder {
    color: #bbbbbb;
}

/* 検索ボタン */
.search-form button,
.student-form button {
    height: 34px;
    padding: 0 20px;
    background-color: #555555;
    color: #ffffff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-left: 10px;
}
.search-form button:hover,
.student-form button:hover {
    background-color: #333333;
}

/* フォーム間の区切り線 */
.divider {
    border: none;
    border-top: 1px solid #eeeeee;
    margin: 25px 0;
}

/* 初期表示の青い案内メッセージ */
.initial-msg {
    color: #0099cc; /* 画像のような鮮やかな青色 */
    font-size: 13px;
    margin-top: 20px;
    margin-bottom: 0;
    padding-left: 5px;
}

/* ① 入学年度とクラスと科目を選択してください（オレンジのエラー文字用） */
.error {
    color: #ff9900; /* 画像のようなオレンジ・薄い赤色 */
    font-size: 13px;
    margin-top: 15px;
    margin-bottom: 0;
    padding-left: 5px;
}

/* ② 学生情報が存在しませんでした（下部のエラー文字用） */
/* ※JSPの下部にある <p class="error">${error}</p> に自動適用されます */


/* ーーー テーブルスタイル ーーー */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 14px;
}

table th, table td {
    padding: 12px 10px;
    text-align: left;
}

/* ヘッダー行の下線 */
table th {
    font-weight: bold;
    color: #333333;
    border-bottom: 2px solid #333333;
}

/* データ行の薄い下線 */
table td {
    border-bottom: 1px solid #eeeeee;
    color: #555555;
}

/* ーーー フッターの最下部固定 ーーー */
footer, #footer {
    width: 100%;
    background-color: #f1f1f1;
    padding: 15px 0;
    text-align: center;
    font-size: 13px;
    color: #666666;
    margin-top: auto;
    border-top: 1px solid #e0e0e0;
    box-sizing: border-box;
}

</style>

</head>

<body>
    <!-- 💡 画面全体を包むwrapperを追加（ヘッダー・フッターとの縦並びを正常化） -->
    <div class="main-wrapper">
        
        <!-- 戻るボタンを相対配置で収めるためにcontainerの内側に移動、またはwrapper直下に配置 -->
        <a href="${pageContext.request.contextPath}/action/Menu.action" class="back-link">
            ← メニューへ戻る
        </a>

        <div class="container">
            <h2>成績参照</h2>

            <div class="search-box">
                <h3>科目情報</h3>

                <!-- 科目検索 -->
                <form action="TestList.action" method="post" class="search-form">
                    <input type="hidden" name="f" value="sj">

                    <div class="form-group">
                        <label>入学年度</label>
                        <select name="f1">
                            <option value="">--------</option>
                            <c:forEach items="${yearList}" var="year">
                                <option value="${year}">${year}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>クラス</label>
                        <select name="f2">
                            <option value="">--------</option>
                            <c:forEach items="${classList}" var="cls">
                                <option value="${cls}">${cls}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>科目</label>
                        <select name="f3">
                            <option value="">--------</option>
                            <c:forEach items="${subjectList}" var="sub">
                                <option value="${sub.cd}">${sub.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="submit">検索</button>
                </form>

                <hr class="divider">

                <h3>学生情報</h3>

                <!-- 学生番号検索 -->
                <form action="TestList.action" method="post" class="student-form">
                    <input type="hidden" name="f" value="sj">
                    <!-- 科目情報引き継ぎ -->
                    <input type="hidden" name="f1" value="${param.f1}">
                    <input type="hidden" name="f2" value="${param.f2}">
                    <input type="hidden" name="f3" value="${param.f3}">

                    <div class="form-group">
                        <label>学生番号</label>
                        <input type="text" name="f4" class="student-no" placeholder="学生番号を入力" value="${param.f4}">
                    </div>

                    <button type="submit">検索</button>
                </form>
            </div>
            <!-- 💡 検索ボタンを押す前（結果もエラーもない初期状態）だけメッセージを表示 -->
<c:if test="${empty testList and empty error}">
    <p class="initial-msg">
        科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
    </p>
</c:if>
            

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>

            <c:if test="${not empty testList}">
                <table>
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>回数</th>
                            <th>点数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${testList}" var="test">
                            <tr>
                                <td>${test.student.entYear}</td>
                                <td>${test.classNum}</td>
                                <td>${test.student.no}</td>
                                <td>${test.student.name}</td>
                                <td>${test.no}</td>
                                <td>${test.point}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div> <!-- .container の閉じタグ -->
    </div> <!-- .main-wrapper の閉じタグ -->

    <%@ include file="/footer.jsp" %>
</body>
</html>

