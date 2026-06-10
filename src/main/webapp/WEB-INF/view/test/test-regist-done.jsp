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

    /* ② 緑色のメッセージボックス */
    .success-msg { background-color: #d4edda; color: #155724; padding: 15px; margin-bottom: 25px; border-radius: 4px; font-size: 14px; font-weight: bold; }

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
        <h2>登録完了</h2>

        <div class="success-msg">
            成績を登録しました！
        </div>

        <div class="link-group">
            <a href="${pageContext.request.contextPath}/action/Menu.action">メニューへ戻る</a>
            <a href="${pageContext.request.contextPath}/action/TestRegist.action">続けて登録</a>
        </div>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>