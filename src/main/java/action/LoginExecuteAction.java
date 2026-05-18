package action;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import dao.TeacherDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. JSPから入力されたIDとパスワードを受け取る
        String id = req.getParameter("id");
        String rawPassword = req.getParameter("password"); 

        // 2. DAOを使ってデータベースを検索
        TeacherDAO teacherdao = new TeacherDAO();
        TeacherBean teacher = teacherdao.login(id, rawPassword);
        
        StudentDAO studentdao = new StudentDAO();
        StudentBean student = studentdao.login(id, rawPassword);

        // 3. 結果に応じた画面へ遷移
        if (teacher != null) {
            // 【先生のログイン成功】
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", teacher); // 先生は "loginUser"

            return "/action/Menu.action"; 
            
        } else if (student != null) { 
            // 【学生のログイン成功】
            HttpSession session = req.getSession();
            session.setAttribute("loginStudent", student); // 学生は "loginStudent" ！！
            
            // 学生用のメニュー画面（または成績参照用のAction）へ飛ばす
            // ※とりあえず仮のパスを書いています。後で正式なファイル名に合わせましょう。
            return "/action/StudentMenu.action";
            
        } else {
            // 【ログイン失敗】
            req.setAttribute("error", "IDまたはパスワードが間違っています");
            return "/login/login.jsp";         
        }
    }
}
