<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>

    <style>
    body{
        margin:0;
        font-family:
            "Yu Gothic",
            "Meiryo",
            "MS Gothic",
            sans-serif;
        background: linear-gradient(to bottom, #001133 0%, #003366 60%, #001122 100%);
        color:white;
        min-height:100vh;
    }

    body::before{
        content:"";
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background-image:
            radial-gradient(white 1px, transparent 1px),
            radial-gradient(#88ccff 1px, transparent 1px);
        background-size:80px 80px, 140px 140px;
        opacity:0.35;
        z-index:-1;
    }

    /* 上部ヘッダー */
    .header{
    position:relative;
    background:#102a7a;
    border:4px solid #fff;
    box-shadow:
        0 0 0 4px #2f5fff,
        8px 8px 0 rgba(0,0,0,0.6);
    padding:25px 30px;
    margin:20px;
    min-height:60px;
}

/* タイトルを中央 */
.header h1{
    margin:0;
    position:absolute;
    left:50%;
    top:50%;
    transform:translate(-50%, -50%);
    font-size:42px;
    color:#fff;
    text-shadow:3px 3px 0 #000;
    letter-spacing:2px;
    white-space:nowrap;
}

/* ユーザー名＋ログアウトを右端 */
.user-area{
    position:absolute;
    right:30px;
    top:50%;
    transform:translateY(-50%);
    font-size:18px;
    color:#ffff88;
    text-shadow:1px 1px 0 #000;
    white-space:nowrap;
}

.logout{
    color:#ffff88;
    text-decoration:none;
    margin-right:15px;
}

.logout:hover{
    color:#ffffff;
}
    

    /* レイアウト */
    .container{
        display:flex;
        gap:20px;
        margin:20px;
        align-items:flex-start;
    }

    /* 左メニュー */
    .side-menu{
        width:220px;
        background:#102a7a;
        border:4px solid #fff;
        box-shadow:
            0 0 0 4px #2f5fff,
            8px 8px 0 rgba(0,0,0,0.6);
        padding:20px;
        box-sizing:border-box;
    }

    .side-title{
        font-size:22px;
        margin-bottom:20px;
        text-shadow:2px 2px 0 #000;
        color:#ffff88;
    }

    .side-menu a{
        display:block;
        color:#fff;
        text-decoration:none;
        font-size:20px;
        padding:10px;
        margin-bottom:10px;
        border:2px solid transparent;
        text-shadow:1px 1px 0 #000;
    }

    .side-menu a:hover{
        background:#4444ff;
        border:2px solid #fff;
        color:#ffff88;
    }

    /* メイン部分 */
    .content{
        flex:1;
        background:#102a7a;
        border:4px solid #fff;
        box-shadow:
            0 0 0 4px #2f5fff,
            8px 8px 0 rgba(0,0,0,0.6);
        padding:30px;
        box-sizing:border-box;
    }

    .content h2{
        margin-top:0;
        margin-bottom:25px;
        font-size:34px;
        text-shadow:2px 2px 0 #000;
        color:#fff;
    }

    /* カードメニュー */
    .menu-grid{
        display:flex;
        gap:25px;
        flex-wrap:wrap;
    }

    .menu-card{
        width:240px;
        min-height:150px;
        background:#1c3faa;
        border:4px solid #fff;
        box-shadow:
            0 0 0 4px #2f5fff,
            8px 8px 0 rgba(0,0,0,0.6);
        padding:20px;
        box-sizing:border-box;
    }

    .menu-card a{
        display:block;
        color:#fff;
        text-decoration:none;
        font-size:26px;
        margin:10px 0;
        text-shadow:2px 2px 0 #000;
    }

    .menu-card a:hover{
        color:#ffff88;
    }
    </style>
</head>

<body>

    <div class="header">
        <h1>得点管理システム</h1>

            <a class="logout" href="<%= request.getContextPath() %>/logout">ログアウト</a>
        </div>
    </div>

    <div class="container">

        <div class="side-menu">
            <div class="side-title">メニュー</div>

            <a href="<%= request.getContextPath() %>/student/list">
                ▶ 学生管理
            </a>

            <a href="<%= request.getContextPath() %>/score/register">
                ▶ 成績登録
            </a>

            <a href="<%= request.getContextPath() %>/score/list">
                ▶ 成績参照
            </a>

            <a href="<%= request.getContextPath() %>/subject/list">
                ▶ 科目管理
            </a>
        </div>

        <div class="content">
            <h2>メニュー</h2>

            <div class="menu-grid">

                <div class="menu-card">
                    <a href="<%= request.getContextPath() %>/student/list">
                        ▶ 学生管理
                    </a>
                </div>

                <div class="menu-card">
                    <a href="<%= request.getContextPath() %>/score/register">
                        ▶ 成績登録
                    </a>

                    <a href="<%= request.getContextPath() %>/score/list">
                        ▶ 成績参照
                    </a>
                </div>

                <div class="menu-card">
                    <a href="<%= request.getContextPath() %>/subject/list">
                        ▶ 科目管理
                    </a>
                </div>

            </div>
        </div>

    </div>


</body>
</html>
