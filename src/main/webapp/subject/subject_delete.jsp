<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>

<style>
/* 画面中央にすっきりと収まるコンテナ（白カード化） */
.content { 
    max-width: 600px; 
    margin: 40px auto; 
    background: #ffffff;
    border-radius: 12px;
    padding: 40px; /* カード内の余白を贅沢に確保 */
    /* 影を少し濃いめにして、立体感をはっきりと強化 */
    box-shadow: 0 4px 20px rgba(100, 120, 100, 0.12); 
    box-sizing: border-box;
}


/* ページタイトル（グレーの帯を廃止し、シンプルな下線スタイルに） */
.page-title { 
    font-size: 22px; 
    font-weight: 500; 
    letter-spacing: 0.05em;
    background-color: transparent; 
    padding: 0 0 15px 0; 
    margin: 0 0 35px 0; 
    color: #2c5234; 
    border-bottom: 2px solid #e8ece9; /* 繊細な下線 */
}

/* 確認エリアの調整 */
.confirm-box { 
    padding: 10px 0; 
}

/* 確認メッセージの文字色とサイズを微調整 */
.message { 
    font-size: 15px; 
    line-height: 1.6;
    color: #2b2d42; /* 優しい黒 */
    margin-bottom: 30px; 
}

/* 削除ボタン（ギラギラした原色の赤を、少し上品で深みのある赤へ変更） */
.btn-delete { 
    height: 40px; /* 高さを揃えてスマートに */
    padding: 0 28px; 
    background-color: #c94a47; /* 落ち着いた大人の赤 */
    color: #ffffff; 
    border: none; 
    border-radius: 8px; 
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.03em;
    cursor: pointer; 
    transition: all 0.2s ease;
}

.btn-delete:hover { 
    background-color: #a83835; /* ホバー時は少し深い色合いに */
    box-shadow: 0 4px 12px rgba(197, 74, 71, 0.2); /* 浮き上がる赤い影 */
}

/* 戻るリンク（野暮ったい下線と青色を廃止し、テーマカラーのテキストリンクへ） */
.back-link { 
    display: inline-block; 
    margin-top: 25px; 
    margin-left: 20px; /* ボタンとの間の適切な距離 */
    color: #8a958f; /* 普段は控えめなグレー */
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
    transition: color 0.2s ease;
}

.back-link:hover { 
    color: #4a7c59; /* ホバーするとテーマカラーのグリーンに */
}

/* エラーメッセージ（強すぎる赤から、ミニマルな画面に美しく馴染むオレンジ寄りの警告色へ） */
.error-msg { 
    color: #e67e22; 
    font-size: 13px;
    font-weight: 500;
    margin-bottom: 20px; 
}

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
