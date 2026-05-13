<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目変更</title>
</head>
<body>

    <h2>科目変更</h2>

    <form action="${pageContext.request.contextPath}/action/SubjectUpdateExecute.action"
          method="post">

        <!-- 科目コード（変更不可なので hidden で送信） -->
        <input type="hidden" name="cd" value="${subject.cd}">

        <table border="1">
            <tr>
                <th>科目コード</th>
                <td>${subject.cd}</td>
            </tr>
            <tr>
                <th>科目名</th>
                <td>
                    <input type="text"
                           name="name"
                           value="${subject.name}"
                           required>
                </td>
            </tr>
        </table>

        <p>
            <input type="submit" value="変更">
            <a href="${pageContext.request.contextPath}/action/SubjectList.action">
                戻る
            </a>
        </p>

    </form>

</body>
</html>