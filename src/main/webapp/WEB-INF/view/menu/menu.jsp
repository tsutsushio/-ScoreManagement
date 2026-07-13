<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - メインメニュー</title>

<style>
/* 全体：画面の縦幅に合わせる */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif;
    background-color: #fafbfc; /* ほんのり明るいニュアンスホワイト */
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
    background-color: #fafbfc;
}

/* メインエリア */
.main-content {
    flex: 1;
    padding: 40px 60px; /* 余白を贅沢に広げてプレミアム感を演出 */
    box-sizing: border-box;
}

/* ① メニュー見出し（グレーの帯を廃止し、繊細な下線と文字のみに） */
.main-content h2 {
    margin-top: 0;
    margin-bottom: 35px;
    padding: 0 0 15px 0;
    background-color: transparent;
    border-bottom: 2px solid #edf0ee; /* 洗練された細い下線 */
    color: #2c5234; /* メインの深緑 */
    font-size: 22px;
    font-weight: 500;
    letter-spacing: 0.05em;
    box-shadow: none;
}

/* カード配置 */
.card-container {
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
    gap: 25px; /* カード同士の間隔を少し広げてゆとりを */
    flex-wrap: wrap;
}

/* ★ カードの基本設定（高さを固定し、ガタつきを無くす） */
.menu-card {
    width: 240px; 
    height: 180px; /* ★ min-height ではなく height で高さを完全に固定 */
    border-radius: 12px; 
    padding: 24px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: space-between; /* ★ 中身のタイトルとボタンを上下にきれいに分散配置 */
    align-items: center;     
    background-color: #ffffff; 
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
    border: 1px solid #edf0ee;
    transition: all 0.25s ease;
}

/* ★ カード内の見出しテキスト（h3が消えているカードの対策） */
.menu-card h3 {
    margin: 0 0 10px 0;
    color: #2c5234; 
    font-size: 15px;
    font-weight: 600;
    text-align: center;
    letter-spacing: 0.03em;
    display: block !important; /* ★ HTML側で消されていても強制的に表示させます */
}

/* ★ カード内リンクエリア（ボタンが1つのときも2つのときも崩れないように設定） */
.menu-links {
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    flex: 1; /* ★ 余った縦幅をボタンエリアが使うように指定 */
    gap: 10px; 
}

/* ★ リンクボタン（薄いグレー背景でも文字がハッキリ読めるように改善） */
.menu-links a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%; 
    height: 38px;
    padding: 0 16px;
    box-sizing: border-box;
    text-align: center;
    background-color: #f1f3f1; 
    color: #2c5234; /* ★ 文字色を「薄い緑」から「濃い緑」に変更してハッキリ読めるように */
    text-decoration: none; 
    border-radius: 8px; 
    font-weight: 600; /* ★ 文字を少し太くして視認性アップ */
    font-size: 14px;
    transition: all 0.2s ease;
}

/* リンクホバー時 */
.menu-links a:hover {
    background-color: #4a7c59; 
    color: #ffffff; 
    transform: none;
}


/* 赤・緑・紫のバラバラだった背景色を「グリーンのグラデーション」としてリニューアル */
/* ② 学生管理（淡いミント） */
.card-student {
    border-top: 4px solid #8db397; /* カードのトップにアクセント線を配置 */
}
.card-student h3 {
    display: block; /* 非表示になっていた見出しを復活させてデザインを統一 */
}

/* ③④⑤ 成績管理（中間のセージグリーン） */
.card-score {
    border-top: 4px solid #4a7c59;
}

/* ⑥ 科目管理（深いディープグリーン） */
.card-subject {
    border-top: 4px solid #2c5234;
}
.card-subject h3 {
    display: block; /* 非表示になっていた見出しを復活させてデザインを統一 */
}

/* フッター（お堅いグレーから、画面になじむニュアンスグレーへ） */
footer {
    background-color: #f1f3f1;
    text-align: center;
    padding: 18px;
    font-size: 12px;
    color: #8a958f;
    width: 100%;
    box-sizing: border-box;
    border-top: 1px solid #edf0ee;
}


</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">

    <%@ include file="/sidebar.jsp" %>
    

    <!-- メイン -->
    <div class="main-content">
        <h2>メニュー</h2>

        <div class="card-container">


            <!-- ② 学生管理 -->

            <div class="menu-card card-student">
                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/StudentList.action">
                        学生管理
                    </a>
                </div>
            </div>


            <!-- ③④⑤ 成績管理 -->

            <div class="menu-card card-score">
                <h3>成績管理</h3>
                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/TestRegist.action">
                        成績登録
                    </a>
                    <a href="${pageContext.request.contextPath}/action/TestList.action">
                        成績参照
                    </a>

                </div>
            </div>


            <!-- ⑥ 科目管理 -->
            <div class="menu-card card-subject">
                <div class="menu-links">
                    <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                        科目管理
                    </a>
                </div>
            </div>

        </div>
    </div>

</div>

    <!-- フッターの読み込み -->
    <%@ include file="/footer.jsp" %>

</body>
</html>
