<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 登録完了</title>

<style>
/* 全体：共通の縦幅いっぱいベースを作る */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #fafbfc; 
    color: #2b2d42; 
}

body {
    display: flex;
    flex-direction: column; 
}

/* 全体レイアウト */
.container {
    display: flex;
    flex: 1;            
    width: 100%;
    align-items: stretch;
}

/* メインエリア */
.main-content {
    flex: 1;
    padding: 40px 60px;
    box-sizing: border-box;
    background-color: transparent;
}

/* タイトルエリア */
.main-content h2 {
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; 
    border-bottom: 2px solid #e8ece9; 
}

/* 登録完了メッセージ帯 */
.done-message {
    color: #2c5234; 
    font-size: 13px; 
    font-weight: 500;
    margin-bottom: 30px; 
    padding: 14px 20px;
    background-color: #edf2ee; 
    border-radius: 8px;
    border-left: 4px solid #4a7c59; 
    box-sizing: border-box;
    box-shadow: 0 2px 12px rgba(140, 160, 140, 0.04);
}

/* ボタンエリア */
.button-area {
    display: flex;
    align-items: center; 
    justify-content: flex-start; 
    gap: 16px; /* ボタン同士の間隔を少しタイトにしてスマートに */
    margin-top: 10px;
}

/* 共通ボタンベーススタイル */
.btn-primary, .btn-secondary {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 40px; 
    padding: 0 28px; 
    border-radius: 8px; 
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    text-decoration: none; 
    transition: all 0.2s ease;
    box-sizing: border-box;
}

/* メインボタン：続けて登録 */
.btn-primary {
    background-color: #4a7c59; /* 優しくくすんだ緑 */
    color: #ffffff; 
}
.btn-primary:hover {
    background-color: #3b6347; 
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2); 
}

/* サブボタン：科目一覧（背景が白の枠線ボタン） */
.btn-secondary {
    background-color: #ffffff;
    color: #4a7c59; 
    border: 1px solid #4a7c59; /* グリーンの一本線枠 */
}
.btn-secondary:hover {
    background-color: #f7f9f8; /* ほんのりグレー地に */
    box-shadow: 0 4px 12px rgba(140, 160, 140, 0.1);
}

</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <!-- タイトル（①） -->
        <h2>科目情報登録</h2>

        <!-- 登録完了メッセージ（②） -->
        <div class="done-message">
            登録が完了しました
        </div>

        <!-- 各種リンク（クラスを付与してそれぞれボタン化） -->
        <div class="button-area">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action" class="btn-primary">
                続けて登録
            </a>
            <a href="${pageContext.request.contextPath}/action/SubjectList.action" class="btn-secondary">
                科目一覧
            </a>
        </div>

    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>
