package action;

import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログインユーザー取得
        HttpSession session = request.getSession();
        TeacherBean user = (TeacherBean) session.getAttribute("loginUser");

        if (user == null) {
            return "/login/login.jsp";
        }

        // 画面のform（hiddenパラメータ）から送られてきた科目コードを取得
        String cd = request.getParameter("cd");
        String schoolCd = user.getSchool().getCd();

        SubjectDAO dao = new SubjectDAO();

        try {
            // ここで本当にDBから削除
            dao.delete(cd, schoolCd);
            
        } catch (Exception e) {
            // エラーが発生した場合は、メッセージを持って確認画面(subject_delete.jsp)に戻す
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("cd", cd);
            request.setAttribute("name", request.getParameter("name")); 
            return "/subject/subject_delete.jsp";
        }

        // 削除「完了」画面へ遷移
        return "/subject/subject_delete_done.jsp";
    }
}
