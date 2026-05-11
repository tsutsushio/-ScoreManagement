package action;

import javax.security.auth.Subject;

import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");

        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 入力値を戻す用
        request.setAttribute("cd", cd);
        request.setAttribute("name", name);

        // 未入力チェック
        if (cd == null || cd.isBlank() ||
            name == null || name.isBlank()) {

            request.setAttribute("errorMessage", "科目コードと科目名を入力してください。");
            return "/subject/subjectcreate.jsp";
        }

        SubjectDAO dao = new SubjectDAO();

        // 重複チェック
        Subject exists = dao.get(cd);

        if (exists != null) {
            request.setAttribute("errorMessage", "その科目コードは既に登録されています。");
            return "/subject/subjectcreate.jsp";
        }

        // 登録
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);

        dao.insert(subject);

        // 一覧へ戻る
        return "SubjectList.java";
    }
}
