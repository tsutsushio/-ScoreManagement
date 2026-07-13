<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム - 学生用メニュー</title>
<style>
    /* 全体レイアウト：教員側と共通の縦幅いっぱいベース */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: "Yu Gothic", sans-serif;
        background-color: #ffffff;
    }

    body {
        display: flex;
        flex-direction: column; /* 上からヘッダー、コンテンツの順 */
    }

    /* メインコンテナ（サイドバーとコンテンツの並び） */
    .container {
        display: flex;
        flex: 1;
        width: 100%;
        align-items: stretch;
    }

    /* 右側メインエリア */
    .main-content {
        flex: 1;
        padding: 20px 40px;
        background-color: #ffffff;
        box-sizing: border-box;
        overflow-y: auto;
    }

    /* 見出し（教員側と同じグレーの帯） */
    .main-content h2 {
        margin-top: 0;
        margin-bottom: 25px;
        padding: 10px 15px;
        background-color: #f2f2f2;
        color: #333;
        font-size: 18px;
        font-weight: bold;
    }

    /* 中見出し（シンプルな左線デザイン） */
    .main-content h3 {
        font-size: 16px;
        font-weight: bold;
        color: #333;
        border-left: 4px solid #666;
        padding-left: 10px;
        margin: 35px 0 15px 0;
    }

    /* アクションボタン群 */
    .action-links {
        margin-bottom: 20px;
        display: flex;
        gap: 10px;
    }
    .btn {
        background-color: #666;
        color: #fff;
        border: none;
        border-radius: 4px;
        padding: 6px 16px;
        font-size: 13px;
        cursor: pointer;
        text-decoration: none;
    }
    .btn:hover { background-color: #333; }
    .btn-outline {
        background-color: #fff;
        color: #333;
        border: 1px solid #ccc;
    }
    .btn-outline:hover { background-color: #f2f2f2; }

    /* 学生基本情報テーブル（スッキリとした枠線） */
    .profile-table {
        border-collapse: collapse;
        margin-bottom: 20px;
        font-size: 14px;
    }
    .profile-table th {
        background-color: #f9f9f9;
        border: 1px solid #ccc;
        padding: 8px 15px;
        text-align: left;
        font-weight: normal;
        color: #555;
        width: 100px;
    }
    .profile-table td {
        border: 1px solid #ccc;
        padding: 8px 15px;
        color: #333;
        width: 200px;
    }

    /* 成績一覧テーブル（教員側と共通） */
    table.list-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        margin-bottom: 20px;
    }
    table.list-table th {
        border-bottom: 2px solid #333;
        padding: 10px;
        text-align: left;
        color: #333;
    }
    table.list-table td {
        border-bottom: 1px solid #eee;
        padding: 10px;
        color: #555;
    }
    
    .my-point {
        font-weight: bold;
        font-size: 16px;
        color: #333;
    }

    /* 詳細コンテナ */
    .detail-container {
        display: none;
        background-color: #fafafa;
    }
    .detail-inner {
        padding: 15px 20px;
        border: 1px solid #eee;
        margin: 10px 0;
    }
    .summary-box {
        display: flex;
        gap: 40px;
        margin-bottom: 15px;
        font-size: 14px;
    }

    /* ヒストグラム（落ち着いた青グレーとオレンジの配色に統一） */
    .histogram-title {
        font-size: 13px;
        font-weight: bold;
        color: #666;
        margin-bottom: 10px;
    }
    .histogram {
        display: flex;
        align-items: flex-end;
        gap: 4px;
        height: 120px;
        border-bottom: 1px solid #ccc;
        padding-bottom: 5px;
        margin-bottom: 25px;
    }
    .bar {
        background-color: #b0c4de;
        flex: 1;
        position: relative;
        min-height: 2px;
    }
    .bar.highlight {
        background-color: #f0ad4e; /* 教員側のエラー表示等で使われているオレンジに合わせる */
    }
    .bar::after {
        content: attr(data-range);
        position: absolute;
        bottom: -20px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        color: #666;
        white-space: nowrap;
    }
</style>
</head>
<body>

<%@ include file="/header.jsp" %>

<div class="container">
    <%@ include file="/sidebar.jsp" %>

    <div class="main-content">
        
        <h2>学生用メニュー</h2>
        
        <div class="action-links">
            <a href="../action/StudentPasswordEdit.action" class="btn btn-outline">パスワード変更</a>
            <a href="../login/login.jsp" class="btn btn-outline">ログアウト</a>
        </div>

        <p style="font-size: 15px; margin-bottom: 10px;">ようこそ、<strong>${loginStudent.name}</strong> さん</p>
        
        <table class="profile-table">
            <tr>
                <th>学籍番号</th>
                <td>${loginStudent.no}</td>
                <th>クラス</th>
                <td>${loginStudent.classNum}</td>
            </tr>
            <tr>
                <th>氏名</th>
                <td>${loginStudent.name}</td>
                <th>入学年度</th>
                <td>${loginStudent.entYear} 年度</td>
            </tr>
        </table>

        <h3>最新のテスト成績</h3>
        <table class="list-table">
            <thead>
                <tr>
                    <th>科目コード</th>
                    <th>科目名</th>
                    <th>あなたの得点</th>
                    <th style="text-align: center;">詳細情報</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="test" items="${latestScores}" varStatus="status">
                    <tr>
                        <td>${test.subject.cd}</td>
                        <td>${test.subject.name}</td>
                        <td class="my-point">${test.point} 点</td>
                        <td style="text-align: center;">
                            <button type="button" class="btn" onclick="toggleDetail('detail-${status.index}')">詳細を見る</button>
                        </td>
                    </tr>
                    
                    <tr id="detail-${status.index}" class="detail-container">
                        <td colspan="4">
                            <div class="detail-inner">
                                <div class="summary-box">
                                    <div>学内順位: <strong>${test.rank} 位</strong></div>
                                    <div>科目平均点: <strong>${test.averagePoint} 点</strong></div>
                                    <div>最高点: <strong>${test.maxPoint} 点</strong></div>
                                </div>
                                
                                <div class="histogram-title">得点分布（ヒストグラム）</div>
                                <div class="histogram">
                                    <div class="bar ${test.point >= 0 && test.point <= 10 ? 'highlight' : ''}" style="height: 10%;" data-range="0-"></div>
                                    <div class="bar ${test.point > 10 && test.point <= 20 ? 'highlight' : ''}" style="height: 25%;" data-range="10-"></div>
                                    <div class="bar ${test.point > 20 && test.point <= 30 ? 'highlight' : ''}" style="height: 40%;" data-range="20-"></div>
                                    <div class="bar ${test.point > 30 && test.point <= 40 ? 'highlight' : ''}" style="height: 55%;" data-range="30-"></div>
                                    <div class="bar ${test.point > 40 && test.point <= 50 ? 'highlight' : ''}" style="height: 75%;" data-range="40-"></div>
                                    <div class="bar ${test.point > 50 && test.point <= 60 ? 'highlight' : ''}" style="height: 90%;" data-range="50-"></div>
                                    <div class="bar ${test.point > 60 && test.point <= 70 ? 'highlight' : ''}" style="height: 65%;" data-range="60-"></div>
                                    <div class="bar ${test.point > 70 && test.point <= 80 ? 'highlight' : ''}" style="height: 80%;" data-range="70-"></div>
                                    <div class="bar ${test.point > 80 && test.point <= 90 ? 'highlight' : ''}" style="height: 45%;" data-range="80-"></div>
                                    <div class="bar ${test.point > 90 && test.point <= 100 ? 'highlight' : ''}" style="height: 20%;" data-range="90-"></div>
                                </div>
                                <div style="font-size: 11px; color: #666; text-align: center;">
                                    ※オレンジ色のバーがあなたの得点圏内です。
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h3>過去の成績履歴</h3>
        <table class="list-table">
            <thead>
                <tr>
                    <th>回数</th>
                    <th>科目名</th>
                    <th>あなたの得点</th>
                    <th style="text-align: center;">詳細情報</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="history" items="${allScores}" varStatus="status">
                    <tr>
                        <td>第 ${history.no} 回</td>
                        <td>${history.subject.name}</td>
                        <td class="my-point">${history.point} 点</td>
                        <td style="text-align: center;">
                            <button type="button" class="btn" onclick="toggleDetail('history-detail-${status.index}')">詳細を見る</button>
                        </td>
                    </tr>
                    
                    <tr id="history-detail-${status.index}" class="detail-container">
                        <td colspan="4">
                            <div class="detail-inner">
                                <div class="summary-box">
                                    <div>学内順位: <strong>${history.rank} 位</strong></div>
                                    <div>科目平均点: <strong>${history.averagePoint} 点</strong></div>
                                    <div>最高点: <strong>${history.maxPoint} 点</strong></div>
                                </div>
                                
                                <div class="histogram-title">得点分布（ヒストグラム）</div>
                                <div class="histogram">
                                    <div class="bar ${history.point >= 0 && history.point <= 10 ? 'highlight' : ''}" style="height: 10%;" data-range="0-"></div>
                                    <div class="bar ${history.point > 10 && history.point <= 20 ? 'highlight' : ''}" style="height: 25%;" data-range="10-"></div>
                                    <div class="bar ${history.point > 20 && history.point <= 30 ? 'highlight' : ''}" style="height: 40%;" data-range="20-"></div>
                                    <div class="bar ${history.point > 30 && history.point <= 40 ? 'highlight' : ''}" style="height: 55%;" data-range="30-"></div>
                                    <div class="bar ${history.point > 40 && history.point <= 50 ? 'highlight' : ''}" style="height: 75%;" data-range="40-"></div>
                                    <div class="bar ${history.point > 50 && history.point <= 60 ? 'highlight' : ''}" style="height: 90%;" data-range="50-"></div>
                                    <div class="bar ${history.point > 60 && history.point <= 70 ? 'highlight' : ''}" style="height: 65%;" data-range="60-"></div>
                                    <div class="bar ${history.point > 70 && history.point <= 80 ? 'highlight' : ''}" style="height: 80%;" data-range="70-"></div>
                                    <div class="bar ${history.point > 80 && history.point <= 90 ? 'highlight' : ''}" style="height: 45%;" data-range="80-"></div>
                                    <div class="bar ${history.point > 90 && history.point <= 100 ? 'highlight' : ''}" style="height: 20%;" data-range="90-"></div>
                                </div>
                                <div style="font-size: 11px; color: #666; text-align: center;">
                                    ※オレンジ色のバーがあなたの得点圏内です。
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </div>
</div>

<%@ include file="/footer.jsp" %>

<script>
function toggleDetail(id) {
    const detailRow = document.getElementById(id);
    if (detailRow.style.display === 'table-row') {
        detailRow.style.display = 'none';
    } else {
        detailRow.style.display = 'table-row';
    }
}
</script>

</body>
</html>