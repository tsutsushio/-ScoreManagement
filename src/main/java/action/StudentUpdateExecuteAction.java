package action;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // 2. 編集画面から送られてきたデータを受け取る
        String no = req.getParameter("no");
        int entYear = Integer.parseInt(req.getParameter("entYear"));
        String name = req.getParameter("name");
        String classNum = req.getParameter("classNum");
        
        // 【重要】チェックボックスの判定
        // "isAttend" という名前のデータが送られてきていれば true(在学中)、なければ false(退学)
        boolean isAttend = (req.getParameter("isAttend") != null);
        
        // 3. 受け取ったデータを StudentBean（箱）に詰め込む
        StudentBean student = new StudentBean();
        student.setNo(no);
        student.setEntYear(entYear);
        student.setName(name);
        student.setClassNum(classNum);
        student.setIsAttend(isAttend);
        student.setSchool(loginUser.getSchool()); // ログイン中の先生の学校コードをセット

        // 4. DAOを使ってデータベースを上書きする
        StudentDAO dao = new StudentDAO(); 
        dao.save(student); 

        // 5. 完了画面へ遷移する
        return "/WEB-INF/view/student/student_update_done.jsp";
    }
}