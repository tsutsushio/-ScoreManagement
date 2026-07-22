<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 登録完了</title>

<style>
/* システム共通スタイル */
html, body { 
    height: 100%; 
    margin: 0; 
    padding: 0; 
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #f4f6f4; /* 全体の薄い緑背景 */
    color: #2b2d42; 
}
body { 
    display: flex; 
    flex-direction: column; 
}
.container { 
    display: flex; 
    flex: 1; 
    width: 100%; 
    align-items: stretch; 
    background-color: #f4f6f4; 
}
.main-content { 
    flex: 1; 
    padding: 40px 60px; /* 余白を贅沢に広げてプレミアムな空気感に */
    box-sizing: border-box; 
}

/* ① 見出し「登録完了」（グレーの帯を廃止し、繊細な下線と文字のみに） */
h2 { 
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; /* メインの深緑 */
}

/* ② 成功メッセージボックス（白カードの上に、優しく目を引くソフトミント） */
p.success-msg {
    background-color: #edf7ed;  /* パッと明るく清潔感のある淡いミントグリーン */
    color: #2c5234;             /* 文字は読みやすい深緑に */
    border-left: 4px solid #4a7c59; /* 左端にアクセント線をプラス */
    padding: 20px 24px;         /* 余白を広げてゆったりと */
    margin: 0 0 35px 0; 
    border-radius: 8px;         /* 角丸にして今風の柔らかさに */
    font-size: 15px;            /* 文字をわずかに大きく */
    font-weight: 600; 
    text-align: left;           /* 左寄せにすることで、モダンなツール感を演出 */
    box-shadow: 0 4px 15px rgba(140, 160, 140, 0.04);
}

/* ③ リンクボタンエリア（間隔を少し詰めて、ボタンとして配置しやすく） */
.link-group { 
    display: flex; 
    gap: 16px; 
}

/* 古臭い「青文字＋下線」を廃止し、洗練された「並ぶボタン」へ変更 */
.link-group a { 
    display: flex;
    align-items: center;
    justify-content: center;
    height: 40px;
    padding: 0 24px;
    background-color: #ffffff; /* 白ベースのボタン */
    color: #4a7c59;            /* 文字を優しい緑に */
    text-decoration: none;     /* 下線を消去 */
    border: 1px solid #edf0ee; /* 繊細な枠線 */
    border-radius: 8px;        /* 角丸 */
    font-size: 14px; 
    font-weight: 500;
    box-shadow: 0 2px 8px rgba(140, 160, 140, 0.04);
    transition: all 0.2s ease;
}

/* リンクボタンホバー時：メインの緑ボタンに鮮やかに切り替わる */
.link-group a:hover {
    background-color: #4a7c59; 
    color: #ffffff; 
    border-color: #4a7c59;
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.15);
}

</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <!-- No1: 画面タイトル -->
        <h2>成績管理</h2>

        <!-- No2: 登録完了メッセージ（要件に合わせ p タグに変更） -->
        <p class="success-msg">登録が完了しました</p>

        <div class="link-group">
            <!-- No3: 戻るリンク（備考：成績管理一覧画面＝成績登録の初期表示へ遷移） -->
            <a href="${pageContext.request.contextPath}/action/TestRegist.action">戻る</a>
            
            <!-- No4: 成績参照リンク（備考：成績参照検索画面へ遷移） -->
            <a href="${pageContext.request.contextPath}/action/TestList.action">成績参照</a>
        </div>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>
