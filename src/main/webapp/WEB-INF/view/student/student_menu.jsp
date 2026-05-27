<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生ポータルサイト - メニュー</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /* 全体の基本設定 */
        body {
            font-family: 'Noto Sans JP', Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 30px;
            color: #334155;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        /* 🌟 ヘッダー部分（Flexboxで左右に振り分け） */
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .header-title {
            font-size: 28px;
            color: #1e293b;
            border-left: 6px solid #4f46e5;
            padding-left: 15px;
            margin: 0; /* Flex配置のためデフォルトマージンをリセット */
        }
        .header-actions {
            display: flex;
            gap: 15px;
        }
        .header-actions a {
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            padding: 10px 16px;
            border-radius: 4px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .btn-password {
            color: #4f46e5;
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
        .btn-password:hover {
            background-color: #f8fafc;
            border-color: #cbd5e1;
        }
        .btn-logout {
            color: #64748b;
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
        .btn-logout:hover {
            background-color: #fff1f2;
            color: #e11d48;
            border-color: #fecdd3;
        }

        h2 {
            font-size: 20px;
            color: #1e293b;
            margin-top: 40px;
            margin-bottom: 15px;
        }

        /* 貼り付けた感じ（Pasted Card）のデザイン */
        .pasted-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            padding: 25px;
            margin-bottom: 25px;
            position: relative;
        }
        .pasted-card::before {
            content: '';
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 90px;
            height: 25px;
            background: rgba(241, 245, 249, 0.6);
            backdrop-filter: blur(2px);
            border: 1px solid rgba(0, 0, 0, 0.03);
            border-radius: 2px;
        }

        /* 基本情報エリアのスタイル */
        .profile-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-top: 15px;
        }
        .profile-item {
            background: #f8fafc;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #f1f5f9;
        }
        .profile-label {
            font-size: 13px;
            color: #64748b;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .profile-value {
            font-size: 18px;
            color: #1e293b;
            font-weight: bold;
        }

        /* テーブル共通スタイル */
        .score-table {
            width: 100%;
            border-collapse: collapse;
        }
        .score-table th {
            background-color: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
            color: #64748b;
            padding: 14px;
            text-align: left;
            font-size: 14px;
        }
        .score-table td {
            border-bottom: 1px solid #f1f5f9;
            padding: 14px;
            font-size: 15px;
        }
        .my-point {
            font-weight: bold;
            color: #4f46e5;
            font-size: 18px;
        }

        /* 詳細ボタン */
        .detail-btn {
            background-color: #f1f5f9;
            color: #4f46e5;
            border: 1px solid #e2e8f0;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            font-size: 13px;
            transition: all 0.2s;
        }
        .detail-btn:hover {
            background-color: #4f46e5;
            color: #ffffff;
            border-color: #4f46e5;
        }

        /* トグルで開閉する詳細コンテナ */
        .detail-container {
            display: none;
            background-color: #f8fafc;
            padding: 20px;
            border-bottom: 1px solid #e2e8f0;
        }
        .detail-summary-box {
            display: flex;
            gap: 40px;
            margin-bottom: 20px;
            background: #ffffff;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #e2e8f0;
        }
        .summary-item strong {
            color: #1e293b;
            font-size: 18px;
        }

        /* ヒストグラム */
        .histogram-title {
            font-size: 14px;
            font-weight: bold;
            color: #64748b;
            margin-bottom: 10px;
        }
        .histogram {
            display: flex;
            align-items: flex-end;
            gap: 6px;
            height: 140px;
            border-bottom: 2px solid #cbd5e1;
            padding-bottom: 5px;
            background: #ffffff;
            padding: 15px 15px 5px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
        }
        .bar {
            background: linear-gradient(to top, #4f46e5, #818cf8);
            flex: 1;
            border-radius: 3px 3px 0 0;
            position: relative;
            min-height: 2px;
        }
        .bar.highlight {
            background: linear-gradient(to top, #f59e0b, #fbbf24);
        }
        .bar::after {
            content: attr(data-range);
            position: absolute;
            bottom: -22px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 10px;
            color: #94a3b8;
            white-space: nowrap;
        }
    </style>
</head>
<body>

<div class="container">
    
    <div class="header-container">
        <h1 class="header-title">学生用ポータルサイト</h1>
        <div class="header-actions">
            <a href="../action/StudentPasswordEdit.action" class="btn-password">
                <i class="fa-solid fa-key"></i> パスワード変更
            </a>
            <a href="../login/login.jsp" class="btn-logout">
                <i class="fa-solid fa-right-from-bracket"></i> ログアウト
            </a>
        </div>
    </div>

    <div class="pasted-card">
        <p style="font-size: 18px; margin: 0 0 15px 0;">ようこそ、<strong style="color: #4f46e5;">${loginStudent.name}</strong> さん！</p>
        <div class="profile-grid">
            <div class="profile-item">
                <div class="profile-label">学籍番号</div>
                <div class="profile-value">${loginStudent.no}</div>
            </div>
            <div class="profile-item">
                <div class="profile-label">氏名</div>
                <div class="profile-value">${loginStudent.name}</div>
            </div>
            <div class="profile-item">
                <div class="profile-label">入学年度</div>
                <div class="profile-value">${loginStudent.entYear} 年度</div>
            </div>
            <div class="profile-item">
                <div class="profile-label">クラス</div>
                <div class="profile-value">${loginStudent.classNum}</div>
            </div>
        </div>
    </div>

    <h2>最新のテスト成績</h2>
    <div class="pasted-card" style="padding: 10px 0 0 0; overflow: hidden;">
        <table class="score-table">
            <thead>
                <tr>
                    <th style="padding-left: 20px;">科目コード</th>
                    <th>科目名</th>
                    <th>あなたの得点</th>
                    <th style="text-align: center;">詳細情報</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="test" items="${latestScores}" varStatus="status">
                    <tr>
                        <td style="padding-left: 20px;">${test.subject.cd}</td>
                        <td>${test.subject.name}</td>
                        <td class="my-point">${test.point} 点</td>
                        <td style="text-align: center;">
                            <button class="detail-btn" onclick="toggleDetail('detail-${status.index}')">詳細を見る</button>
                        </td>
                    </tr>
                    
                    <tr id="detail-${status.index}" class="detail-container">
                        <td colspan="4">
                            <div class="detail-summary-box">
                                <div class="summary-item">学内順位: <strong>${test.rank} 位</strong></div>
                                <div class="summary-item">科目平均点: <strong>${test.averagePoint} 点</strong></div>
                                <div class="summary-item">最高点: <strong>${test.maxPoint} 点</strong></div>
                            </div>
                            
                            <div class="histogram-title"><i class="fa-solid fa-chart-bar"></i> 得点分布（ヒストグラム）</div>
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
                            <div style="margin-top: 30px; font-size: 12px; color: #64748b; text-align: center;">
                                ※オレンジ色のバーがあなたの得点圏内です。
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h2>過去の成績履歴</h2>
    <div class="pasted-card" style="padding: 10px 0 0 0; overflow: hidden;">
        <table class="score-table">
            <thead>
                <tr>
                    <th style="padding-left: 20px;">回数</th>
                    <th>科目名</th>
                    <th>あなたの得点</th>
                    <th style="text-align: center;">詳細情報</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="history" items="${allScores}" varStatus="status">
                    <tr>
                        <td style="padding-left: 20px;">第 ${history.no} 回</td>
                        <td>${history.subject.name}</td>
                        <td class="my-point" style="color: #334155;">${history.point} 点</td>
                        <td style="text-align: center;">
                            <button class="detail-btn" onclick="toggleDetail('history-detail-${status.index}')">詳細を見る</button>
                        </td>
                    </tr>
                    
                    <tr id="history-detail-${status.index}" class="detail-container">
                        <td colspan="4">
                            <div class="detail-summary-box">
                                <div class="summary-item">学内順位: <strong>${history.rank} 位</strong></div>
                                <div class="summary-item">科目平均点: <strong>${history.averagePoint} 点</strong></div>
                                <div class="summary-item">最高点: <strong>${history.maxPoint} 点</strong></div>
                            </div>
                            
                            <div class="histogram-title"><i class="fa-solid fa-chart-bar"></i> 得点分布（ヒストグラム）</div>
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
                            <div style="margin-top: 30px; font-size: 12px; color: #64748b; text-align: center;">
                                ※オレンジ色のバーがあなたの得点圏内です。
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>

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