package action;

import java.util.List;

import bean.SubjectBean;
import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ErrorPostCreateAction extends Action {

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

        // 科目一覧を取得
        
        // ログイン中の先生の学校コードを取得
        String schoolCd = loginUser.getSchool().getCd();

        // ログイン中の学校の科目だけ取得
        SubjectDAO subjectDAO = new SubjectDAO();

        List<SubjectBean> subjectList =
                subjectDAO.filter(schoolCd);

        // JSPに科目一覧を渡す
        request.setAttribute("subjectList", subjectList);

        // エラー投稿画面を表示
        return  "/WEB-INF/view/error/error_post.jsp";
    }
}