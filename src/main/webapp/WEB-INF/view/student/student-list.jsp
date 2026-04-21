<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生一覧</title>
<style>
    /* 画面設計書に近いシンプルなデザインをあてるCSS */
    body { font-family: sans-serif; margin: 20px; }
    h2 { border-bottom: 2px solid #ccc; padding-bottom: 5px; }
    
    /* 検索フォームのレイアウト */
    .search-box {
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 5px;
    }
    .search-row { margin-bottom: 10px; display: flex; align-items: center; gap: 15px;}
    .search-row label { font-weight: bold; }
    
    /* テーブルのデザイン */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    th { background-color: #f0f0f0; }
    
    /* エラーメッセージ（赤文字） */
    .error-message { color: red; font-weight: bold; margin-bottom: 15px;}
</style>
</head>
<body>

    <a href="<%= request.getContextPath() %>/action/Menu.action">メニューへ戻る</a>
    
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
                
                <label>
                    <input type="checkbox" name="isAttend" value="true"> 在学中
                </label>
                
                <button type="submit">絞り込む</button>
            </div>
        </form>
    </div>

    <c:if test="${empty studentList}">
        <p class="error-message">学生情報が存在しませんでした</p>
    </c:if>

    <c:if test="${not empty studentList}">
        <p>検索結果：${studentList.size()} 件</p>
        
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
                            <a href="<%= request.getContextPath() %>/action/StudentUpdate.action?no=${student.no}">変更</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

</body>
</html>