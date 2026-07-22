<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目新規登録</title>

<style>
/* 全体レイアウト：他の画面と共通の縦幅いっぱいベース */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    /* フォントをモダンで美しい文字の並びに変更 */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #fafbfc; /* 明るく清潔感のあるモダンな背景 */
    color: #2b2d42; /* 文字色を優しい黒にして洗練された印象に */
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
}

/* 右側メインエリア */
.main-content {
    flex: 1;
    padding: 40px 60px; /* 余白を広げてプレミアムな空気感に */
    box-sizing: border-box;
}

/* タイトル（グレーの帯を廃止し、シンプルな下線スタイルに） */
.main-content h2 {
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; 
    border-bottom: 2px solid #e8ece9; /* 繊細な下線 */
}

/* フォームコンテナ（プレーンな白い1枚のカードに変身） */
.form-container {
    max-width: 800px;
    width: 100%;
    background: #ffffff;
    border-radius: 12px;
    padding: 40px; /* カード内の余白 */
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); /* 非常に繊細で柔らかい影 */
    box-sizing: border-box;
}

/* フォームグループ */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px; /* ラベルと入力欄の隙間を少し広げて見やすく */
    margin-bottom: 25px; /* グループ間の間隔 */
}

/* ラベルスタイル */
.form-group label {
    font-size: 11px;
    color: #8a958f; /* 馴染むニュアンスグレー */
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

/* テキスト入力欄（グレーの枠線をやめ、フラットデザインに） */
.form-group input[type="text"] {
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
    transition: all 0.25s ease;
}

/* 入力中のエフェクト：背景が白になり、グリーンの細い線が浮き出る */
.form-group input[type="text"]:focus {
    background-color: #fff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

/* プレースホルダーの文字色 */
.form-group input::placeholder {
    color: #b5beb9;
}

/* 送信ボタン（フラットで洗練されたニュアンスグリーン） */
.btn-submit {
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
    margin-bottom: 20px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background-color: #3b6347; /* ホバー時は少し深いオリーブに */
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2); /* 浮き上がる影 */
}

/* 戻るリンクのボックス */
.back-link-box {
    margin-top: 10px;
}

/* 戻るリンク（野暮ったい下線を廃止し、テーマカラーのテキストリンクへ） */
.back-link {
    color: #8a958f; /* 普段は控えめなグレー */
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    transition: color 0.2s ease;
}

.back-link:hover {
    color: #4a7c59; /* ホバーするとテーマカラーに */
}

/* エラーメッセージ（優しいオレンジ寄りの警告色でミニマルに表現） */
.error-msg {
    color: #e67e22; 
    font-size: 13px;
    margin-top: 6px;
    font-weight: 500;
    background: none;
    border-left: none;
    padding: 0;
}

</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>科目情報登録</h2>

        <div class="form-container">

            <form action="${pageContext.request.contextPath}/action/SubjectCreateExecute.action" method="post">

                <div class="form-group">
                    <label for="cd">科目コード</label>
                    <!-- maxlength="3" を削除 -->
                    <input type="text" id="cd" name="cd"
                           value="${cd}"
                           placeholder="科目コードを入力してください"
                           required>
                    
                    <!-- メッセージに「コード」または「重複」が含まれる場合は科目コードの下に表示 -->
                    <c:if test="${not empty errorMessage and 
                    (errorMessage.contains('コード') or 
                    errorMessage.contains('重複'))}">
                        <div class="error-msg">
                            ${errorMessage}
                        </div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="name">科目名</label>
                    <!-- maxlength="20" を削除 -->
                    <input type="text" id="name" name="name"
                           value="${name}"
                           placeholder="科目名を入力してください"
                           required>
                    
                    <!-- メッセージに「科目名」が含まれる場合は科目名の下に表示 -->
                    <c:if test="${not empty errorMessage and errorMessage.contains('科目名')}">
                        <div class="error-msg">
                            ${errorMessage}
                        </div>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">登録</button>

            </form>

            <div class="back-link-box">
                <a href="${pageContext.request.contextPath}/action/SubjectList.action"class="back-link">戻る</a>
            </div>

        </div>

    </div>

</div>

<%@ include file="/footer.jsp" %>

</body>
</html>
