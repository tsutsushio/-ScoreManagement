package action;

import java.util.List;

import bean.StudentBean;
import bean.TestBean;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentMenuAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. 学生のログインチェック（名札の確認）
        HttpSession session = req.getSession();
        StudentBean loginStudent = (StudentBean) session.getAttribute("loginStudent");
        
        // 学生がログインしていない場合はログイン画面へ追い返す
        if (loginStudent == null) {
            return "/login/login.jsp";
        }

        // 2. ログインしている学生の学籍番号を取得
        String studentNo = loginStudent.getNo();

        // 3. TestDAOを使って「最新の成績」と「過去の成績」を両方取得
        TestDAO testDao = new TestDAO();
        List<TestBean> latestScores = testDao.getLatestScores(studentNo);
        List<TestBean> allScores = testDao.getAllScores(studentNo);

        // 4. 取得したデータをJSPで使えるようにリクエストに格納（セット）
        req.setAttribute("latestScores", latestScores);
        req.setAttribute("allScores", allScores);

        // 5. 学生用メニュー画面（JSP）へ転送
        return "/WEB-INF/view/student/student_menu.jsp";
    }
}
