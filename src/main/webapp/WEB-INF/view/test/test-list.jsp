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

    /* ① 見出し「成績参照」（グレーの帯） */
    h2 { font-size: 18px; font-weight: bold; background-color: #f2f2f2; padding: 10px 15px; margin: 0 0 20px 0; color: #333; }

    /* 戻るリンク */
    .back-link { display: inline-block; color: #0066ff; text-decoration: underline; font-size: 14px; margin-bottom: 15px; }

    /* 検索ボックス */
    .search-box { border: 1px solid #ccc; border-radius: 4px; padding: 20px; margin-bottom: 30px; background-color: #ffffff; }
    .search-box h3 { font-size: 13px; color: #333; margin: 0 0 10px 0; font-weight: bold; }
    .form-group { display: flex; flex-direction: column; gap: 4px; }
    .form-group label { font-size: 12px; color: #666; }
    .search-form, .student-form { display: flex; align-items: flex-end; gap: 15px; flex-wrap: wrap; margin-bottom: 20px; }
    
    select, .student-no { height: 32px; padding: 4px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
    button { height: 32px; padding: 0 20px; background-color: #666; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    button:hover { background-color: #333; }
    
    .divider { border: none; border-top: 1px solid #eee; margin: 20px 0; }

    /* テーブル */
    table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 14px; }
    table th { border-bottom: 2px solid #333; padding: 10px; text-align: left; color: #333; }
    table td { border-bottom: 1px solid #eee; padding: 10px; color: #555; }

    /* メッセージ */
    .initial-msg { color: #0066cc; font-size: 13px; }
    .error { color: #d9534f; font-size: 13px; font-weight: bold; }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        
        <h2>
    成績参照
    <c:choose>
        <c:when test="${searchType eq 'sj'}">（科目）</c:when>
        <c:when test="${searchType eq 'st'}">（学生）</c:when>
    </c:choose>
</h2>

        <div class="search-box">
            <h3>科目情報</h3>
            <form action="TestList.action" method="post" class="search-form">
                <input type="hidden" name="f" value="sj">
                <div class="form-group">
                    <label>入学年度</label>
                    <select name="f1">
                        <option value="">--------</option>
                        <c:forEach items="${yearList}" var="year">
                            <option value="${year}" ${param.f1 == year ? 'selected' : ''}>${year}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>クラス</label>
                    <select name="f2">
                        <option value="">--------</option>
                        <c:forEach items="${classList}" var="cls">
                            <option value="${cls}" ${param.f2 == cls ? 'selected' : ''}>${cls}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>科目</label>
                    <select name="f3">
                        <option value="">--------</option>
                        <c:forEach items="${subjectList}" var="sub">
                            <option value="${sub.cd}" ${param.f3 == sub.cd ? 'selected' : ''}>${sub.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit">検索</button>
            </form>

            <hr class="divider">

            <h3>学生情報</h3>
            <form action="TestList.action" method="post" class="student-form">
                <input type="hidden" name="f" value="st">
                <input type="hidden" name="f1" value="${param.f1}">
                <input type="hidden" name="f2" value="${param.f2}">
                <input type="hidden" name="f3" value="${param.f3}">
                <div class="form-group">
                    <label>学生番号</label>
                    <input type="text" name="f4" class="student-no" value="${param.f4}">
                </div>
                <button type="submit">検索</button>
            </form>
        </div>

        <c:if test="${empty testList and empty error}">
            <p class="initial-msg">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <!-- 科目検索結果 -->
        <c:if test="${searchType eq 'sj' and not empty testList}">
        <p>
    科目：${subjectName}
</p>
            <table>
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>1回</th>
						<th>2回</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${testList}" var="test">
                        <tr>
                            <td>${test.student.entYear}</td>
                            <td>${test.classNum}</td>
                            <td>${test.student.no}</td>
                            <td>${test.student.name}</td>
                            <td>${empty test.point1 ? "-" : test.point1}</td>
							<td>${empty test.point2 ? "-" : test.point2}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- 学生検索結果 -->
        <c:if test="${searchType eq 'st' and not empty testList}">
            <c:if test="${not empty student}">
                <p>
                    学生番号：${student.no}
                    &nbsp;&nbsp;
                    氏名：${student.name}
                </p>
            </c:if>
            <table>
                <thead>
                    <tr>
                        <th>科目名</th>
                        <th>科目コード</th>
                        <th>回数</th>
                        <th>点数</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${testList}" var="test">
                        <tr>
                            <td>${test.subject.name}</td>
                            <td>${test.subject.cd}</td>
                            <td>${test.no}</td>
                            <td>${test.point}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div> <!-- .main-content の閉じタグ -->
</div> <!-- .container の閉じタグ -->

<%@ include file="/footer.jsp" %>
</body>
</html>
