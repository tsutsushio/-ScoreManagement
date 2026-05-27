<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生情報変更</title>
<style>
body {
    font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
    background-color: #f4f7f9;
    color: #333;
    margin: 0;
    padding: 40px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* フォーム全体を包むカード */
.form-container {
    background: #ffffff;
    padding: 35px 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    width: 100%;
    max-width: 450px; /* 少しゆったりめの幅に変更 */
    box-sizing: border-box;
}

/* タイトルヘッダー */
h2 { 
    font-size: 22px;
    color: #2c3e50;
    margin-top: 0;
    margin-bottom: 25px;
    text-align: center;
    padding-bottom: 12px;
    border-bottom: 2px solid #f4f7f9; /* 野暮ったい背景を消し、下線でスマートに */
}

.form-group { 
    margin-bottom: 20px; 
}

label { 
    font-size: 14px;
    font-weight: bold;
    color: #34495e;
    display: inline-block;
    margin-bottom: 8px; 
}

/* 変更不可の項目（入学年度・学生番号） */
.readonly-text {
    font-size: 16px;
    color: #7f8c8d;
    margin: 0;
    padding: 8px 12px;
    background-color: #f8f9fa; /* 入力できないことが直感でわかる背景色 */
    border-radius: 6px;
    border: 1px dashed #cfd8dc;
}

/* 入力フォーム・セレクトボックス */
.form-group input[type="text"], 
.form-group select {
    width: 100%;
    height: 42px;
    padding: 0 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fff;
    box-sizing: border-box;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.form-group input[type="text"]:focus,
.form-group select:focus {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    outline: none;
}

/* 在学中チェックボックス */
.checkbox-group {
    display: flex;
    flex-direction: row-reverse; /* ラベルの右側にチェックボックスを配置 */
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    margin-bottom: 25px;
    padding: 5px 0;
}

.checkbox-group label {
    margin-bottom: 0;
    cursor: pointer;
}

.checkbox-group input[type="checkbox"] {
    width: 18px;
    height: 18px;
    cursor: pointer;
    accent-color: #3498db; /* チェック時の色をテーマカラーに統一 */
}

/* エラーメッセージ */
.error-msg {
    color: #e74c3c;
    font-size: 13px;
    display: block;
    margin-top: 6px;
    font-weight: 500;
}

/* 変更ボタン */
.btn-submit {
    width: 100%;
    height: 45px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.2s;
}

.btn-submit:hover { 
    background-color: #2980b9; 
}

/* 削除ボタン用フォームの調整 */
form[action*="StudentDelete.action"] {
    border-top: 1px dashed #e2e8f0;
    margin-top: 25px !important;
    padding-top: 20px;
}

/* 削除ボタン本体 */
form[action*="StudentDelete.action"] button {
    width: 100%; /* 横いっぱいに広げて押しやすく */
    height: 40px;
    background-color: #fff !important; /* 初期状態は白背景で主張を抑える */
    color: #e74c3c !important;
    border: 1px solid #e74c3c !important;
    border-radius: 6px !important;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: all 0.2s;
}

form[action*="StudentDelete.action"] button:hover {
    background-color: #e74c3c !important; /* ホバー時だけ警告の赤色に */
    color: #fff !important;
}

/* 戻るリンク */
.back-link { 
    display: inline-block;
    margin-bottom: 15px; 
    text-decoration: none; 
    color: #3498db; 
    font-size: 14px;
    font-weight: bold;
    transition: color 0.2s;
    align-self: flex-start; /* カードの左端のラインに揃えます */
    max-width: 450px;
    width: 100%;
}

.back-link:hover { 
    color: #2980b9;
    text-decoration: underline;
}

</style>
</head>
<body>
            <a href="${pageContext.request.contextPath}/action/StudentList.action" class="back-link">←ホームに戻る</a>

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

            
        </form>
        
                <!--削除ボタン用のフォーム -->
        <form action="${pageContext.request.contextPath}/action/StudentDelete.action" method="post" onsubmit="return confirm('本当にこの学生データを削除してよろしいですか？\n※この操作は取り消せません。');" style="text-align: right; margin-top: 20px;">
            <input type="hidden" name="no" value="${student.no}">
            <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: bold;">削除する</button>
        </form>
    </div>

</body>
</html>