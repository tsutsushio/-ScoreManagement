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

        // 1. ログインユーザー取得
        HttpSession session = request.getSession();
        TeacherBean user = (TeacherBean) session.getAttribute("loginUser");

        if (user == null) {
            return "/login/login.jsp";
        }

        // 2. 画面から送られてきた科目コードを取得
        String cd = request.getParameter("cd");
        String schoolCd = user.getSchool().getCd();

        SubjectDAO dao = new SubjectDAO();

        // 3. 【シーケンス図通り】DBから科目を削除 ＆ 例外処理のキャッチ
        try {
            dao.delete(cd, schoolCd);
            
        } catch (Exception e) {
            // DAO側で「成績データが残っているため削除できません」等のエラーが出た場合
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("cd", cd);
            request.setAttribute("name", request.getParameter("name")); // 画面表示用に名前を保持
            
            // エラーメッセージを持たせて確認画面へ戻す
            return "/subject/subject_delete.jsp";
        }

        // 4. 削除完了画面へ遷移
        return "/subject/subject_delete_done.jsp";
    }
}