<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 科目管理</title>

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
    flex-direction: column; /* 上からヘッダー、コンテンツの順 */
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

/* ① 見出し「科目管理」（グレーの帯を廃止し、シンプルな下線スタイルに） */
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

/* 新規登録リンク（右上に配置・ボタン風のデザインへ昇華） */
.create-wrapper {
    margin-bottom: 20px;
    text-align: right;
}
.create-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 40px; 
    padding: 0 24px; 
    background-color: #4a7c59; /* 優しくくすんだ緑 */
    color: #ffffff; 
    border-radius: 8px; 
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    text-decoration: none; /* 下線を消す */
    transition: all 0.2s ease;
}
.create-link:hover { 
    background-color: #3b6347; /* ホバー時は少し深いオリーブに */
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2); /* 浮き上がる影 */
}

/* テーブルスタイル（「THE・表」っぽさを無くした、モダンでフラットなデザイン） */
.subject-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 5px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); /* ボックスと影を統一 */
    overflow: hidden;
}
/* ヘッダーの背景塗りをやめ、シンプルな文字ラインのみに */
.subject-table th {
    background-color: #ffffff; 
    color: #8a958f; /* 薄い色にしてデータ（文字）を引き立てる */
    padding: 18px 16px; 
    text-align: left; 
    font-weight: 600;
    font-size: 12px;
    letter-spacing: 0.05em;
    border-bottom: 2px solid #edf0ee;
}
/* 余白を贅沢に取ってデータを美しく見せる */
.subject-table td {
    padding: 16px 16px;
    font-size: 14px;
    color: #2b2d42;
    border-bottom: 1px solid #f4f6f5;
}

/* 操作リンク（野暮ったい下線を廃止し、洗練されたテキストリンクへ） */
.action-link, .delete-link {
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    transition: opacity 0.2s ease;
}
.action-link:hover, .delete-link:hover {
    opacity: 0.7;
}

.action-link {
    color: #4a7c59; /* テーマカラーのグリーンに統一 */
    margin-right: 15px; /* リンク同士の間隔 */
}
.delete-link {
    color: #d9534f; /* 削除は警告色を維持 */
}

/* テーブルの偶数行（2, 4, 6行目...）の背景色を薄いグレーにする */
.subject-table tr:nth-child(even) td {
    background-color: #fbfcfb; /* くすみグリーンに馴染む超極薄のグレー */
}

/* マウスを乗せた行のインタラクション */
.subject-table tr:hover td {
    background-color: #f7f9f8; /* ほんのりニュアンスグレー */
}

</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">

        <h2>科目管理</h2>

        <div class="create-wrapper">
            <a href="${pageContext.request.contextPath}/action/SubjectCreate.action" class="create-link">新規登録</a>
        </div>

        <table class="subject-table">
            <thead>
                <tr>
                    <th>科目コード</th>
                    <th>科目名</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="subject" items="${subjectList}">
                    <tr>
                        <td><c:out value="${subject.cd}"/></td>
                        <td><c:out value="${subject.name}"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/action/SubjectUpdate.action?cd=${subject.cd}" class="action-link">
                                変更
                            </a>
                        </td>
                        <td>
						    <!-- onclickを消して、純粋に確認アクション(SubjectDelete)を呼び出すようにします -->
						    <a href="${pageContext.request.contextPath}/action/SubjectDelete.action?cd=${subject.cd}" class="delete-link">
						        削除
						    </a>
						</td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </div> </div> <%@ include file="/footer.jsp" %>

</body>
</html>

