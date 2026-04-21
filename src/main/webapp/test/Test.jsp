<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績検索</title>
    <style>
        /* 横に並べるための設定 */
        .search-container {
            display: flex;
            align-items: flex-end; /* 下のラインを揃える */
            gap: 15px;            /* 項目間の隙間 */
            margin: 20px 0;
        }
        /* 項目を縦（文字が上、ボックスが下）に並べる */
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

<h2>成績検索画面</h2>

<form action="SearchServlet" method="get">
    <div class="search-container">
        
        <div class="search-item">
            <label>入学年度</label>
            <select name="f1">
                <option value="">-------</option>
                <option value="${year}">${year}</option>
            </select>
        </div>

        <div class="search-item">
            <label>クラス</label>
            <select name="f2">
                <option value="">-------</option>
                <option value="${num}">${num}</option>
            </select>
        </div>

        <div class="search-item">
            <label>科目</label>
            <select name="f3">
                <option value="">-------</option>
                <option value="${subject_cd}">${subject_cd}</option>
            </select>
        </div>

        <div class="search-item">
            <label>回数</label>
            <select name="f4">
                <option value="">-------</option>
                <option value="${num}">${num}</option>
            </select>
        </div>

        <button class="search-btn" type="submit">検索</button>
        
    </div>
</form>

<jsp:include page="/footer.html" />

</body>
</html>