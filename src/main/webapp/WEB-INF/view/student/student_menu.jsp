<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">

<head>

<meta charset="UTF-8">

<title>学生メニュー</title>

<style>

/* ===== 全体 ===== */
body{
    font-family:"Yu Gothic","Meiryo",sans-serif;
    background:
        linear-gradient(to bottom,#f5f7fb,#eef4ff);
    margin:0;
    padding:40px 20px;
    color:#333;
    min-height:100vh;
    box-sizing:border-box;
}

/* ===== メインカード ===== */
.container{
    max-width:1100px;
    margin:0 auto;
    background:white;
    border-radius:24px;
    padding:40px;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.08),
        0 3px 10px rgba(0,0,0,0.04);

    animation:fadeIn 0.4s ease;
}

/* ===== タイトル ===== */
h1{
    margin-top:0;
    margin-bottom:10px;
    color:#4a90e2;
    font-size:36px;
    text-align:center;
    letter-spacing:1px;
}

/* ===== ようこそ ===== */
.welcome{
    text-align:center;
    font-size:17px;
    margin-bottom:35px;
    color:#555;
}

/* ===== 区切り ===== */
hr{
    border:none;
    border-top:1px solid #e5ecf5;
    margin:35px 0;
}

/* ===== セクションタイトル ===== */
h2{
    color:#4a90e2;
    margin-bottom:20px;
    font-size:24px;
    border-left:6px solid #66a3ff;
    padding-left:12px;
}

/* ===== 基本情報 ===== */
.info-list{
    list-style:none;
    padding:0;
    margin:0;

    display:grid;
    grid-template-columns:
        repeat(auto-fit,minmax(250px,1fr));

    gap:15px;
}

.info-list li{
    background:#f8fbff;
    border:1px solid #dce7f7;
    border-radius:14px;
    padding:18px;
    font-size:15px;

    box-shadow:
        0 2px 5px rgba(0,0,0,0.03);
}

/* ===== スコアボックス ===== */
.score-box{
    background:#f8fbff;
    border:1px solid #dce7f7;
    border-radius:18px;
    padding:25px;
}

/* ===== テーブル ===== */
table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    overflow:hidden;
    border-radius:16px;
    margin-top:10px;

    box-shadow:
        0 4px 14px rgba(0,0,0,0.05);
}

/* ===== ヘッダー ===== */
th{
    background:
        linear-gradient(to right,#66a3ff,#4d8cff);

    color:white;
    padding:15px;
    font-size:14px;
    text-align:left;
}

/* ===== データ ===== */
td{
    background:white;
    padding:15px;
    border-bottom:1px solid #edf2f7;
    font-size:14px;
}

/* ===== 偶数行 ===== */
tbody tr:nth-child(even) td{
    background:#f8fbff;
}

/* ===== hover ===== */
tbody tr:hover td{
    background:#eef5ff;
    transition:0.2s;
}

/* ===== 点数 ===== */
.point{
    text-align:right;
    font-weight:bold;
    color:#256fd1;
    font-size:15px;
}

/* ===== データなし ===== */
.no-data{
    padding:18px;
    background:#fffdf3;
    border:1px solid #ffe8a3;
    border-radius:12px;
    color:#8a6d3b;
    font-style:italic;
}

/* ===== メニュー ===== */
.menu-list{
    list-style:none;
    padding:0;
}

.menu-list li{
    margin-bottom:12px;
}

/* ===== リンク ===== */
a{
    color:#4a90e2;
    text-decoration:none;
    font-weight:bold;
    transition:0.2s;
}

a:hover{
    color:#256fd1;
    text-decoration:underline;
}

/* ===== ログアウト ===== */
.logout{
    text-align:center;
    margin-top:30px;
    font-size:15px;
}

/* ===== アニメーション ===== */
@keyframes fadeIn{

    from{
        opacity:0;
        transform:translateY(10px);
    }

    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* ===== スマホ ===== */
@media(max-width:768px){

    body{
        padding:20px 10px;
    }

    .container{
        padding:25px;
    }

    h1{
        font-size:28px;
    }

    h2{
        font-size:20px;
    }

    table{
        display:block;
        overflow-x:auto;
    }

    th,
    td{
        white-space:nowrap;
    }
}

</style>

</head>

<body>

<div class="container">

    <h1>学生用ポータルサイト</h1>

    <p class="welcome">
        ようこそ、
        <strong>${loginStudent.name}</strong>
        さん！
    </p>

    <hr>

    <!-- 基本情報 -->
    <h2>あなたの基本情報</h2>

    <ul class="info-list">

        <li>
            <strong>学籍番号：</strong>
            ${loginStudent.no}
        </li>

        <li>
            <strong>氏名：</strong>
            ${loginStudent.name}
        </li>

        <li>
            <strong>入学年度：</strong>
            ${loginStudent.entYear} 年度
        </li>

        <li>
            <strong>クラス：</strong>
            ${loginStudent.classNum}
        </li>

    </ul>

    <hr>

    <!-- 最新成績 -->
    <h2>最新のテスト成績</h2>

    <div class="score-box">

        <c:choose>

            <c:when test="${empty latestScores}">

                <p class="no-data">
                    現在、登録されている最新の成績はありません。
                </p>

            </c:when>

            <c:otherwise>

                <table>

                    <thead>

                        <tr>
                            <th>科目コード</th>
                            <th>科目名</th>
                            <th style="text-align:right;">得点</th>
                        </tr>

                    </thead>

                    <tbody>

                        <c:forEach
                            var="test"
                            items="${latestScores}">

                            <tr>

                                <td>
                                    ${test.subject.cd}
                                </td>

                                <td>
                                    ${test.subject.name}
                                </td>

                                <td class="point">
                                    ${test.point} 点
                                </td>

                            </tr>

                        </c:forEach>

                    </tbody>

                </table>

            </c:otherwise>

        </c:choose>

    </div>

    <hr>

    <!-- 過去成績 -->
    <h2>過去の成績履歴</h2>

    <c:choose>

        <c:when test="${empty allScores}">

            <p class="no-data">
                過去の成績データはありません。
            </p>

        </c:when>

        <c:otherwise>

            <table>

                <thead>

                    <tr>
                        <th>回数</th>
                        <th>科目名</th>
                        <th style="text-align:right;">得点</th>
                    </tr>

                </thead>

                <tbody>

                    <c:forEach
                        var="test"
                        items="${allScores}">

                        <tr>

                            <td>
                                第 ${test.no} 回
                            </td>

                            <td>
                                ${test.subject.name}
                            </td>

                            <td class="point">
                                ${test.point} 点
                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </c:otherwise>

    </c:choose>

    <hr>

    <!-- メニュー -->
    <h2>メニュー</h2>

    <ul class="menu-list">

        <li>
            <a href="../action/StudentPasswordEdit.action">
                パスワードを変更する
            </a>
        </li>

    </ul>

    <!-- ログアウト -->
    <p class="logout">

        <a href="../login/login.jsp">
            ログアウトして戻る
        </a>

    </p>

</div>

</body>
</html>