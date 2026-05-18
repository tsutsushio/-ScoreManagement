<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報変更</title>
<style>
    /* 画面設計書に合わせたシンプルなデザイン */
    body { 
        font-family: sans-serif; 
        margin: 20px; 
        background-color: #f9f9f9; 
    }
    
    .form-container {
        background-color: white;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 8px;
        max-width: 500px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    
    /* ヘッダー風のタイトルバー */
    h2 { 
        background-color: #f0f0f0;
        padding: 10px 15px;
        margin-top: 0;
        margin-bottom: 25px;
        border-radius: 4px;
        font-size: 18px;
        color: #333;
    }
    
    .form-group { 
        margin-bottom: 20px; 
    }
    
    .form-group label { 
        display: block; 
        font-size: 14px;
        color: #555;
        margin-bottom: 5px; 
    }
    
    /* 変更不可の項目（入学年度・学生番号）のテキストスタイル */
    .readonly-text {
        font-size: 16px;
        color: #333;
        margin: 0 0 10px 10px;
    }
    
    .form-group input[type="text"], 
    .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    
    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 5px;
        margin-bottom: 25px;
    }
    
    .checkbox-group label {
        margin-bottom: 0;
        font-size: 14px;
        color: #333;
    }
    
    /* エラーメッセージ（サーバー側バリデーション用） */
    .error-msg {
        color: #dc3545;
        font-size: 12px;
        margin-top: 5px;
        display: block;
    }
    
    .btn-submit {
        background-color: #0d6efd; /* 設計書通りの鮮やかな青 */
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
    }
    
    .btn-submit:hover { 
        background-color: #0b5ed7; 
    }
    
    .back-link { 
        display: block; 
        margin-top: 15px; 
        text-decoration: none; 
        color: #0d6efd; 
        font-size: 14px;
    }
</style>
</head>
<body>

    <div class="form-container">
        <h2>学生情報変更</h2>

        <!-- 更新処理を行う StudentUpdateExecuteAction へPOST送信 -->
        <form action="${pageContext.request.contextPath}/action/StudentUpdateExecute.action" method="post">
            
            <!-- 1. 入学年度 (変更不可・表示のみ) -->
            <div class="form-group">
                <label>入学年度</label>
                <p class="readonly-text">${student.entYear}</p>
                <!-- ※画面には表示しないが、更新処理に必要なので裏側で送信する -->
                <input type="hidden" name="entYear" value="${student.entYear}">
            </div>

            <!-- 2. 学生番号 (変更不可・表示のみ) -->
            <div class="form-group">
                <label>学生番号</label>
                <p class="readonly-text">${student.no}</p>
                <!-- ※キーとなる学生番号も裏側で送信する -->
                <input type="hidden" name="no" value="${student.no}">
            </div>

            <!-- 3. 氏名 (変更可能) -->
            <div class="form-group">
                <label>氏名</label>
                <!-- required属性をつけることで、画像2枚目の未入力エラー（ポップアップ）を再現 -->
                <input type="text" name="name" value="${student.name}" required>
                <!-- サーバー側で弾かれた場合のエラー表示領域 -->
                <c:if test="${not empty errors.name}">
                    <span class="error-msg">${errors.name}</span>
                </c:if>
            </div>

            <!-- 4. クラス (変更可能) -->
            <div class="form-group">
                <label>クラス</label>
                <select name="classNum">
                    <c:forEach var="c" items="${classList}">
                        <!-- 現在のクラスと一致するoptionにselectedをつける -->
                        <option value="${c}" ${student.classNum == c ? 'selected' : ''}>${c}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 5. 在学中フラグ (変更可能) -->
            <div class="checkbox-group">
                <label>在学中</label>
                <!-- isAttendがtrueの場合、最初からチェックを入れておく -->
                <input type="checkbox" name="isAttend" value="true" ${student.isAttend ? 'checked' : ''}>
            </div>

            <!-- ボタンエリア -->
            <button type="submit" class="btn-submit">変更</button>
            <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">戻る</a>
            
        </form>
        
                <!--削除ボタン用のフォーム -->
        <form action="${pageContext.request.contextPath}/action/StudentDelete.action" method="post" onsubmit="return confirm('本当にこの学生データを削除してよろしいですか？\n※この操作は取り消せません。');" style="text-align: right; margin-top: 20px;">
            <input type="hidden" name="no" value="${student.no}">
            <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: bold;">削除する</button>
        </form>
    </div>

</body>
</html>