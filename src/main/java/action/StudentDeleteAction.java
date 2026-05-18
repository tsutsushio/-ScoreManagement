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

        // 2. 画面から送られてきた「削除したい生徒の番号」を受け取る
        String no = req.getParameter("no");
        if (no == null || no.isEmpty()) {
            return "/action/StudentList.action";
        }

        // 3. データベースからその学生の情報を取得する
        StudentDAO dao = new StudentDAO();
        StudentBean student = dao.get(no);

        if (student == null) {
            return "/action/StudentList.action"; 
        }

        // IDOR（不正削除）対策
        String teacherSchoolCd = loginUser.getSchool().getCd();
        String studentSchoolCd = student.getSchool().getCd();
        
        if (!teacherSchoolCd.equals(studentSchoolCd)) {
            // 他校の生徒の番号をイジって消そうとした場合はブロック！
            req.setAttribute("errorMsg", "エラー：他校の生徒は削除できません。");
            return "/action/StudentList.action";
        }
        // =========================================================

        // 4. 安全が確認できたので、StudentDAOを使ってデータベースから削除
        dao.delete(student);

        // 5. 削除後は学生一覧画面へ戻る
        return "/action/StudentList.action";
    }
}