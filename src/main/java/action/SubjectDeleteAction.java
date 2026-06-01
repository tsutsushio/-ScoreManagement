package action;

import bean.SubjectBean;
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

        // 1. ログインユーザー取得
        HttpSession session = request.getSession();
        TeacherBean user = (TeacherBean) session.getAttribute("loginUser");

        if (user == null) {
            return "/login/login.jsp"; // パスを正確なものに調整
        }

        // 2. 削除対象の科目コードを取得
        String cd = request.getParameter("cd");

        // 3. 【シーケンス図通り】科目の詳細データを取得する
        SubjectDAO dao = new SubjectDAO();
        SubjectBean subject = dao.get(cd);

        if (subject == null) {
            // 万が一データが存在しない場合は一覧へ戻すなどの安全対策
            return "/action/SubjectList.action";
        }

        // 4. 確認画面で表示するためにリクエストにセット
        request.setAttribute("cd", subject.getCd());
        request.setAttribute("name", subject.getName());

        // 5. 削除確認画面へ遷移
        return "/subject/subject_delete.jsp";
    }
}