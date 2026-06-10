<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/header.jsp" %>

<style>
/* 全体レイアウト（もし他画面と合わせるためのコンテナが必要な場合はここに記述） */
.container {
    display: flex;
    flex: 1;
    width: 100%;
    align-items: stretch;
}

/* メインコンテンツ（左寄せ・登録画面などと同じ余白設定） */
.main-content {
    flex: 1;
    padding: 20px 40px;
    box-sizing: border-box;
    background-color: #ffffff;
}

/* タイトルエリア（①） */
.main-content h2 {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 12px 15px;
    background-color: #f2f2f2; /* 画像の薄いグレー */
    color: #333;
    font-size: 24px;
    font-weight: bold;
}

/* 削除完了メッセージ帯（②） */
.done-message {
    font-size: 14px;
    color: #333;
    background-color: #8cc6a5; /* 画像と同じ鮮やかで落ち着いた緑色 */
    padding: 10px 15px;
    margin-bottom: 25px;
    box-sizing: border-box;
}

/* リンクエリア（③） */
.back-link-box {
    margin-top: 5px;
    text-align: left;
}

/* リンクのテキスト装飾（③） */
.back-link {
    color: #007bff;              /* リンクの青色 */
    text-decoration: underline;  /* 下線を表示 */
    font-size: 14px;
    font-weight: normal;         /* 太字を解除 */
}

.back-link:hover {
    color: #0056b3;
    text-decoration: none;       /* ホバー時は下線を消す */
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
