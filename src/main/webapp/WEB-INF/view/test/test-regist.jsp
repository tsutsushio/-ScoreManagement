<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 成績登録</title>

<style>
/* システム共通スタイル */
html, body { 
    height: 100%; 
    margin: 0; 
    padding: 0; 
    /* フォントをより洗練されたモダンな並びに */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Yu Gothic Medium", sans-serif; 
    background-color: #f4f6f4; /* ★ ご要望：全体をリラックスできる薄い緑に変更 */
    color: #2b2d42; /* 文字色を優しいチャコールにして洗練された印象に */
}
body { 
    display: flex; 
    flex-direction: column; 
}
.container { 
    display: flex; 
    flex: 1; 
    width: 100%; 
    align-items: stretch; 
    background-color: #fafbfc; /* ★ コンテナの背景も薄い緑に統一 */
}
.main-content { 
    flex: 1; 
    padding: 40px 60px; /* 余白を贅沢に広げてプレミアムな空気感に */
    box-sizing: border-box; 
}

/* ① 画面上部のタイトル「成績管理」（グレーの帯を廃止し、繊細な下線と文字のみに） */
h2.main-title { 
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; /* メインの深緑 */
}

/* ② テーブル上部の「科目：Python1（1回）」 */
h2.subject-title { 
    font-size: 16px; 
    font-weight: 500; 
    letter-spacing: 0.03em;
    background-color: transparent; 
    padding: 0; 
    margin: 40px 0 15px 0; 
    color: #4a7c59; /* アクセントのグリーン */
}

/* 入力欄の下に表示するエラーメッセージのスタイル */
.input-error-msg {
    color: #e63946;       /* スタイリッシュで目に留まりやすい「くすみ赤」に変更 */
    font-size: 12px;      
    font-weight: 600;
    margin-top: 6px;      
    display: block;       
    background: none;     
    border: none;         
    padding: 0;           
}

/* 検索・結果エリア（「囲み枠」感を無くし、プレーンな白い1枚のカードに） */
.search-form { 
    display: flex; 
    align-items: flex-end; 
    gap: 20px; 
    flex-wrap: wrap; 
    background-color: #ffffff; /* 白いカードとして浮き立たせる */
    border: 1px solid #edf0ee; 
    border-radius: 12px; /* 角丸を大きめにして柔らかく */
    padding: 30px; 
    margin-bottom: 30px; 
    /* 海外SaaS風の、ものすごく薄くて広い上質な影 */
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
}
.search-item { 
    display: flex; 
    flex-direction: column; 
    gap: 8px; 
}
.search-item label { 
    font-size: 11px; 
    color: #8a958f; /* 馴染むニュアンスグレー */
    font-weight: 600; 
    letter-spacing: 0.05em;
}

/* 入力・選択フォーム（グレーの枠線をやめ、背景にうっすら色がついたフラットデザインに） */
select, input[type="text"], input[type="number"] { 
    height: 40px; /* 高さを出してスマートに */
    padding: 0 12px; 
    border: 1px solid transparent; 
    border-radius: 8px; 
    font-size: 14px; 
    background-color: #f1f3f1; /* 薄いアッシュグリーングレーの背景 */
    color: #2b2d42;
    outline: none;
    box-sizing: border-box;
    transition: all 0.25s ease;
}
/* フォーカス時：背景が白になり、グリーンの細い線が浮き出る */
select:focus, input[type="text"]:focus, input[type="number"]:focus {
    background-color: #ffffff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

/* 一般ボタン・検索ボタン（フラットで洗練されたニュアンスグリーン） */
button, input[type="submit"] { 
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
button:hover, input[type="submit"]:hover { 
    background-color: #3b6347; /* ホバー時は少し深いオリーブに */
    box-shadow: 0 4px 12px rgba(74, 124, 89, 0.2); 
}

/* テーブル・ボタン */
table { 
    width: 100%; 
    border-collapse: collapse; 
    margin-top: 25px; 
    font-size: 14px; 
    background: #ffffff; /* 白いカードとして浮き立たせる */
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
    overflow: hidden;
    border: 1px solid #edf0ee;
}
/* ヘッダーの背景塗りをやめ、白背景にシンプルな文字ラインのみに */
table th { 
    background-color: #ffffff; 
    color: #8a958f; /* 薄い色にしてデータ（数字や名前）を引き立てる */
    padding: 18px 16px; 
    text-align: left; 
    font-weight: 600; 
    font-size: 12px;
    letter-spacing: 0.05em;
    border-bottom: 2px solid #edf0ee;
}
table td { 
    border-bottom: 1px solid #f4f6f5; 
    padding: 16px 16px; /* 余白を贅沢に取ってスッキリ見せる */
    color: #2b2d42; 
}
/* 行ホバー時にうっすら色を変えて、今どこの行を見ているか分かりやすく */
table tr:hover td {
    background-color: #f7f9f8;
}

/* システム全体に通知するエラーメッセージ（画面上部など） */
.error-msg { 
    color: #2c5234; 
    font-size: 13px; 
    margin-bottom: 25px; 
    padding: 14px 20px;
    background-color: #edf2ee; /* ミニマルなトーンに合わせた淡い緑背景 */
    border-radius: 8px;
    border-left: 4px solid #e63946; /* 左端の線だけ赤にして警告を示す */
    box-shadow: 0 2px 10px rgba(0,0,0,0.02);
}

/* 登録ボタンエリア */
.register-btn { 
    margin-top: 30px; 
    display: flex;
    justify-content: flex-end; /* ボタンを右寄せにしてモダンな配置に */
}
/* 登録ボタンは一番重要なアクションなので、一段階深い「メインの深緑」にしてメリハリを */
.register-btn input[type="submit"] { 
    background-color: #2c5234; 
    padding: 0 40px; /* 横幅を少し広げて押しやすく */
}
.register-btn input[type="submit"]:hover { 
    background-color: #1e3b24; 
}

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
