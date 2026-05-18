<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生メニュー</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; margin-bottom: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .score-box { background-color: #f9f9f9; padding: 15px; border-radius: 5px; border: 1px solid #e0e0e0; }
        .point { font-weight: bold; text-align: right; }
        .no-data { color: #666; font-style: italic; }
    </style>
</head>
<body>

    <h1>学生用ポータルサイト</h1>
    <p>ようこそ、<strong>${loginStudent.name}</strong> さん！</p>
    <hr>

    <h2>あなたの基本情報</h2>
    <ul>
        <li><strong>学籍番号：</strong> ${loginStudent.no}</li>
        <li><strong>氏名：</strong> ${loginStudent.name}</li>
        <li><strong>入学年度：</strong> ${loginStudent.entYear} 年度</li>
        <li><strong>クラス：</strong> ${loginStudent.classNum}</li>
    </ul>
    <hr>

    <h2>最新のテスト成績</h2>
    <div class="score-box">
        <c:choose>
            <%-- もし成績リストが空（empty）ならメッセージを表示 --%>
            <c:when test="${empty latestScores}">
                <p class="no-data">現在、登録されている最新の成績はありません。</p>
            </c:when>
            <%-- データがあればテーブルを表示 --%>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>科目コード</th>
                            <th>科目名</th>
                            <th style="text-align: right;">得点</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- ★Actionから渡された latestScores をループ表示 --%>
                        <c:forEach var="test" items="${latestScores}">
                            <tr>
                                <td>${test.subject.cd}</td>
                                <td>${test.subject.name}</td>
                                <td class="point">${test.point} 点</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
    <hr>

    <h2>過去の成績履歴</h2>
    <c:choose>
        <c:when test="${empty allScores}">
             <p class="no-data">過去の成績データはありません。</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>回数</th>
                        <th>科目名</th>
                        <th style="text-align: right;">得点</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- ★Actionから渡された allScores をループ表示 --%>
                    <c:forEach var="test" items="${allScores}">
                        <tr>
                            <td>第 ${test.no} 回</td>
                            <td>${test.subject.name}</td>
                            <td class="point">${test.point} 点</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
    <hr>

    <h2>メニュー</h2>
    <ul>
        <li><a href="#">パスワードを変更する（準備中）</a></li>
    </ul>

    <br>
    <p><a href="../login/login.jsp">ログアウトして戻る</a></p>

</body>
</html>
