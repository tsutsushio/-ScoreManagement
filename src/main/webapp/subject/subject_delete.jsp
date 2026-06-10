<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>

<style>
.content { max-width: 600px; margin: 40px auto; }
.page-title { background: #eeeeee; padding: 12px 15px; font-size: 24px; font-weight: bold; margin-bottom: 20px; }
.confirm-box { padding: 10px 0; }
.message { font-size: 16px; margin-bottom: 20px; }
.btn-delete { background: #d9534f; color: white; border: none; padding: 6px 14px; border-radius: 4px; cursor: pointer; font-size: 14px; }
.btn-delete:hover { background: #c9302c; }
.back-link { display: inline-block; margin-top: 25px; color: #3366cc; text-decoration: underline; }
.error-msg { color: red; font-weight: bold; margin-bottom: 15px; }
</style>

<div class="content">

    <!-- ① 科目情報削除 タイトル -->
    <div class="page-title">科目情報削除</div>

    <div class="confirm-box">
        <!-- エラーがあった場合のみ表示 -->
        <c:if test="${not empty errorMessage}">
            <div class="error-msg">${errorMessage}</div>
        </c:if>

        <!-- ② 確認メッセージ -->
        <div class="message">
            「${name} (${cd})」を削除してもよろしいですか？
        </div>

        <!-- ③ 削除ボタン（フォームで実行アクションへ送信） -->
        <form action="${pageContext.request.contextPath}/action/SubjectDeleteExecute.action" method="post">
            <!-- 次のアクションに引き渡すためにhiddenでコードと名前を隠し持つ -->
            <input type="hidden" name="cd" value="${cd}">
            <input type="hidden" name="name" value="${name}">
            <button type="submit" class="btn-delete">削除</button>
        </form>

        <!-- ④ 戻るリンク -->
        <a href="${pageContext.request.contextPath}/action/SubjectList.action" class="back-link">戻る</a>
    </div>

</div>

<%@ include file="/footer.jsp" %>
