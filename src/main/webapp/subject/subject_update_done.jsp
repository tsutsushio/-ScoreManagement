<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目変更完了</title>

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

/* 全体レイアウト（サイドバーとメインコンテンツのコンテナ） */
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
}

/* タイトルエリア（①：グレーの帯を廃止し、シンプルな下線スタイルに） */
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

/* 変更完了メッセージ帯（②：濃いめの影で立体感を強めたメッセージボックス） */
.done-message {
    color: #2c5234; 
    font-size: 13px; 
    font-weight: 500;
    margin-bottom: 30px; 
    padding: 14px 20px;
    background-color: #edf2ee; /* 心地よいニュアンスグリーンの背景 */
    border-radius: 8px;
    border-left: 4px solid #4a7c59; /* 左側にアクセントライン */
    box-sizing: border-box;
    /* ご要望に合わせて、影を少しはっきりと濃いめに設定 */
    box-shadow: 0 4px 15px rgba(100, 120, 100, 0.12);
}

/* リンクエリア（③） */
.back-link-box {
    margin-top: 15px;
    text-align: left;
}

/* リンクのテキスト装飾（③：野暮ったい下線と原色の青を廃止） */
.back-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    /* 他の完了画面と同様に、スマートな白抜き枠線ボタンとしてリデザイン */
    height: 40px; 
    padding: 0 28px; 
    background-color: #ffffff;
    color: #4a7c59; 
    border: 1px solid #4a7c59; /* グリーンの一本線枠 */
    border-radius: 8px; 
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    text-decoration: none; 
    transition: all 0.2s ease;
    box-sizing: border-box;
}

.back-link:hover {
    background-color: #f7f9f8; /* ほんのりグレー地に */
    /* 連動して少し濃いめの美しい影を適用 */
    box-shadow: 0 4px 12px rgba(100, 120, 100, 0.12);
}

/* フッターの潰れ防止（※共通スタイルに組み込んでください） */
footer, .footer {
    flex-shrink: 0; 
}

</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<!-- 他の画面と同じくサイドバーを挟むためのレイアウト構造 -->
<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <!-- タイトル（①） -->
        <h2>科目情報変更</h2>

        <!-- 変更完了メッセージ（②） -->
        <div class="done-message">
            変更が完了しました
        </div>

        <!-- 科目一覧へのリンク（③） -->
        <div class="back-link-box">
            <a href="${pageContext.request.contextPath}/action/SubjectList.action" class="back-link">
                科目一覧
            </a>
        </div>

    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>
