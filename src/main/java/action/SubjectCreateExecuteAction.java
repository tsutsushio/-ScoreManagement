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
            HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession();
        TeacherBean loginUser =
                (TeacherBean) session.getAttribute("loginUser");

        // 未ログイン
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // 入力値取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 入力値を再表示用に設定
        request.setAttribute("cd", cd);
        request.setAttribute("name", name);

        // 必須チェック
        if (cd == null || cd.isEmpty()
                || name == null || name.isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "科目コードと科目名を入力してください。"
            );

            return "/subject/subject_create.jsp";
        }
        
        if (name.length() > 20) {

            request.setAttribute(
                    "errorMessage",
                    "科目名は20文字以内で入力してください。"
            );

            return "/subject/subject_create.jsp";
        }
        

        SubjectDAO dao = new SubjectDAO();

        // 重複チェック
        SubjectBean existing = dao.get(cd);
        if (existing != null) {
            request.setAttribute(
                    "errorMessage",
                    "その科目コードはすでに登録されています。"
            );

            return "/subject/subject_create.jsp";
        }

        // 登録データ作成
        SubjectBean subject = new SubjectBean();
        subject.setSchoolCd(
                loginUser.getSchool().getCd()
        );
        subject.setCd(cd);
        subject.setName(name);

        // DB登録
        dao.insert(subject);

        // 完了画面へ
        return "/subject/subject_create_done.jsp";
    }
}