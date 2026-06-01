package action;

import java.util.List;

import bean.SubjectBean;
import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 1. ログインチェック
        HttpSession session = request.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");

        // 未ログインの場合はログイン画面へ弾く
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // 2. ログインしている先生の「学校コード」を取得
        String schoolCd = loginUser.getSchool().getCd();

        // 3. DAOを使って、その学校の科目だけを絞り込んで取得（filterメソッドを使用）
        SubjectDAO dao = new SubjectDAO();
        List<SubjectBean> subjectList = dao.filter(schoolCd);

        // 4. リクエストにセットしてJSPへ渡す
        request.setAttribute("subjectList", subjectList);

        return "/subject/subject_list.jsp";
    }
}