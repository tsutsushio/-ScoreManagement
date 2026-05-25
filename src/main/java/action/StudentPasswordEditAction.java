package action;

import bean.StudentBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentPasswordEditAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. 学生のログインチェック（名札の確認）
        HttpSession session = req.getSession();
        StudentBean loginStudent = (StudentBean) session.getAttribute("loginStudent");
        
        // 学生がログインしていない場合はログイン画面へ追い返す
        if (loginStudent == null) {
            return "/login/login.jsp";
        }

        // 2. パスワード変更画面（JSP）へ遷移
        return "/WEB-INF/view/student/student_password_edit.jsp";
    }
}
