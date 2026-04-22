<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

.sidebar {
        width: 200px;
        background-color: #fff;
        padding: 20px;
        border-right: 1px solid #ddd;
    }
    .sidebar ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    .sidebar li {
        margin-bottom: 10px;
    }
    .sidebar a {
        text-decoration: none;
        color: #0066cc;
        display: block;
        padding: 5px 0;
    }
    .sidebar .sub-menu {
        margin-left: 15px;
        font-size: 0.9em;
    }
    
</style>


    
 <div class="sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/action/Menu.action">メニュー</a></li>
                <li><a href="${pageContext.request.contextPath}/action/StudentList.action">学生管理</a></li>
                <li>成績管理
                    <ul class="sub-menu">
                        <li><a href="#">成績登録</a></li>
                        <li><a href="#">成績参照</a></li>
                    </ul>
                </li>
                <li><a href="#">科目管理</a></li>
            </ul>
        </div>