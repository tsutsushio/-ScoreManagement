<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報登録</title>
<style>
    /* 画面設計書に近いシンプルなレイアウト */
    body { font-family: sans-serif; margin: 20px; background-color: #f9f9f9; }
    h2 { border-bottom: 2px solid #ccc; padding-bottom: 5px; }
    
    .form-container {
        background-color: white;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 8px;
        max-width: 450px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; color: #333; }
    
    .form-group input[type="text"], 
    .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box; /* 枠線を幅に含める */
        font-size: 14px;
    }
    
    /* エラーメッセージ（赤文字） */
    .error-msg {
        color: #dc3545;
        font-size: 12px;
        margin-top: 5px;
        display: block;
    }
    
    .btn-submit {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        width: 100%;
        font-weight: bold;
    }
    .btn-submit:hover { background-color: #0056b3; }
    
    .back-link { 
        display: inline-block; 
        margin-bottom: 20px; 
        text-decoration: none; 
        color: #0066cc; 
    }
</style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">戻る</a>

    <h2>学生情報登録</h2>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/action/StudentCreateExecute.action" method="post">
            
            <div class="form-group">
                <label>入学年度</label>
                <select name="entYear">
                    <option value="0">--------</option>
                    <c:forEach var="year" items="${entYearList}">
                        <option value="${year}" ${entYear == year ? 'selected' : ''}>${year}</option>
                    </c:forEach>
                </select>
                <c:if test="${not empty errors.entYear}">
                    <span class="error-msg">${errors.entYear}</span>
                </c:if>
            </div>

            <div class="form-group">
                <label>学生番号</label>
                <input type="text" name="no" value="${no}" placeholder="学生番号を入力してください">
                <c:if test="${not empty errors.no}">
                    <span class="error-msg">${errors.no}</span>
                </c:if>
            </div>

            <div class="form-group">
                <label>氏名</label>
                <input type="text" name="name" value="${name}" placeholder="氏名を入力してください">
                <c:if test="${not empty errors.name}">
                    <span class="error-msg">${errors.name}</span>
                </c:if>
            </div>

            <div class="form-group">
                <label>クラス</label>
                <select name="classNum">
                    <c:forEach var="c" items="${classList}">
                        <option value="${c}" ${classNum == c ? 'selected' : ''}>${c}</option>
                    </c:forEach>
                </select>
            </div>

            <button type="submit" class="btn-submit">登録</button>
        </form>
    </div>

</body>
</html>