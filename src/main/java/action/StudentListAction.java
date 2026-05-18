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
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        // セッション取得
        HttpSession session = request.getSession();

        // ログインユーザー取得
        TeacherBean loginUser =
            (TeacherBean) session.getAttribute("loginUser");

        // 未ログインならログイン画面へ
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // 学校コード取得
        String schoolCd =
            loginUser.getSchool().getCd();

        // 検索条件取得
        String entYearStr =
            request.getParameter("entYear");

        int entYear = 0;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }

        String classNum =
            request.getParameter("classNum");

        if (classNum == null || classNum.isEmpty()) {
            classNum = "--------";
        }

        // 在学中チェックボックス
        boolean isAttend =
            "true".equals(request.getParameter("isAttend"));

        // 学生一覧取得
        StudentDAO dao = new StudentDAO();
        List<StudentBean> list =
            dao.filter(
                schoolCd,
                entYear,
                classNum,
                isAttend
            );

        // JSPへ渡す
        request.setAttribute("studentList", list);

        // 検索条件も保持
        request.setAttribute("entYear", entYear);
        request.setAttribute("classNum", classNum);
        request.setAttribute("isAttend", isAttend);

        // 一覧画面へ
        return "/student/student_list.jsp";
    }
}