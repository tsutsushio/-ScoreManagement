<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績参照</title>

<style>
    /* システム共通のベーススタイル */
    html, body { height: 100%; margin: 0; padding: 0; font-family: "Yu Gothic", sans-serif; background-color: #ffffff; }
    body { display: flex; flex-direction: column; }
    .container { display: flex; flex: 1; width: 100%; align-items: stretch; }
    .main-content { flex: 1; padding: 20px 40px; box-sizing: border-box; }

    /* 画面タイトル（グレーの帯） */
    h2.main-title { font-size: 18px; font-weight: bold; background-color: #f2f2f2; padding: 10px 15px; margin: 0 0 20px 0; color: #333; }

    /* 検索結果テーブル上の科目タイトル（文字のみ） */
    h2.subject-title { font-size: 16px; font-weight: bold; background-color: transparent; padding: 0; margin: 20px 0 15px 0; color: #333; }

    /* 検索ボックスエリア(No2: 科目情報div) */
/* 検索エリア */
.search-area{
    display:flex;
    align-items:center;
    gap:30px;
    margin-bottom:15px;
}
.search-box{
    border:1px solid #dcdcdc;
    border-radius:6px;
    padding:20px;
    margin-bottom:25px;
    background:#fff;
}
.info-title{
    width:90px;
    font-size:13px;
    font-weight:bold;
    color:#333;
    flex-shrink:0;
}

.search-form,
.student-form{
    display:flex;
    align-items:flex-end;
    gap:20px;
    flex-wrap:nowrap;
    margin:0;
}

.form-group{
    display:flex;
    flex-direction:column;
    gap:4px;
}

.form-group label{
    font-size:12px;
    color:#666;
}

select{
    width:120px;
    height:32px;
    padding:4px 8px;
    border:1px solid #ccc;
    border-radius:4px;
    font-size:14px;
}

.student-no{
    width:210px;
    height:32px;
    padding:4px 8px;
    border:1px solid #ccc;
    border-radius:4px;
    font-size:14px;
}

button{
    height:32px;
    padding:0 20px;
    background:#6c757d;
    color:#fff;
    border:none;
    border-radius:4px;
    cursor:pointer;
}

button:hover{
    background:#495057;
}

.divider{
    border:none;
    border-top:1px solid #e5e5e5;
    margin:18px 0;
}
    select, .student-no { height: 32px; padding: 4px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
    button { height: 32px; padding: 0 20px; background-color: #666; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    button:hover { background-color: #333; }
    .divider { border: none; border-top: 1px solid #eee; margin: 20px 0; }

    /* テーブル */
    table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 14px; }
    table th { border-bottom: 2px solid #333; padding: 10px; text-align: left; color: #333; }
    table td { border-bottom: 1px solid #eee; padding: 10px; color: #555; }
    .initial-msg { color: #28a745; font-size: 13px; }
.input-error{
    color:#f0ad4e;
    font-size:13px;
    margin:8px 0;
}

.message-box{
    color:#333;
    font-size:13px;
    margin-bottom:15px;
}

<<<<<<< HEAD
/* テーブルの偶数行（2, 4, 6行目...）の背景色を薄いグレーにする */
table tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* 【プロの小技】マウスを乗せた行の色を変えるとさらに分かりやすいです */
table tr:hover {
    background-color: #f0f5fa; /* ほんのり薄い青色 */
}
=======
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <!-- No1: 画面タイトル -->
        <h2 class="main-title">
            成績参照
            <c:choose>
                <c:when test="${searchType eq 'sj'}">（科目）</c:when>
                <c:when test="${searchType eq 'st'}">（学生）</c:when>
            </c:choose>
        </h2>


        <!-- No2: 科目情報ブロック -->
        <div class="search-box">
	       <div class="search-area">
	
		    <div class="info-title">科目情報</div>
		
		    <form action="TestList.action" method="post" class="search-form">
		
		        <input type="hidden" name="f" value="sj">
		
		        <div class="form-group">
		            <label>入学年度</label>
		            <select name="f1">
		                <option value="">--------</option>
		                <c:forEach items="${yearList}" var="year">
		                    <option value="${year}" ${f1 == year ? 'selected' : ''}>
		                        ${year}
		                    </option>
		                </c:forEach>
		            </select>
		        </div>
		
		        <div class="form-group">
		            <label>クラス</label>
		            <select name="f2">
		                <option value="">--------</option>
		                <c:forEach items="${classList}" var="cls">
		                    <option value="${cls}" ${f2 == cls ? 'selected' : ''}>
		                        ${cls}
		                    </option>
		                </c:forEach>
		            </select>
		        </div>
		
		        <div class="form-group">
		            <label>科目</label>
		            <select name="f3">
		                <option value="">--------</option>
		                <c:forEach items="${subjectList}" var="sub">
		                    <option value="${sub.cd}" ${f3 == sub.cd ? 'selected' : ''}>
		                        ${sub.name}
		                    </option>
		                </c:forEach>
		            </select>
		        </div>
		
		        <button type="submit">検索</button>
		
		    </form>
		
		</div>


<c:if test="${not empty inputError}">
    <p class="input-error">${inputError}</p>
</c:if>

<hr class="divider">


<div class="search-area">

    <div class="info-title">学生情報</div>

    <form action="TestList.action" method="post" class="student-form">

        <input type="hidden" name="f" value="st">
        <input type="hidden" name="f1" value="${f1}">
        <input type="hidden" name="f2" value="${f2}">
        <input type="hidden" name="f3" value="${f3}">

        <div class="form-group">
            <label>学生番号</label>

            <input
                type="text"
                name="f4"
                class="student-no"
                value="${f4}"
                maxlength="10"
                required
                placeholder="学生番号を入力してください">

        </div>

        <button type="submit">検索</button>

    </form>

</div>
		</div>

        <!-- 科目エラー・共通エラー表示エリア -->
<c:if test="${not empty message}">
    <div class="message-box">
        ${message}
    </div>
</c:if>
        <!-- No14: 利用方法案内メッセージ（未検索かつエラーなし時） -->
        <c:if test="${empty testList and empty error and empty errors}">
            <p class="initial-msg">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</p>
        </c:if>

        <!-- 科目検索結果一覧表示テーブル -->
        <c:if test="${searchType eq 'sj' and not empty testList}">
            <h2 class="subject-title">科目：${subjectName} （コード: ${f3}）</h2>
            <table>
                <thead>
                    <tr>
                        <th>入学年度</th><th>クラス</th><th>学生番号</th><th>氏名</th><th>1回</th><th>2回</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${testList}" var="test">
                        <tr>
                            <td>${test.student.entYear}</td>
                            <td>${test.classNum}</td>
                            <td>${test.student.no}</td>
                            <td>${test.student.name}</td>
                            <!-- 点数未登録(空値)の場合は「-」を表示する要件 -->
                            <td>
                                <c:choose>
                                    <c:when test="${empty test.point1 or test.point1 == -1}">-</c:when>
                                    <c:otherwise>${test.point1}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty test.point2 or test.point2 == -1}">-</c:when>
                                    <c:otherwise>${test.point2}</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- 学生検索結果一覧表示テーブル -->
        <c:if test="${searchType eq 'st' and not empty testList}">
            <!-- No1: 「氏名：学生氏名(学生番号)」のかっこ書き固定値要件 -->
            <c:if test="${not empty student}">
                <div style="font-size: 14px; font-weight: bold; margin: 20px 0 10px 0; color: #333;">
                    氏名：${student.name}（${student.no}）
                </div>
            </c:if>
            <table>
                <thead>
                    <tr>
                        <th>科目名</th><th>科目コード</th><th>回数</th><th>点数</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${testList}" var="test">
                        <!-- No2の備考要件：点数が入力（登録）されていない成績情報は一覧に表示しない -->
                        <c:if test="${not empty test.point and test.point != -1}">
                            <tr>
                                <td>${test.subject.name}</td>
                                <td>${test.subject.cd}</td>
                                <td>${test.no}</td>
                                <td>${test.point}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>