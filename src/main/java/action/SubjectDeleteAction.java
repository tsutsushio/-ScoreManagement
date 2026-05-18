package action;

import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectDeleteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログインユーザー取得
        TeacherBean user = (TeacherBean)
                request.getSession().getAttribute("loginUser");

        // 未ログインならログイン画面へ
        if (user == null) {
            return "/login.jsp";
        }

        // 科目コード取得
        String cd = request.getParameter("cd");

        // DAO生成
        SubjectDAO dao = new SubjectDAO();

        // cd が指定されていれば削除
        if (cd != null && !cd.isEmpty()) {
            String schoolCd = user.getSchool().getCd();
            dao.delete(cd, schoolCd);
        }

        // 一覧を再取得
        request.setAttribute("subjectList", dao.list());

        // 一覧画面へ戻る
        return "/subject/subject_list.jsp";
    }
}