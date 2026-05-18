package action;

import bean.TeacherBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectCreateAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession();
        TeacherBean loginUser =
                (TeacherBean) session.getAttribute("loginUser");

        // 未ログインならログイン画面へ
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // 科目登録画面を表示
        return "/subject/subject_create.jsp";
    }
}