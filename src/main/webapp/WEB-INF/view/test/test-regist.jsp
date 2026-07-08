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

/* ① 画面上部のタイトル「成績管理」（グレーの帯） */
h2.main-title { 
    font-size: 18px; 
    font-weight: bold; 
    background-color: #f2f2f2; 
    padding: 10px 15px; 
    margin: 0 0 20px 0; 
    color: #333; /* 必要に応じて少し丸みを持たせる */
}

/* ② テーブル上部の「科目：Python1（1回）」（帯なし・すっきりした文字） */
h2.subject-title { 
    font-size: 16px; 
    font-weight: bold; 
    background-color: transparent; /* 背景色を透明にする */
    padding: 0; 
    margin: 20px 0 15px 0; 
    color: #333; 
}

/* 入力欄の下に表示するエラーメッセージのスタイル */
.input-error-msg {
    color: #f0ad4e;       /* 画像のような少し暗めのオレンジ色 */
    font-size: 12px;      /* 文字を少し小さく */
    margin-top: 4px;      /* 入力欄との間のスキマ */
    display: block;       /* 必ず入力欄の下に回り込ませる */
    background: none;     /* 背景はなし */
    border: none;         /* 枠線もなし */
    padding: 0;           /* 余白もなし */
}


    /* 検索・結果エリア */
    .search-form { display: flex; align-items: flex-end; gap: 15px; flex-wrap: wrap; background-color: #ffffff; border: 1px solid #ccc; border-radius: 4px; padding: 20px; margin-bottom: 30px; }
    .search-item { display: flex; flex-direction: column; gap: 6px; }
    .search-item label { font-size: 13px; color: #333; font-weight: bold; }
    select { height: 32px; padding: 4px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
    button, input[type="submit"] { height: 32px; padding: 0 20px; background-color: #666; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    button:hover, input[type="submit"]:hover { background-color: #333; }

    /* テーブル・ボタン */
    table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 14px; }
    table th { border-bottom: 2px solid #333; padding: 10px; text-align: left; color: #333; }
    table td { border-bottom: 1px solid #eee; padding: 10px; color: #555; }
    .error-msg { color: #d9534f; background: #fbebeb; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 15px; font-size: 13px; font-weight: bold; }
    .register-btn { margin-top: 20px; }
    .register-btn input[type="submit"] { background-color: #6c757d; }
    .register-btn input[type="submit"]:hover { background-color: #5a6268; }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        <!-- 旧 <h2>成績登録</h2> -->
<h2 class="main-title">成績管理</h2>


        <!-- 検索フォーム -->
        <form action="TestSearch.action" method="post" class="search-form">
				<div class="search-item">
				    <label>入学年度</label>
				    <select name="f1">
				        <option value="">--------</option>
				        <c:forEach var="year" items="${entYearList}">
				            <option value="${year}" ${year == fEntYear ? 'selected' : ''}>${year}</option>
				        </c:forEach>
				    </select>
				</div>
            <div class="search-item">
                <label>クラス</label>
                <select name="f2">
                    <option value="">--------</option>
                    <c:forEach var="cNum" items="${classList}">
                        <option value="${cNum}" ${cNum == fClassNum ? 'selected' : ''}>${cNum}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="search-item">
                <label>科目</label>
                <select name="f3">
                    <option value="">--------</option>
                    <c:forEach var="subject" items="${subjectList}">
                        <option value="${subject.cd}" ${subject.cd == fSubjectCd ? 'selected' : ''}>${subject.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="search-item">
                <label>回数</label>
                <select name="f4">
                    <option value="">--------</option>
                    <c:forEach var="num" items="${noList}">
                        <option value="${num}" ${num == fNo ? 'selected' : ''}>${num}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit">検索</button>
        </form>

        <!-- 🌟 エラーメッセージ表示エリア -->
        <c:if var="hasError" test="${not empty errors.point}">
            <div class="error-msg">${errors.point}</div>
        </c:if>

        <!-- 検索結果および成績一覧テーブル（要件準拠） -->
        <c:if test="${not empty testList}">
            <!-- 🌟 見出し(H2): 科目名と何回目かを表示する要件 -->
<h2 class="subject-title">科目：${subjectName} （${fNo}回）</h2>


            <form action="TestRegistExecute.action" method="post">
                <table>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>点数</th>
                    </tr>
                    <c:forEach var="test" items="${testList}">
                        <tr>
                            <!-- 定義書通りのデータマッピング -->
                            <td>${test.student.entYear}</td>
                            <td>${test.classNum}</td>
                            <td>${test.student.no}</td>
                            <td>${test.student.name}</td>
                            <td>
							    <input type="text"
							           name="point_${test.student.no}"
							           value="${test.point != 0 ? test.point : ''}">
							
							    <c:if test="${not empty errors[test.student.no]}">
							        <div class="input-error-msg">
							            ${errors[test.student.no]}
							        </div>
							    </c:if>
							</td>
                        </tr>
                    </c:forEach>
                </table>

                <!-- 次のActionに検索条件を引き継ぐための隠しパラメータ（f2〜f4） -->

                <input type="hidden" name="f1" value="${fEntYear}">

                <input type="hidden" name="f2" value="${fClassNum}">
                <input type="hidden" name="f3" value="${fSubjectCd}">
                <input type="hidden" name="f4" value="${fNo}">

                <!-- 🌟 登録して終了ボタン（定義書通り input[type="submit"] へ変更） -->
                <div class="register-btn">
                    <input type="submit" value="登録して終了">
                </div>
            </form>
        </c:if>
        
        <c:if test="${testList != null and empty testList and !hasError}">
            <p>該当者がいません</p>
        </c:if>
    </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>
