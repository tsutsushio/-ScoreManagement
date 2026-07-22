<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 席替え</title>
<style>
/* システム共通スタイル */
html, body { 
    height: 100%; 
    margin: 0; 
    padding: 0; 
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; 
    background-color: #f4f6f4; 
    color: #2b2d42; 
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
    background-color: #fafbfc; 
}
.main-content { 
    flex: 1; 
    padding: 40px 60px; 
    box-sizing: border-box; 
}

/* タイトル */
h2.main-title { 
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; 
}

h2.section-title { 
    font-size: 18px; 
    font-weight: 600; 
    letter-spacing: 0.03em;
    margin: 30px 0 15px 0; 
    color: #2c5234; 
    display: flex;
    align-items: center;
    gap: 8px;
}

/* 検索エリア */
.search-form { 
    display: flex; 
    align-items: flex-end; 
    gap: 20px; 
    flex-wrap: wrap; 
    background-color: #ffffff; 
    border: 1px solid #edf0ee; 
    border-radius: 12px; 
    padding: 30px; 
    margin-bottom: 30px; 
    box-shadow: 0 4px 20px rgba(140, 160, 140, 0.06); 
}
.search-item { 
    display: flex; 
    flex-direction: column; 
    gap: 8px; 
}
.search-item label { 
    font-size: 11px; 
    color: #8a958f; 
    font-weight: 600; 
}

select, input[type="text"], input[type="number"] { 
    height: 40px; 
    padding: 0 12px; 
    border: 1px solid transparent; 
    border-radius: 8px; 
    font-size: 14px; 
    background-color: #f1f3f1; 
    color: #2b2d42;
    outline: none;
    box-sizing: border-box;
    transition: all 0.25s ease;
}
select:focus {
    background-color: #ffffff;
    border-color: #4a7c59;
    box-shadow: 0 0 0 3px rgba(74, 124, 89, 0.1);
}

button, input[type="submit"] { 
    height: 40px; 
    padding: 0 28px; 
    background-color: #4a7c59; 
    color: #ffffff; 
    border: none; 
    border-radius: 8px; 
    font-size: 14px; 
    font-weight: 500;
    cursor: pointer; 
    transition: all 0.2s ease;
}
button:hover, input[type="submit"]:hover { 
    background-color: #3b6347; 
}

.error-msg { 
    color: #2c5234; 
    font-size: 13px; 
    margin-bottom: 25px; 
    padding: 14px 20px;
    background-color: #edf2ee; 
    border-radius: 8px;
    border-left: 4px solid #e63946; 
}

/* ===================================================
   ★ 上部：全体座席ボード（横6列配置）
   =================================================== */

.seat-board-container {
    background-color: #009688; /* エメラルドグリーン */
    border-radius: 20px;
    padding: 40px 30px;
    margin-bottom: 40px;
    box-shadow: 0 8px 30px rgba(0, 150, 136, 0.2);
    display: flex;
    flex-direction: column;
    align-items: center;
}

.board-header {
    color: #ffffff;
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 30px;
    letter-spacing: 0.05em;
}

/* 班のブロックを横に並べるレイアウト */
.classroom-groups-flex {
    display: flex;
    flex-wrap: wrap;
    gap: 30px 24px; /* 上下30px、左右24pxの通路スペース */
    justify-content: center;
    max-width: 520px; /* 横3班（=6列）が綺麗に収まる幅に制限 */
}

/* 1班あたりの2×2デスクブロック */
.board-group-block {
    display: grid;
    grid-template-columns: repeat(2, 64px); /* 1班＝横2席 */
    gap: 8px; /* 班内の席同士のすき間 */
}

/* 席（水色の角丸ブロック） */
.seat-box {
    width: 64px;
    height: 64px;
    background-color: #cbe5ff; /* ライトブルー */
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    box-shadow: 0 3px 6px rgba(0,0,0,0.1);
    transition: transform 0.2s ease;
}

.seat-box:hover {
    transform: translateY(-2px);
}

.seat-box.empty {
    background-color: #ffffff;
    box-shadow: none;
}

.seat-student-name {
    font-weight: 700;
    font-size: 13px;
    color: #1a1a1a;
    text-align: center;
    line-height: 1.2;
    word-break: break-all;
    padding: 0 3px;
}

/* ===================================================
   ★ 下部：班ごとの詳細リスト
   =================================================== */

.groups-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
    margin-top: 15px;
}

.group-detail-card {
    background: #ffffff;
    border: 1px solid #edf0ee;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 4px 15px rgba(140, 160, 140, 0.06);
}

.group-detail-title {
    font-size: 16px;
    font-weight: 700;
    color: #2c5234;
    padding-bottom: 10px;
    margin-bottom: 12px;
    border-bottom: 2px solid #edf2ee;
}

