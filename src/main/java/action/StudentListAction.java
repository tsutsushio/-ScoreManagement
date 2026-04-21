package action;

import java.util.List;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentListAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null ) {
            return "/login/login.jsp";
        }

        // 2. ログインしている教員の「学校コード」を取得
        String schoolCd = loginUser.getSchool().getCd();

        // 3. 画面からの入力値（検索条件）を安全に受け取る
        // 入学年度（文字列で受け取ってから数値に変換）
        String entYearStr = req.getParameter("entYear");
        int entYear = 0; 
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }
        String classNum = req.getParameter("classNum");
        // 在学中フラグ（チェックボックス）
        // ※チェックボックスは、チェックされている時だけ値が送られてきます。
        // （JSP側で <input type="checkbox" name="isAttend" value="true"> としている想定）
        String isAttendStr = req.getParameter("isAttend");
        boolean isAttend = false;
        if (isAttendStr != null) {
            isAttend = true; // 値が送られてくればtrue（チェックあり）
        }

        // 4. DAOを使って条件に合う学生を検索する
        StudentDAO studentDao = new StudentDAO();
        // ※メソッド名を検索用の filter に修正し、4つの引数を渡す
        List<StudentBean> studentList = studentDao.filter(schoolCd, entYear, classNum, isAttend);

        // 5. 検索結果をリクエストスコープに保存する
        req.setAttribute("studentList", studentList);

        return "/WEB-INF/view/student/student-list.jsp";
    }
}
