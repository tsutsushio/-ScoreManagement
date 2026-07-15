package action;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentDeleteAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "/login/login.jsp"; 
        }

        // 2. パラメータ受け取り
        String no = req.getParameter("no");
        if (no == null || no.isEmpty()) {
            return "/action/StudentList.action";
        }

        // 3. 対象の学生情報を取得
        StudentDAO dao = new StudentDAO();
        StudentBean student = dao.get(no);

        if (student == null) {
            return "/action/StudentList.action"; 
        }

        // IDOR（不正削除）対策
        String teacherSchoolCd = loginUser.getSchool().getCd();
        String studentSchoolCd = student.getSchool().getCd();
        
        if (!teacherSchoolCd.equals(studentSchoolCd)) {
            req.setAttribute("errorMsg", "エラー：他校の生徒は削除できません。");
            return "/action/StudentList.action";
        }

        // 4. データベースから削除実行
        try {
            dao.delete(student);
        } catch (Exception e) {
            // 削除失敗時のエラーハンドリング
            req.setAttribute("errorMsg", "エラー：削除に失敗しました。");
            return "/action/StudentList.action";
        }

        // 5. 成功時は一覧へ
        return "/action/StudentList.action";
    }
}