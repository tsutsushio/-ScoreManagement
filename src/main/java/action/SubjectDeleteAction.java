package action;

import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectDeleteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログインユーザー取得
        HttpSession session = request.getSession();

        TeacherBean user =
                (TeacherBean) session.getAttribute("loginUser");

        if (user == null) {
            return "/login/login.jsp";
        }

        // 削除対象科目コード
        String cd = request.getParameter("cd");

        // 学校コード取得
        String schoolCd = user.getSchool().getCd();

        // 削除実行
        SubjectDAO dao = new SubjectDAO();

        boolean result =
                dao.delete(cd, schoolCd);

        request.setAttribute("result", result);
        request.setAttribute("cd", cd);

        // 削除完了画面
        return "/subject/subject_delete.jsp";
    }
}