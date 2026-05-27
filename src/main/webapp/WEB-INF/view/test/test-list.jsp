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
    font-family:
    "Yu Gothic","Meiryo",sans-serif;

    background:
    linear-gradient(
        135deg,
        #f8fbff,
        #eef5ff
    );

    margin:0;
    padding:40px 20px;

    color:#333;
    min-height:100vh;

    display:flex;
    justify-content:center;
}

/* 戻る */
.back-link{
    position:absolute;
    top:25px;
    left:30px;

    text-decoration:none;
    color:#5b8def;

    font-size:14px;
    font-weight:bold;

    transition:0.2s;
}

.back-link:hover{
    color:#3474e0;
    transform:translateX(-3px);
}

/* ===== メインカード ===== */
.container{
    width:1000px;
    max-width:100%;

    background:white;

    border-radius:28px;
    padding:45px;

    box-sizing:border-box;

    box-shadow:
        0 18px 40px rgba(61,115,196,0.08),
        0 4px 12px rgba(0,0,0,0.04);

    animation:fadeIn .4s ease;
}

/* タイトル */
h2{
    margin:0 0 35px;

    text-align:center;

    color:#5b8def;

    font-size:34px;
    font-weight:700;
    letter-spacing:2px;
}

/* ===== 検索エリア ===== */
.search-box{
    background:
    linear-gradient(
        180deg,
        #fbfdff,
        #f5f9ff
    );

    border:1px solid #dce8f7;

    border-radius:24px;

    padding:32px;

    margin-bottom:35px;

    box-shadow:
        inset 0 1px 0 rgba(255,255,255,0.8);
}

/* 小見出し */
.search-box h3{
    margin:0 0 22px;

    color:#4c5b70;

    font-size:20px;
    font-weight:bold;

    border-left:6px solid #7db5ff;
    padding-left:12px;
}

/* ===== フォーム ===== */
.search-form,
.student-form{
    display:flex;
    align-items:flex-end;
    gap:18px;
    flex-wrap:wrap;
}

/* グループ */
.form-group{
    display:flex;
    flex-direction:column;
    gap:8px;
}

/* ラベル */
label{
    font-size:13px;
    font-weight:bold;
    color:#687385;
}

/* ===== 入力 ===== */
select,
.student-no{
    min-width:180px;

    padding:13px 15px;

    border:
    1px solid #d8e1ee;

    border-radius:14px;

    background:white;

    font-size:15px;

    transition:.2s;

    box-shadow:
        0 2px 6px rgba(0,0,0,0.04);
}

/* 学生番号だけ少し強調 */
.student-no{
    min-width:220px;

    background:
    linear-gradient(
        to bottom,
        #ffffff,
        #f8fbff
    );

    border:2px solid #dce7f7;
}

/* hover */
select:hover,
.student-no:hover{
    border-color:#86b6ff;
}

/* focus */
select:focus,
.student-no:focus{
    outline:none;

    border-color:#5b8def;

    box-shadow:
        0 0 0 5px
        rgba(91,141,239,.15);
}

/* プレースホルダ */
.student-no::placeholder{
    color:#a5afbd;
}

/* ===== ボタン ===== */
button[type="submit"]{
    height:48px;

    padding:0 28px;

    border:none;
    border-radius:14px;

    background:
    linear-gradient(
        to right,
        #6aa7ff,
        #5b8def
    );

    color:white;

    font-size:15px;
    font-weight:bold;

    cursor:pointer;

    transition:.25s;

    box-shadow:
        0 6px 14px
        rgba(91,141,239,.28);
}

button[type="submit"]:hover{
    transform:translateY(-2px);

    box-shadow:
        0 10px 18px
        rgba(91,141,239,.35);
}

button[type="submit"]:active{
    transform:scale(.98);
}

/* ===== 区切り線 ===== */
.divider{
    border:none;
    height:1px;

    background:
    linear-gradient(
        to right,
        transparent,
        #d7e5f7,
        transparent
    );

    margin:32px 0;
}

/* ===== エラー ===== */
.error{
    margin-top:20px;

    padding:15px 18px;

    border-radius:14px;

    background:#fff3f3;
    border:1px solid #ffcaca;

    color:#dd5050;
    font-weight:bold;
}

/* ===== テーブル ===== */
table{
    width:100%;

    border-collapse:separate;
    border-spacing:0;

    overflow:hidden;

    border-radius:22px;

    box-shadow:
        0 8px 24px
        rgba(0,0,0,.06);
}

/* ヘッダー */
th{
    background:
    linear-gradient(
        to right,
        #69a5ff,
        #5b8def
    );

    color:white;

    padding:18px 14px;

    font-size:14px;
    font-weight:bold;
    letter-spacing:.5px;
}

/* セル */
td{
    background:white;

    padding:16px 14px;

    text-align:center;

    border-bottom:
    1px solid #edf2fa;

    transition:.2s;
}

/* 偶数行 */
tbody tr:nth-child(even) td{
    background:#f9fbff;
}

/* hover */
tbody tr:hover td{
    background:#eef5ff;
}

/* 最終行 */
tbody tr:last-child td{
    border-bottom:none;
}

/* 角丸 */
th:first-child{
    border-top-left-radius:22px;
}

th:last-child{
    border-top-right-radius:22px;
}

tbody tr:last-child td:first-child{
    border-bottom-left-radius:22px;
}

tbody tr:last-child td:last-child{
    border-bottom-right-radius:22px;
}

/* ===== アニメ ===== */
@keyframes fadeIn{
    from{
        opacity:0;
        transform:translateY(12px);
    }

    to{
        opacity:1;
        transform:translateY(0);
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

    <!-- 科目検索 -->
    <form action="TestList.action" method="post"
          class="search-form">

        <input type="hidden"
               name="f"
               value="sj">

        <div class="form-group">
            <label>入学年度</label>
            <select name="f1">
                <option value="">--------</option>
                <c:forEach items="${yearList}"
                           var="year">
                    <option value="${year}">
                        ${year}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>クラス</label>
            <select name="f2">
                <option value="">--------</option>
                <c:forEach items="${classList}"
                           var="cls">
                    <option value="${cls}">
                        ${cls}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>科目</label>
            <select name="f3">
                <option value="">--------</option>
                <c:forEach items="${subjectList}"
                           var="sub">
                    <option value="${sub.cd}">
                        ${sub.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <button type="submit">
            検索
        </button>
    </form>

    <hr class="divider">

    <h3>学生情報</h3>

    <!-- 学生番号検索 -->
    <form action="TestList.action"
          method="post"
          class="student-form">

        <input type="hidden"
               name="f"
               value="sj">

        <!-- 科目情報引き継ぎ -->
        <input type="hidden"
               name="f1"
               value="${param.f1}">

        <input type="hidden"
               name="f2"
               value="${param.f2}">

        <input type="hidden"
               name="f3"
               value="${param.f3}">

        <div class="form-group">
            <label>学生番号</label>

            <input
                type="text"
                name="f4"
                class="student-no"
                placeholder=
                "学生番号を入力"
                value="${param.f4}">
        </div>

        <button type="submit">
            検索
        </button>
    </form>

</div>

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
