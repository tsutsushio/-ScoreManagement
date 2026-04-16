<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="pageTitle" value="ログアウト" />
<%@ include file="/header.jsp" %>

<style>
    /* 画面全体の中央に寄せるための設定 */
    body { 
        font-family: 'Helvetica Neue', Arial, sans-serif;
        background-color: #f4f6f8; 
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    /* 白いメッセージボックス */
    .logout-box { 
        background-color: #ffffff;
        padding: 40px 50px; 
        border-radius: 12px; 
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        text-align: center; 
    }

    .msg { 
        font-size: 1.4em; 
        font-weight: bold; 
        color: #333; 
        margin-bottom: 10px;
    }

    .sub-msg {
        color: #666;
        margin-bottom: 25px;
        font-size: 1.1em;
    }

    /* カウントダウンの数字を目立たせる */
    #countdown {
        font-weight: bold;
        color: #d32f2f; /* 赤色で強調 */
        font-size: 1.3em;
    }

    /* 🌀 ぐるぐる回るスピナーのCSS */
    .spinner {
        width: 50px;
        height: 50px;
        margin: 0 auto 20px auto; 
        border: 6px solid #e0e0e0; 
        border-top: 6px solid #4caf50; 
        border-radius: 50%; 
        animation: spin 1s linear infinite; 
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* 手動リンク */
    .manual-link {
        margin-top: 20px;
        font-size: 0.9em;
    }
    .manual-link a {
        color: #4caf50;
        text-decoration: none;
    }
    .manual-link a:hover {
        text-decoration: underline;
    }
</style>

<div class="logout-box">
    <div class="spinner"></div>
    
    <p class="msg">安全にログアウトしました</p>
    
    <p class="sub-msg"><span id="countdown">3</span> 秒後に自動的にログイン画面へ戻ります...</p>
    
    <p class="manual-link">
        切り替わらない場合は<a href="${pageContext.request.contextPath}/login/login.jsp">こちらをクリック</a>してください。
    </p>
</div>

<script>
    // 初期設定：5秒
    let timeLeft = 3;
    
    // setIntervalを使って、1000ミリ秒(1秒)ごとに中の処理を繰り返す
    const timerId = setInterval(function() {
        timeLeft--; // 残り秒数を1減らす
        
        // 画面の <span id="countdown"> の数字を書き換える
        document.getElementById('countdown').textContent = timeLeft;
        
        // もし0秒になったら
        if (timeLeft <= 0) {
            clearInterval(timerId); // カウントダウンのタイマーを止める
            // ログイン画面へジャンプ
            window.location.href = "${pageContext.request.contextPath}/login/login.jsp";
        }
    }, 1000);
</script>

<%@ include file="/footer.html" %>