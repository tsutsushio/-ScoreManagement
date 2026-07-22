<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/* サイドバー全体のスタイル（白ベースに繊細な境界線で、クリアな印象に） */
.sidebar {
    width: 240px;          /* ★ メインエリアの広さに合わせて、少しだけ幅を広げてゆとりを */
    background-color: #ffffff; /* 清潔感のある白 */
    padding: 30px 20px;    /* 上下の余白を少し広げてスマートに */
    border-right: 1px solid #edf0ee; /* ごく薄いセージグレーの境界線 */
    box-sizing: border-box; 
}

/* リスト全体の余白リセット */
.sidebar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

/* メニューの「大見出し（親項目）」のスタイル */
.sidebar li {
    margin-bottom: 8px; /* スキマを美しく調整 */
    color: #2c5234;     /* ★ 親項目は、ヘッダーとお揃いの「深い緑」で引き締める */
    font-size: 13px;    /* 文字をあえて少し小さくして、知的な印象に */
    font-weight: 600;   /* しっかり太字 */
    letter-spacing: 0.05em;
}

/* 各メニューのリンク（★リンクをグリーンに！） */
.sidebar a {
    text-decoration: none;
    color: #4a7c59;       /* ★ ご要望：優しくくすんだモダンな緑色 */
    display: block;
    padding: 8px 12px;    /* 内側に少し余白を作って、ボタンのように押しやすく */
    border-radius: 6px;   /* 角丸をつけて今風に */
    font-weight: 500;     
    font-size: 14px;
    transition: all 0.2s ease;
}

/* リンクホバー時：下線をやめ、うっすら緑の座布団が敷かれる演出に */
.sidebar a:hover {
    text-decoration: none; /* 下線は消して洗練させます */
    color: #2c5234;        /* 文字色はより深い緑に */
    background-color: #edf2ee; /* ★ うっすらと淡い緑の背景が優しく浮き上がります */
}

/* 成績管理の下にあるサブメニュー（子項目） */
.sidebar .sub-menu {
    margin-left: 10px;    /* インデントを美しく微調整 */
    margin-top: 4px;
    margin-bottom: 16px;  /* 次の親項目との間にしっかりスキマを作る */
}

.sidebar .sub-menu li {
    margin-bottom: 4px;   /* サブメニュー内の隙間 */
}

/* サブメニューのリンクは、少しだけ文字を小さくして階層を分かりやすく */
.sidebar .sub-menu a {
    font-size: 13px;
    padding: 6px 12px;
}

</style>

<div class="sidebar">
  <c:if test="${not empty sessionScope.loginUser and not empty sessionScope.loginUser.name and sessionScope.loginUser.name != 'null'}">
    <ul>
        <li><a href="${pageContext.request.contextPath}/action/Menu.action">メニュー</a></li>
        <li><a href="${pageContext.request.contextPath}/action/StudentList.action">学生管理</a></li>
        <li>
            成績管理
            <ul class="sub-menu">
                <li><a href="${pageContext.request.contextPath}/action/TestRegist.action">成績登録</a></li>
                <li><a href="${pageContext.request.contextPath}/action/TestList.action">成績参照</a></li>
             
            </ul>
        </li>
        <li><a href="${pageContext.request.contextPath}/action/SubjectList.action">科目管理</a></li>
        <li><a href="${pageContext.request.contextPath}/action/SeatList.action"></a>席替え</li>
        
    </ul>
  </c:if>
</div>
