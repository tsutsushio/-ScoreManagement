<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報登録</title>

<style>
/* 全体レイアウト：画面の残りの高さをすべて使う基礎構造 */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif;
    background-color: #f4f6f4; /* 全体の薄い緑背景 */
    color: #2b2d42; /* 文字色を優しいチャコールに */
}

body {
    display: flex;
    flex-direction: column; 
}

/* メインコンテナ（サイドバーとコンテンツの並び） */
.container {
    display: flex;
    flex: 1;
    width: 100%;
    align-items: stretch;
    background-color: #f4f6f4;
}

/* 左側サイドバーから独立した、右側メインエリア */
.main-content {
    flex: 1;
    padding: 40px 60px; /* 余白を贅沢に広げてプレミアムな空気感に */
    background-color: #f4f6f4;
    box-sizing: border-box;
}

/* 見出し「学生情報登録」（グレーの帯を廃止し、繊細な下線と文字のみに） */
.main-content h2 {
    margin-top: 0;
    margin-bottom: 35px;
    padding: 0 0 15px 0;
    background-color: transparent;
    border-bottom: 2px solid #edf0ee; /* 洗練された細い下線 */
    color: #2c5234; /* メインの深緑 */
    font-size: 22px;
    font-weight: 500;
    letter-spacing: 0.05em;
}

/* フォームコンテナ（「ただの入力スペース」から「プレーンな白い1枚のカード」へ） */
.form-container {
    max-width: 600px; /* 800pxから600pxに狭めることで、横に伸びすぎず入力しやすくなります */
    width: 100%;
    background-color: #ffffff; /* 白いカードとして浮き立たせる */
    border: 1px solid #edf0ee;
    border-radius: 12px; /* 角丸を大きめにして柔らかく */
    padding: 40px; /* カード内の余白をしっかり取る */
    box-sizing: border-box;
    /* 海外SaaS風の、ものすごく薄くて広い上質な影 */
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
}

/* 各入力項目の縦並びグループ設定 */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px; /* スキマを少し広げて見やすく */
    margin-bottom: 24px;
}

.form-group label {
    font-size: 11px;
    color: #8a958f; /* 馴染むニュアンスグレー */
    font-weight: 600;
    letter-spacing: 0.05em;
}

/* 入力欄（グレーの枠線をやめ、背景にうっすら色がついたフラットデザインに） */
.form-group input[type="text"],
.form-group input[type="password"],
.form-group select {
    width: 100%;
    height: 40px; /* 高さを出してスマートに */
    padding: 0 12px;
    border: 1px solid transparent; /* 通常時は線を消す */
    border-radius: 8px; /* 角丸 */
    font-size: 14px;
    box-sizing: border-box;
    background-color: #f1f3f1; /* 薄いアッシュグリーングレーの背景 */
    color: #2b2d42;
    outline: none;
    transition: all 0.25s ease;
}

/* 入力中のエフェクト：背景が白になり、グリーンの細い線が浮き出る */
.form-group input[type="text"]:focus,
.form-group input[type="password"]:focus,
.form-group select:focus {
    background-color: #ffffff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

/* プレースホルダーの色調整 */
.form-group input::placeholder {
    color: #b0b8b4; /* 背景色に合わせて少し明るいくすみグレーに */
}

/* フットエリア（ボタンと戻るリンクを並べるためのラッパー。お好みでHTMLにdiv追加等してください） */
.form-actions {
    display: flex;
    align-items: center;
    justify-content: space-between; /* ボタンを右、戻るを左にきれいに分散配置 */
    margin-top: 35px;
}

/* 「登録して終了」ボタン（フラットで洗練されたメインの深緑） */
.btn-submit {
    height: 40px;
    background-color: #2c5234; /* 一番重要なアクションなので深緑に */
    color: #ffffff;
    border: none;
    border-radius: 8px;
    padding: 0 32px; /* 横幅を少し広げて押しやすく */
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    cursor: pointer;
    box-sizing: border-box;
    transition: all 0.2s ease;
}
.btn-submit:hover {
    background-color: #1e3b24;
    box-shadow: 0 4px 12px rgba(44, 82, 52, 0.2);
}

/* 「戻る」リンク（青文字下線を廃止し、サイドバーと同じスマートなテキストリンクに） */
.back-link-box {
    margin: 0;
}
.back-link {
    color: #8a958f; /* 普段は目立たないニュアンスグレー */
    font-size: 14px;
    text-decoration: none; /* 下線を消去 */
    font-weight: 500;
    transition: color 0.2s ease;
}
.back-link:hover {
    color: #e63946; /* ホバー時は「戻る・キャンセル」を意識させる優しい赤に */
}

/* エラーメッセージ（バリデーション赤文字） */
.error-msg {
    color: #e63946; /* スタイリッシュで目に留まりやすい「くすみ赤」に変更 */
    font-size: 12px;
    margin-top: 6px;
    font-weight: 600;
}

</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

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
                        <div class="error-msg">${errors.entYear}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="no" value="${no}" placeholder="学生番号を入力してください" required>
                    <c:if test="${not empty errors.no}">
                        <div class="error-msg">${errors.no}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="${name}" placeholder="氏名を入力してください" required>
                    <c:if test="${not empty errors.name}">
                        <div class="error-msg">${errors.name}</div>
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
                    <input type="password" name="password" placeholder="パスワードを入力してください（必要な場合）">
                    <c:if test="${not empty errors.password}">
                        <div class="error-msg">${errors.password}</div>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">登録して終了</button>
            </form>
            
            <div class="back-link-box">
                <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">戻る</a>
            </div>
        </div>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>