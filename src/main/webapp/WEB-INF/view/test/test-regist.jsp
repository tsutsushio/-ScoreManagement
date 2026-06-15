<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績登録</title>

<style>
    /* システム共通スタイル */
    html, body { height: 100%; margin: 0; padding: 0; font-family: "Yu Gothic", sans-serif; background-color: #ffffff; }
    body { display: flex; flex-direction: column; }
    .container { display: flex; flex: 1; width: 100%; align-items: stretch; }
    .main-content { flex: 1; padding: 20px 40px; box-sizing: border-box; }

    /* ① 見出し「成績登録」（グレーの帯） */
    h2 { font-size: 18px; font-weight: bold; background-color: #f2f2f2; padding: 10px 15px; margin: 0 0 20px 0; color: #333; }

    /* 戻るリンク */
    .back-link { display: inline-block; color: #0066ff; text-decoration: underline; font-size: 14px; margin-bottom: 15px; }

    /* 検索・結果エリア */
    .search-form { display: flex; align-items: flex-end; gap: 15px; flex-wrap: wrap; background-color: #ffffff; border: 1px solid #ccc; border-radius: 4px; padding: 20px; margin-bottom: 30px; }
    .search-item { display: flex; flex-direction: column; gap: 6px; }
    .search-item label { font-size: 13px; color: #333; font-weight: bold; }
    select, input[type="number"] { height: 32px; padding: 4px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
    button { height: 32px; padding: 0 20px; background-color: #666; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    button:hover { background-color: #333; }

    /* テーブル・ボタン */
    table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 14px; }
    table th { border-bottom: 2px solid #333; padding: 10px; text-align: left; color: #333; }
    table td { border-bottom: 1px solid #eee; padding: 10px; color: #555; }
    .error-msg { color: #d9534f; background: #fbebeb; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 15px; font-size: 13px; font-weight: bold; }
    .register-btn button { background-color: #6c757d; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-top: 20px; }
    .register-btn button:hover { background-color: #5a6268; }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <h2>成績登録</h2>

        <form action="TestSearch.action" method="post" class="search-form">
            <div class="search-item">
                <label>入学年度</label>
                <select name="entYear" required><option value="">--選択--</option>
                    <c:forEach var="year" items="${entYearList}"><option value="${year}" ${year == fEntYear ? 'selected' : ''}>${year}</option></c:forEach>
                </select>
            </div>
            <div class="search-item">
                <label>クラス</label>
                <select name="classNum" required><option value="">--選択--</option>
                    <c:forEach var="cNum" items="${classList}"><option value="${cNum}" ${cNum == fClassNum ? 'selected' : ''}>${cNum}</option></c:forEach>
                </select>
            </div>
            <div class="search-item">
                <label>科目</label>
                <select name="subjectCd" required><option value="">--選択--</option>
                    <c:forEach var="subject" items="${subjectList}"><option value="${subject.cd}" ${subject.cd == fSubjectCd ? 'selected' : ''}>${subject.name}</option></c:forEach>
                </select>
            </div>
            <div class="search-item">
                <label>回数</label>
                <input type="number" name="no" min="1" required value="${fNo}">
            </div>
            <button type="submit">検索</button>
        </form>

        <c:if test="${not empty testList}">
            <c:if test="${not empty errors.point}"><div class="error-msg">${errors.point}</div></c:if>
            <form action="TestRegistExecute.action" method="post">
                <table>
                    <tr><th>入学年度</th><th>クラス</th><th>学生番号</th><th>氏名</th><th>点数</th></tr>
                    <c:forEach var="test" items="${testList}">
                        <tr>
                            <td>${test.student.entYear}</td><td>${test.classNum}</td><td>${test.student.no}</td><td>${test.student.name}</td>
                            <td><input type="number" name="point_${test.student.no}" value="${test.point}" min="0" max="100"></td>
                        </tr>
                    </c:forEach>
                </table>
                <input type="hidden" name="subjectCd" value="${fSubjectCd}">
                <input type="hidden" name="no" value="${fNo}">
                <input type="hidden" name="classNum" value="${fClassNum}">
                <div class="register-btn"><button type="submit">登録して終了</button></div>
            </form>
        </c:if>
        <c:if test="${testList != null and empty testList}"><p>該当者がいません</p></c:if>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>