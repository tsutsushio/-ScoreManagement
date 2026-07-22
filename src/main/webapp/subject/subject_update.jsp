<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目変更</title>

<style>
/* 全体：画面縦幅いっぱいのベースを作る */
html, body {
    height: 100%; /* 古いブラウザ用のフォールバック */
    margin: 0;
    padding: 0;
    /* フォントをモダンで美しい文字の並びに変更 */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #fafbfc; /* 明るく清潔感のあるモダンな背景 */
    color: #2b2d42; /* 文字色を優しい黒にして洗練された印象に */
}

body {
    display: flex;
    flex-direction: column; /* 上からヘッダー、メイン、フッターの順 */
    min-height: 100vh; /* ⚡フッター固定用：画面の縦幅を最低100%確保 */
}

/* 全体レイアウト（サイドバーとメインコンテンツの並び） */
.container {
    display: flex;
    flex: 1 0 auto; /* ⚡フッター固定用：コンテンツが少なくても、残りの高さをすべて使い切る */
    width: 100%;
    align-items: stretch;
}

/* メインコンテンツ（余白を広げてプレミアムな空気感に） */
.main-content {
    flex: 1;
    padding: 40px 60px;
    box-sizing: border-box;
    background-color: transparent;
    display: flex;
    justify-content: center;
}

/* 中央配置用のラッパー（プレーンな白い1枚のカードに変身） */
.content-wrapper {
    width: 100%;
    max-width: 600px;
    background: #ffffff;
    border-radius: 12px;
    padding: 40px; /* カード内の余白 */
    /* ご要望に合わせて、影を少しはっきりと濃いめに設定 */
    box-shadow: 0 4px 20px rgba(100, 120, 100, 0.12);
    box-sizing: border-box;
}

/* 上部の戻るリンク（野暮ったい下線と青色を廃止） */
.back-link {
    margin-bottom: 25px;
}
.back-link a {
    color: #8a958f; /* 普段は控えめなグレー */
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: color 0.2s ease;
}
.back-link a:hover {
    color: #4a7c59; /* ホバーするとテーマカラーのグリーンに */
}

/* タイトルエリア（グレーの帯を廃止し、シンプルな下線スタイルに） */
.title-area {
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; 
    border-bottom: 2px solid #e8ece9; /* 繊細な下線 */
}

/* フォームエリア */
.form-area {
    background: transparent;
    padding: 0;
}

/* ラベルと入力欄をゆったり配置 */
.form-row {
    margin-bottom: 25px;
}

/* ラベルスタイル */
.form-row label {
    display: block;
    font-size: 11px;
    color: #8a958f; /* 馴染むニュアンスグレー */
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    margin-bottom: 8px;
}

/* すっきりした入力フォーム（グレーの枠線をやめ、フラットデザインに） */
.form-row input[type="text"] {
    width: 100%;
    height: 40px; /* 高さをしっかり持たせてスマートに */
    padding: 0 14px; 
    border: 1px solid transparent; /* 通常時は線を消す */
    border-radius: 8px; 
    font-size: 14px; 
    background-color: #f1f3f1; /* 薄いアッシュグリーングレーの背景 */
    color: #2b2d42;
    outline: none;
    box-sizing: border-box;
    transition: all 0.2s ease;
}

/* 入力中のエフェクト：背景が白になり、グリーンの細い線が浮き出る */
.form-row input[type="text"]:focus {
    background-color: #fff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

/* 読み取り専用（科目コード）の背景スタイル */
.form-row input[readonly] {
    background-color: #e6ece8; /* 少しグリーンの入った落ち着いたアッシュグレー */
    color: #8a958f;
    border-color: transparent;
    cursor: not-allowed; /* 入力不可のカーソル */
}
.form-row input[readonly]:focus {
    background-color: #e6ece8;
    border-color: transparent;
    box-shadow: none;
}

/* ボタンエリア */
.button-area {
    text-align: left;
    margin-top: 35px;
}

/* 送信ボタン（フラットで洗練されたニュアンスグリーン） */
.button-area input[type="submit"] {
    height: 40px; 
    padding: 0 28px; 
    background-color: #4a7c59; /* 優しくくすんだ緑 */
    color: #ffffff; 
    border: none; 
    border-radius: 8px; 
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    cursor: pointer; 
    transition: all 0.2s ease;
}

.button-area input[type="submit"]:hover {
    background-color: #3b6347; /* ホバー時は少し深いオリーブに */
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2); /* 浮き上がる影 */
}

/* ボタンの下に配置するテキストリンクの「戻る」 */
.button-area a {
    display: block;
    margin-top: 20px;
    color: #8a958f; /* 普段は控えめなグレー */
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    transition: color 0.2s ease;
}

.button-area a:hover {
    color: #4a7c59; /* ホバーするとテーマカラーに */
}

/* フッターの潰れ防止（※共通スタイルに組み込んでください） */
footer, .footer {
    flex-shrink: 0; 
}

</style>

</head>

<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <div class="content-wrapper">

            <div class="title-area">
                科目情報変更
            </div>

                        <div class="form-area">

                <form action="${pageContext.request.contextPath}/action/SubjectUpdateExecute.action"method="post">
                <input type="hidden" name="cd" value="${subject.cd}">
                <input type="hidden"name="schoolCd"value="${subject.school.cd}">
                <form action="${pageContext.request.contextPath}/action/SubjectUpdateExecute.action"
                      method="post">

                    <input type="hidden" name="cd" value="${subject.cd}">

                    <!-- 💡 科目コード部分 -->
                    <div class="form-row">
                        <label>科目コード</label>
                        <div style="flex: 1; display: flex; flex-direction: column;">
                            <input type="text" value="${subject.cd}" readonly>
                            
                            <!-- 科目コード用の個別エラー（重複など） -->
                            <c:if test="${not empty errorMessage and (errorMessage.contains('コード') or errorMessage.contains('重複'))}">
                                <div style="color: #ff0000; font-size: 0.85em; margin-top: 5px; font-weight: bold;">
                                    ${errorMessage}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 💡 科目名部分 -->
                    <div class="form-row">
                        <label for="name">科目名</label>
                        <div style="flex: 1; display: flex; flex-direction: column;">
                            <input type="text"
                                   id="name"
                                   name="name"
                                   value="${subject.name}"
                                   placeholder="科目名を入力してください"
                                   required>
                                   
                            <!-- 科目名用の個別エラー（20文字オーバーなど） -->
                            <c:if test="${not empty errorMessage and errorMessage.contains('科目名')}">
                                <div style="color: #ff0000; font-size: 0.85em; margin-top: 5px; font-weight: bold;">
                                    ${errorMessage}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="button-area">
                        <input type="submit" value="変更">

                        <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                            戻る
                        </a>
                    </div>

                </form>

            </div>


        </div>

    </div>

</div>
<%@ include file="/footer.jsp" %>
</body>
</html>