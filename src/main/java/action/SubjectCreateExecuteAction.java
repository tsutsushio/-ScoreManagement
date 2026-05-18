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

        // 入力値を保持（エラー時に再表示するため）
        request.setAttribute("cd", cd);
        request.setAttribute("name", name);

        // 未入力チェック
        if (cd == null || cd.isBlank()) {
            request.setAttribute("errorMessage",
                    "科目コードを入力してください。");
            return "/subject/subject-create.jsp";
        }

        if (name == null || name.isBlank()) {
            request.setAttribute("errorMessage",
                    "科目名を入力してください。");
            return "/subject/subject-create.jsp";
        }
        
        if (cd.length() < 3 || cd.length() > 3) {
            request.setAttribute("errorMessage",
                    "科目コードは3文字で入力してください。");
            return "/subject/subject_create.jsp";
        }


        // DAO生成
        SubjectDAO dao = new SubjectDAO();

        // 重複チェック
        SubjectBean exists = dao.get(cd);

        if (exists != null) {
            request.setAttribute("errorMessage",
                    "その科目コードは既に登録されています。");
            return "/subject/subject-create.jsp";
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