<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 登録完了</title>

<style>
    /* システム共通スタイル */
    html, body { height: 100%; margin: 0; padding: 0; font-family: "Yu Gothic", sans-serif; background-color: #ffffff; }
    body { display: flex; flex-direction: column; }
    
    .container { display: flex; flex: 1; width: 100%; align-items: stretch; }
    .main-content { flex: 1; padding: 20px 40px; box-sizing: border-box; }

    /* ① 見出し「登録完了」（グレーの帯） */
    h2 { font-size: 18px; font-weight: bold; background-color: #f2f2f2; padding: 10px 15px; margin: 0 0 20px 0; color: #333; }

    /* ② 緑色のメッセージボックス（pタグにスタイルを適用） */
    p.success-msg { background-color: #d4edda; color: #155724; padding: 15px; margin: 0 0 25px 0; border-radius: 4px; font-size: 14px; font-weight: bold; }

    /* ③ リンクボタン */
    .link-group { display: flex; gap: 40px; }
    .link-group a { color: #0066ff; text-decoration: underline; font-size: 14px; }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <!-- No1: 画面タイトル -->
        <h2>登録完了</h2>

        <!-- No2: 登録完了メッセージ（要件に合わせ p タグに変更） -->
        <p class="success-msg">成績を登録しました！</p>

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
