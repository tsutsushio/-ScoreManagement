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
        
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        String schoolCd = loginUser.getSchool().getCd();
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        String isAttendStr = req.getParameter("isAttend");

        int entYear = 0; 
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }

        // バリデーションチェック
        if (classNum != null && !"--------".equals(classNum) && entYear == 0) {
            req.setAttribute("error", "クラスを指定する場合は入学年度も指定してください");
            
            // エラー時は「検索条件をリセットして全件表示」に切り替える
            entYear = 0;
            classNum = "--------";
            isAttendStr = null; 
        }

        // 検索処理（エラーでもエラーじゃなくても検索を実行する）
        boolean isAttend = (isAttendStr != null);
        StudentDAO studentDao = new StudentDAO();
        List<StudentBean> studentList = studentDao.filter(schoolCd, entYear, classNum, isAttend);

        req.setAttribute("studentList", studentList);

        return "/WEB-INF/view/student/student_list.jsp";
    }
}