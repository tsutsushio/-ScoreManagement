<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績検索</title>
    <style>
        /* 1. 全体のレイアウト：サイドバーとメインを横に並べる */
        .main-layout {
            display: flex;
            min-height: 80vh; /* 画面の高さに合わせる */
        }

        /* 2. サイドバーが入るエリアの調整 */
        .sidebar-area {
            width: 220px;       /* サイドバーの幅 */
            border-right: 1px solid #eee; /* 境界線（お好みで） */
            padding-top: 20px;
        }

        /* 3. メインコンテンツが入るエリアの調整 */
        .main-content {
            flex: 1;            /* 残りの幅をすべて使う */
            padding: 20px 40px;
        }

        /* 既存の検索フォーム用スタイル */
        .search-container {
            display: flex;
            align-items: flex-end;
            gap: 15px;
            margin: 20px 0;
        }
        .search-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .search-item label {
            font-weight: bold;
            font-size: 0.9em;
        }
        select {
            padding: 4px;
            min-width: 100px;
        }
        .search-btn {
            padding: 5px 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="main-layout">
    <div class="sidebar-area">
        <%@ include file="/sidebar.jsp" %>
    </div>

    <div class="main-content">
        <h2>成績管理</h2>

        <form action="SearchServlet" method="get">
            <div class="search-container">
                <div class="search-item">
                    <label>入学年度</label>
                    <select name="userList">
    <c:forEach var="user" items="${userList}">
        <%-- userオブジェクトのidを値に、nameを表示名にする --%>
        <option value="${year}">${year}</option>
    </c:forEach>
</select>
                </div>

                <div class="search-item">
                    <label>クラス</label>
                    <select name="userList">
    <c:forEach var="user" items="${userList}">
        <%-- userオブジェクトのidを値に、nameを表示名にする --%>
        <option value="${num}">${num}</option>
    </c:forEach>
</select>
                </div>

                <div class="search-item">
                    <label>科目</label>
                    <select name="userList">
    <c:forEach var="user" items="${userList}">
        <%-- userオブジェクトのidを値に、nameを表示名にする --%>
        <option value="${subject_cd}">${subject_cd}</option>
    </c:forEach>
</select>
                </div>

                <div class="search-item">
                    <label>回数</label>
                    <select name="userList">
    <c:forEach var="user" items="${userList}">
        <%-- userオブジェクトのidを値に、nameを表示名にする --%>
        <option value="${num}">${num}</option>
    </c:forEach>
</select>
                </div>

                <button class="search-btn" type="submit">検索</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/footer.html" />

</body>
</html>