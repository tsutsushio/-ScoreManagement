<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/header.jsp" %>

<style>
/* 全体レイアウト（他画面と共通のコンテナ） */
.container {
    display: flex;
    flex: 1;
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

/* 削除完了メッセージ帯（②：濃いめの影で立体感を強めたメッセージボックス） */
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
    /* 前回の「科目一覧」と同様に、スマートな白抜き枠線ボタンとしてリデザイン */
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
    /* ここも連動して少し濃いめの美しい影を適用 */
    box-shadow: 0 4px 12px rgba(100, 120, 100, 0.12);
}
/* 全体：画面縦幅いっぱいのベースを作る */
html, body {
    height: 100%; /* 古いブラウザ用のフォールバック */
    margin: 0;
    padding: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #fafbfc; 
    color: #2b2d42; 
}

body {
    display: flex;
    flex-direction: column; /* 上からヘッダー、メイン、フッターの順 */
    min-height: 100vh; /* 画面の縦幅を最低でも100%確保する */
}

/* 全体レイアウト（サイドバーとメインコンテンツのコンテナ） */
.container {
    display: flex;
    flex: 1 0 auto; /* ⚡最重要：コンテンツが少なくても、画面の残りの高さをすべて使い切る */
    width: 100%;
    align-items: stretch;
}

/* フッターのスタイル例（もし個別に設定していない場合は、こちらを参考にしてください） */
footer, .footer {
    flex-shrink: 0; /* ⚡最重要：フッターが潰れるのを防ぐ */
    background-color: #ffffff; /* デザインに合わせた白背景 */
    border-top: 1px solid #edf0ee; /* 繊細な区切り線 */
    padding: 15px 0;
    text-align: center;
    font-size: 12px;
    color: #8a958f;
}

</style>

<!-- 他の画面と同じくサイドバーを挟むためのレイアウト構造 -->
<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <!-- タイトル（①） -->
        <h2>科目情報削除</h2>

        <!-- 削除完了メッセージ（②） -->
        <div class="done-message">
            削除が完了しました
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