.group-member-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.group-member-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 8px;
    border-bottom: 1px solid #f4f6f5;
    font-size: 14px;
}

.group-member-item:last-child {
    border-bottom: none;
}

.member-pos {
    font-size: 11px;
    background-color: #f1f3f1;
    color: #4a7c59;
    padding: 2px 8px;
    border-radius: 12px;
    font-weight: 600;
}

.member-name {
    font-weight: 600;
    color: #2b2d42;
}

.member-no {
    font-size: 12px;
    color: #8a958f;
}
</style>
</head>
<body>

<%@ include file="/header.jsp"%>

<div class="container">

    <%@ include file="/sidebar.jsp"%>

    <div class="main-content">

        <h2 class="main-title">席替え</h2>

        <!-- 条件選択 -->
        <form action="SeatShuffle.action" method="post" class="search-form">

            <div class="search-item">
                <label>入学年度</label>
                <select name="entYear">
                    <option value="">--------</option>
                    <c:forEach var="year" items="${entYearList}">
                        <option value="${year}">${year}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item">
                <label>クラス</label>
                <select name="classNum">
                    <option value="">--------</option>
                    <c:forEach var="classNum" items="${classList}">
                        <option value="${classNum}">${classNum}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item">
                <label>科目</label>
                <select name="subject">
                    <option value="">--------</option>
                    <c:forEach var="subject" items="${subjectList}">
                        <option value="${subject.cd}">${subject.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item">
                <label>回数</label>
                <select name="no">
                    <option value="">--------</option>
                    <c:forEach var="num" items="${noList}">
                        <option value="${num}">${num}</option>
                    </c:forEach>
                </select>
            </div>

            <input type="submit" value="席替え">

        </form>

        <!-- エラーメッセージ -->
        <c:if test="${not empty message}">
            <div class="error-msg">
                ${message}
            </div>
        </c:if>

        <!-- 席表表示エリア -->
        <c:if test="${not empty seatList}">

            <!-- ① 上部：全体座席ボード（6班単位で綺麗に並べる配置） -->
<div class="seat-board-container">
    <div class="board-header">今の座席</div>
    
    <div class="classroom-groups-flex">
        <%-- 
            全体の見た目を揃えるため、実際の班数(groupCount)が6に満たない、
            または端数が出た場合でも、6の倍数(6, 12等)まで空の班枠を出力する計算
        --%>
        <%-- 6以下の場合は6、それ以上は6の倍数になるように繰り上げ計算 --%>
<c:set var="remainder" value="${groupCount % 6}" />
<c:set var="displayMaxGroup" value="${groupCount <= 6 ? 6 : (remainder == 0 ? groupCount : groupCount + (6 - remainder))}" />

        <c:forEach var="g" begin="1" end="${displayMaxGroup}">
            <div class="board-group-block">
                <%-- 班内の2×2配置 (1:左上, 3:右上, 2:左下, 4:右下) --%>
                <c:forEach var="pos" items="${[1, 3, 2, 4]}">
                    
                    <c:set var="matchedSeat" value="${null}" />
                    
                    <%-- 実際の班数が足りている場合のみ生徒データを検索 --%>
                    <c:if test="${g <= groupCount}">
                        <c:forEach var="seat" items="${seatList}">
                            <c:if test="${seat.groupNo == g && seat.position == pos}">
                                <c:set var="matchedSeat" value="${seat}" />
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty matchedSeat}">
                            <div class="seat-box">
                                <span class="seat-student-name">${matchedSeat.studentName}</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <%-- 生徒がいない、または班自体が存在しない空白枠 --%>
                            <div class="seat-box empty"></div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
</div>
            <!-- ② 下部：班ごとの詳細リスト -->
            <h2 class="section-title">班別メンバー詳細</h2>

            <div class="groups-container">
                <c:forEach var="g" begin="1" end="${groupCount}">
                    <div class="group-detail-card">
                        <div class="group-detail-title">
                            第 ${g} 班
                        </div>
                        
                        <ul class="group-member-list">
                            <c:forEach var="pos" begin="1" end="4">
                                <c:set var="matchedSeat" value="${null}" />
                                <c:forEach var="seat" items="${seatList}">
                                    <c:if test="${seat.groupNo == g && seat.position == pos}">
                                        <c:set var="matchedSeat" value="${seat}" />
                                    </c:if>
                                </c:forEach>

                                <c:if test="${not empty matchedSeat}">
                                    <li class="group-member-item">
                                        <div>
                                            <span class="member-pos">席 ${pos}</span>
                                            <span class="member-name" style="margin-left: 8px;">${matchedSeat.studentName}</span>
                                        </div>
                                        <span class="member-no">${matchedSeat.studentNo}</span>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </div>

        </c:if>

    </div>

</div>

<%@ include file="/footer.jsp"%>

</body>
</html>