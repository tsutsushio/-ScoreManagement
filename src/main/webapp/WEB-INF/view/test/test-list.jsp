<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績参照</title>

<style>
/* システム共通のベーススタイル */
html, body { 
    height: 100%; 
    margin: 0; 
    padding: 0; 
    /* フォントをよりモダンで美しい文字の並び（Inter系やYuGothicM）に変更 */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #fafbfc; /* 明るく清潔感のあるモダンな背景 */
    color: #2b2d42; /* 文字色を優しい黒にして洗練された印象に */
}
body { display: flex; flex-direction: column; }
.container { display: flex; flex: 1; width: 100%; align-items: stretch; }
.main-content {
    flex: 1;
    padding: 40px 60px; /* 余白を広げてプレミアムな空気感に */
}

/* 画面タイトル（帯や左線をやめ、シンプルな文字と下線のみのミニマルスタイルに） */
h2.main-title { 
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; 
    border-bottom: 2px solid #e8ece9; /* 繊細な下線 */
}

/* 検索結果テーブル上の科目タイトル */
h2.subject-title { 
    font-size: 16px; 
    font-weight: 500; 
    letter-spacing: 0.03em;
    margin: 40px 0 15px 0; 
    color: #4a7c59; 
}

/* 検索ボックスエリア（「囲み枠」感を無くし、プレーンな白い1枚のカードに） */
.search-area {
    display: flex;
    align-items: center;
    gap: 30px;
    margin-bottom: 15px;
}
.search-box {
    border: none; /* 線を無くす */
    border-radius: 12px; /* 角丸を大きめにして柔らかく */
    padding: 30px;
    margin-bottom: 30px;
    background: #ffffff;
    /* 非常に繊細で柔らかい影（海外SaaS風） */
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
}
.info-title {
    width: 90px;
    font-size: 14px;
    font-weight: 600;
    color: #2c5234;
    flex-shrink: 0;
}

.search-form,
.student-form {
    display: flex;
    align-items: flex-end;
    gap: 24px;
    flex-wrap: nowrap;
    margin: 0;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-group label {
    font-size: 11px;
    color: #8a958f; /* 馴染むニュアンスグレー */
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

/* 入力・選択フォーム（グレーの枠線をやめ、背景にうっすら色がついたフラットデザインに） */
select, .student-no { 
    height: 40px; /* さらに高くしてスマートに */
    padding: 0 12px; 
    border: 1px solid transparent; /* 通常時は線を消す */
    border-radius: 8px; 
    font-size: 14px; 
    background-color: #f1f3f1; /* 薄いアッシュグリーングレーの背景 */
    color: #2b2d42;
    outline: none;
    transition: all 0.25s ease;
}
/* 入力中のエフェクト：背景が白になり、グリーンの細い線が浮き出る */
select:focus, .student-no:focus {
    background-color: #fff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

select { width: 140px; }
.student-no { width: 220px; }

/* ボタン（フラットで洗練されたニュアンスグリーン） */
button { 
    height: 40px; 
    padding: 0 28px; 
    background-color: #4a7c59; /* 優しくくすんだ緑 */
    color: #ffffff; 
    border: none; 
    border-radius: 8px; 
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    cursor: pointer; 
    transition: all 0.2s ease;
}
button:hover { 
    background-color: #3b6347; /* ホバー時は少し深いオリーブに */
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2); /* 浮き上がる影 */
}

.divider { 
    border: none; 
    border-top: 1px solid #edf0ee; 
    margin: 25px 0; 
}

/* 成績登録テーブル（「THE・表」っぽさを無くした、モダンでフラットなデザイン） */
table { 
    width: 100%; 
    border-collapse: collapse; 
    margin-top: 25px; 
    font-size: 14px; 
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); /* ボックスと影を統一 */
    overflow: hidden;
}
/* ヘッダーの背景塗りをやめ、白背景にシンプルな文字ラインのみに */
table th { 
    background-color: #ffffff; 
    color: #8a958f; /* 薄い色にしてデータ（数字）を引き立てる */
    padding: 18px 16px; 
    text-align: left; 
    font-weight: 600;
    font-size: 12px;
    letter-spacing: 0.05em;
    border-bottom: 2px solid #edf0ee;
}
table td { 
    border-bottom: 1px solid #f4f6f5; 
    padding: 16px 16px; /* 余白を贅沢に取って数字を美しく見せる */
    color: #2b2d42; 
}
/* 行の交互の色（ストライプ）を無くし、マウスホバーだけですっきりと見せる */
table tr:hover td {
    background-color: #f7f9f8;
}

/* メッセージ・エラー */
.initial-msg { 
    color: #4a7c59; 
    font-size: 13px; 
}
.input-error { 
    color: #e63946; /* スタイリッシュなくすみ赤 */
    font-size: 13px; 
    font-weight: 600;
    margin: 8px 0; 
}
.message-box { 
    color: #2c5234; 
    font-size: 13px; 
    margin-bottom: 20px; 
    padding: 12px 18px;
    background-color: #edf2ee; /* ミニマルなトーンに合わせた淡い緑背景 */
    border-radius: 8px;
    border-left: 3px solid #4a7c59;
}

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
        <c:if test="${empty searchType}">
		    <p class="initial-msg">
		        科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
		    </p>
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
				        <p>
				            学生番号: ${student.no}
				            &nbsp;&nbsp;
				            氏名: ${student.name}
				        </p>
				    </c:if>
				
				    <p class="error">${error}</p>


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