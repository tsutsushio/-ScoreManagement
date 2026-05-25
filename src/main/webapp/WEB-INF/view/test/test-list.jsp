<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績参照</title>

<style>
/* ===== 全体 ===== */
body{
    font-family:"Yu Gothic","Meiryo",sans-serif;
    background:
        radial-gradient(circle at top,#ffffff,#eef4ff 60%);
    margin:0;
    padding:40px 20px;
    color:#333;
    min-height:100vh;
    display:flex;
    justify-content:center;
}

/* 戻るリンク */
.back-link{
    position:absolute;
    top:25px;
    left:30px;
    text-decoration:none;
    color:#4a90e2;
    font-size:14px;
    font-weight:bold;
    transition:0.2s;
}

.back-link:hover{
    color:#256fd1;
    transform:translateX(-2px);
}

/* ===== カード ===== */
.container{
    width:1000px;
    max-width:100%;
    background:white;
    border-radius:24px;
    padding:45px;
    box-sizing:border-box;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.08),
        0 3px 10px rgba(0,0,0,0.05);

    animation:fadeIn 0.4s ease;
}

/* タイトル */
h2{
    margin:0 0 40px;
    text-align:center;
    color:#4a90e2;
    font-size:32px;
    font-weight:bold;
    letter-spacing:2px;
}

/* ===== 検索エリア ===== */
.search-box{
    background:#f8fbff;
    border:1px solid #dce7f7;
    border-radius:20px;
    padding:28px;
    margin-bottom:35px;
}

/* 小タイトル */
.search-box h3{
    margin-top:0;
    margin-bottom:25px;
    color:#555;
    font-size:20px;
    border-left:5px solid #66a3ff;
    padding-left:12px;
}

/* ===== フォーム ===== */
form{
    display:flex;
    align-items:center;
    gap:18px;
    flex-wrap:nowrap;
    overflow-x:auto;
    padding-bottom:5px;
}

/* ラベル */
form{
    font-size:14px;
    font-weight:bold;
    color:#555;
    white-space:nowrap;
}

/* select */
select{
    min-width:170px;
    padding:12px 14px;
    border:1px solid #d6dfeb;
    border-radius:12px;
    background:white;
    font-size:15px;
    transition:0.2s;
    box-shadow:0 1px 4px rgba(0,0,0,0.05);
}

select:hover{
    border-color:#66a3ff;
}

select:focus{
    outline:none;
    border-color:#66a3ff;
    box-shadow:0 0 0 4px rgba(102,163,255,0.15);
}

/* ボタン */
button[type="submit"]{
    padding:12px 30px;
    border:none;
    border-radius:14px;
    background:linear-gradient(to right,#66a3ff,#4d8cff);
    color:white;
    font-size:15px;
    font-weight:bold;
    cursor:pointer;
    transition:0.25s;

    box-shadow:
        0 5px 12px rgba(77,140,255,0.25);
}

button[type="submit"]:hover{
    transform:translateY(-2px);
    box-shadow:
        0 8px 18px rgba(77,140,255,0.35);
}

button[type="submit"]:active{
    transform:scale(0.98);
}

/* ===== エラー ===== */
.error{
    margin-top:18px;
    padding:14px 18px;
    border-radius:12px;
    background:#fff1f1;
    border:1px solid #ffcaca;
    color:#e14d4d;
    font-weight:bold;
}

/* ===== テーブル ===== */
table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    overflow:hidden;
    border-radius:18px;

    box-shadow:
        0 4px 14px rgba(0,0,0,0.06);
}

/* ヘッダー */
th{
    background:
        linear-gradient(to right,#66a3ff,#4d8cff);

    color:white;
    padding:16px;
    font-size:14px;
    font-weight:bold;
    letter-spacing:0.5px;
}

/* データ */
td{
    background:white;
    padding:15px;
    border-bottom:1px solid #edf2f7;
    text-align:center;
    font-size:14px;
    transition:0.2s;
}

/* 偶数行 */
tbody tr:nth-child(even) td{
    background:#f8fbff;
}

/* hover */
tbody tr:hover td{
    background:#eef5ff;
}

/* 角丸 */
th:first-child{
    border-top-left-radius:18px;
}

th:last-child{
    border-top-right-radius:18px;
}

tbody tr:last-child td:first-child{
    border-bottom-left-radius:18px;
}

tbody tr:last-child td:last-child{
    border-bottom-right-radius:18px;
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

    h2{
        font-size:26px;
    }

    .search-box{
        padding:20px;
    }

    form{
        gap:12px;
    }

    select{
        min-width:140px;
    }

    th,
    td{
        font-size:13px;
        padding:12px;
    }
}
</style>

</head>

<body>
    <a href="${pageContext.request.contextPath}/action/Menu.action" class="back-link">
        ← メニューへ戻る
    </a>

    <div class="container">
        <h2>成績参照</h2>

        <div class="search-box">
            <h3>科目情報</h3>

            <form action="TestList.action" method="post">
                <input type="hidden" name="f" value="sj">

                入学年度
                <select name="f1">
                    <option value="">--------</option>
                    <c:forEach items="${yearList}" var="year">
                        <option value="${year}">${year}</option>
                    </c:forEach>
                </select>

                クラス
                <select name="f2">
                    <option value="">--------</option>
                    <c:forEach items="${classList}" var="cls">
                        <option value="${cls}">${cls}</option>
                    </c:forEach>
                </select>

                科目
                <select name="f3">
                    <option value="">--------</option>
                    <c:forEach items="${subjectList}" var="sub">
                        <option value="${sub.cd}">${sub.name}</option>
                    </c:forEach>
                </select>

                <button type="submit">検索</button>
            </form>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>

            <c:if test="${not empty testList}">
                <table>
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>回数</th>
                            <th>点数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${testList}" var="test">
                            <tr>
                                <td>${test.student.entYear}</td>
                                <td>${test.classNum}</td>
                                <td>${test.student.no}</td>
                                <td>${test.student.name}</td>
                                <td>${test.no}</td>
                                <td>${test.point}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</body>
</html>
