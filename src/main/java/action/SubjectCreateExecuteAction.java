package action;

import bean.SubjectBean;
import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 文字コード設定
        request.setCharacterEncoding("UTF-8");

        // ログイン情報取得
        HttpSession session = request.getSession();
        TeacherBean loginUser =
                (TeacherBean) session.getAttribute("loginUser");

        // 未ログインの場合
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // フォームから入力値を取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 入力値を保持
        request.setAttribute("cd", cd);
        request.setAttribute("name", name);

        // 未入力チェック
        if (cd == null || cd.isBlank()
                || name == null || name.isBlank()) {

            request.setAttribute("errorMessage",
                    "科目コードと科目名を入力してください。");

            return "/subject/subject_create.jsp";
        }

        // DAO生成
        SubjectDAO dao = new SubjectDAO();

        // 重複チェック
        SubjectBean exists = dao.get(cd);

        if (exists != null) {
            request.setAttribute("errorMessage",
                    "その科目コードは既に登録されています。");

            return "/subject/subject_create.jsp";
        }

        // SubjectBean作成
        SubjectBean subject = new SubjectBean();
        subject.setSchoolCd(loginUser.getSchool().getCd());
        subject.setCd(cd);
        subject.setName(name);

        // 登録実行
        dao.insert(subject);

        // 一覧画面へ戻る
        return "SubjectList.action";
    }
}