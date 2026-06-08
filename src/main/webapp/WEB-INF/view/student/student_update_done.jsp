<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生変更完了</title>
<style>
    /* 全体レイアウト */
    body {
        margin: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #ffffff;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* メインコンテナ（サイドバー無しの単一コンテンツエリア） */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
    }

    /* ① 見出し「学生情報変更」（グレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 20px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        color: #333;
        font-size: 18px;
        font-weight: bold;
    }

    /* ② 変更完了メッセージ（緑の帯） */
    .success-alert {
        background-color: #92c5ad; /* 画像の落ち着いた緑色 */
        color: #333;
        text-align: center;
        padding: 8px 10px;
        font-size: 13px;
        margin-bottom: 50px; /* 下のリンクとの間隔 */
    }

    /* ③ 学生一覧リンク */
    .link-group {
        font-size: 14px;
    }
    .link-group a {
        color: #0066ff;
        text-decoration: underline;
    }
    .link-group a:hover {
        color: #0044cc;
    }
</style>
</head>
<body>

    <div class="main-content">

        <!-- ① 見出し「学生情報変更」 -->
        <h2>学生情報変更</h2>
        
        <!-- ② 変更完了メッセージ（緑の帯） -->
        <div class="success-alert">
            変更が完了しました
        </div>
        
        <!-- ③ リンクエリア -->
        <div class="link-group">
                    <a href="${pageContext.request.contextPath}/action/StudentList.action" class="btn">学生一覧へ</a>
        </div>

    </div>

    <!-- フッターの読み込み（必要に応じて有効化してください） -->
   <%@ include file="/footer.jsp" %> 

</body>
</html>
