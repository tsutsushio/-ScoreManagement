<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生一覧</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #f4f7fb;
        color: #333;
    }

    .container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 0 20px;
    }

    .back-link {
        display: inline-block;
        margin-bottom: 20px;
        color: #4a7bd8;
        text-decoration: none;
        font-weight: bold;
        transition: 0.2s;
    }

    .back-link:hover {
        color: #2f5fb8;
        text-decoration: underline;
    }

    h2 {
        margin: 0 0 25px;
        padding: 14px 20px;
        background: #fff;
        border-left: 6px solid #6ea8ff;
        border-radius: 10px;
        font-size: 28px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .search-box {
        background: #fff;
        padding: 24px;
        border-radius: 14px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        margin-bottom: 30px;
    }

    .search-row {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 18px;
    }

    .search-row label {
        font-weight: bold;
        color: #444;
        font-size: 14px;
    }

    .search-row select {
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background-color: #fff;
        font-size: 14px;
        min-width: 130px;
        transition: 0.2s;
    }

    .search-row select:focus {
        outline: none;
        border-color: #6ea8ff;
        box-shadow: 0 0 0 3px rgba(110,168,255,0.2);
    }

    .checkbox-label {
        display: flex;
        align-items: center;
        gap: 6px;
        font-weight: normal;
    }

    .checkbox-label input {
        transform: scale(1.1);
    }

    .search-row button {
        padding: 11px 22px;
        border: none;
        border-radius: 8px;
        background: linear-gradient(135deg, #6ea8ff, #4a7bd8);
        color: #fff;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.2s;
    }

    .search-row button:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 10px rgba(74,123,216,0.35);
    }

    .error-message {
        background: #ffe5e5;
        color: #d33;
        border-left: 5px solid #ff6b6b;
        padding: 14px 18px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-weight: bold;
    }

    .result-count {
        margin-bottom: 14px;
        font-weight: bold;
        color: #555;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    thead {
        background: linear-gradient(135deg, #6ea8ff, #4a7bd8);
        color: #fff;
    }

    th {
        padding: 14px 10px;
        font-size: 14px;
        font-weight: bold;
    }

    td {
        padding: 14px 10px;
        border-bottom: 1px solid #eee;
        text-align: center;
        font-size: 14px;
    }

    tbody tr:nth-child(even) {
        background-color: #f8fbff;
    }

    tbody tr:hover {
        background-color: #eef5ff;
    }

    .edit-link {
        display: inline-block;
        padding: 6px 14px;
        background-color: #f0f6ff;
        border: 1px solid #6ea8ff;
        border-radius: 6px;
        color: #4a7bd8;
        text-decoration: none;
        font-weight: bold;
        transition: 0.2s;
    }

    .edit-link:hover {
        background-color: #6ea8ff;
        color: #fff;
    }

    @media screen and (max-width: 768px) {
        .search-row {
            flex-direction: column;
            align-items: stretch;
        }

        .search-row select,
        .search-row button {
            width: 100%;
        }

        table {
            display: block;
            overflow-x: auto;
            white-space: nowrap;
        }
    }
</style>
</head>
<body>

<div class="container">

    <a class="back-link" href="<%= request.getContextPath() %>/action/Menu.action">
        ← メニューへ戻る
    </a>

    <h2>学生管理</h2>

    <div class="search-box">
        <form action="<%= request.getContextPath() %>/action/StudentList.action" method="post">
            <div class="search-row">

                <label>入学年度</label>
                <select name="entYear">
                    <option value="0">--------</option>
                    <option value="2014">2014</option>
                    <option value="2015">2015</option>
                    <option value="2016">2016</option>
                    <option value="2017">2017</option>
                    <option value="2018">2018</option>
                    <option value="2019">2019</option>
                    <option value="2020">2020</option>
                    <option value="2021">2021</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                    <option value="2024">2024</option>
                </select>

                <label>クラス</label>
                <select name="classNum">
                    <option value="--------">--------</option>
                    <option value="101">101</option>
                    <option value="102">102</option>
                    <option value="201">201</option>
                    <option value="202">202</option>
                </select>

                <label class="checkbox-label">
                    <input type="checkbox" name="isAttend" value="true">
                    在学中
                </label>

                <button type="submit">絞り込む</button>
            </div>
        </form>
    </div>

    <c:if test="${empty studentList}">
        <p class="error-message">学生情報が存在しませんでした</p>
    </c:if>

    <c:if test="${not empty studentList}">
        <p class="result-count">検索結果：${studentList.size()} 件</p>

        <table>
            <thead>
                <tr>
                    <th>入学年度</th>
                    <th>学生番号</th>
                    <th>氏名</th>
                    <th>クラス</th>
                    <th>在学中</th>
                    <th>学生情報変更</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${studentList}">
                    <tr>
                        <td>${student.entYear}</td>
                        <td>${student.no}</td>
                        <td>${student.name}</td>
                        <td>${student.classNum}</td>
                        <td>
                            <c:choose>
                                <c:when test="${student.isAttend}">〇</c:when>
                                <c:otherwise>×</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="edit-link"
                               href="<%= request.getContextPath() %>/action/StudentUpdate.action?no=${student.no}">
                                変更
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

</div>

</body>
</html>
```
