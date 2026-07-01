package action;

import java.util.ArrayList;
import java.util.List;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateAction extends Action {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "/login/login.jsp"; 
        }

        // 2. 一覧画面の「変更」リンクから送られてきた学生番号(no)を受け取る
        String no = req.getParameter("no");

        // 3. DAOを使って、データベースからその学生の現在のデータを引っぱり出してくる
        StudentDAO dao = new StudentDAO();
        StudentBean student = dao.get(no);

        // 4. クラスのドロップダウンリスト用のデータを準備（登録機能と同じ）
        List<String> classList = new ArrayList<>();
        classList.add("101");
        classList.add("102");
        classList.add("201");
        classList.add("202");

        // 5. 取得した学生データとクラスリストをリクエストスコープに保存してJSPへ渡す
        req.setAttribute("student", student);
        req.setAttribute("classList", classList);
        
        // 6. 変更画面へ遷移
        return "/WEB-INF/view/student/student_update.jsp";
    }
}