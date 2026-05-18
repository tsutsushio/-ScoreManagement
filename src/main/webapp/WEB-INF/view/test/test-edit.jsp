<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績編集</title>



<style>

</style>

</head>

<body>

<h2>成績登録</h2>

<form action="TestRegistExecute.action" method="post">

    <div>
        学生番号
        <input type="text" name="studentNo"
            value="${studentNo}">
        <div style="color:red">
            ${errors.studentNo}
        </div>
    </div>

    <br>

    <div>
        科目

        <select name="subjectCd">
            <option value="">--選択--</option>

            <option value="B02"
                <c:if test="${subjectCd == 'B02'}">
                    selected
                </c:if>
            >
                数学
            </option>

            <option value="D02"
                <c:if test="${subjectCd == 'D02'}">
                    selected
                </c:if>
            >
                英語
            </option>
        </select>

        <div style="color:red">
            ${errors.subjectCd}
        </div>
    </div>

    <br>

    <div>
        回数
        <input type="number" name="no"
            value="${no}">

        <div style="color:red">
            ${errors.no}
        </div>
    </div>

    <br>

    <div>
        点数
        <input type="number" name="point"
            value="${point}">

        <div style="color:red">
            ${errors.point}
        </div>
    </div>

    <br>

    <div>
        クラス番号
        <input type="text" name="classNum"
            value="${classNum}">
    </div>

    <br>

    <button type="submit">
        更新
    </button>
    

</form>

</body>
</html>