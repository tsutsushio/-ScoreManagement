package action;

import bean.TeacherBean;
import dao.TeacherDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. JSPから入力されたIDとパスワードを受け取る
        // 修正1: IDは文字列(String)として受け取る
        String id = request.getParameter("id");
        String rawPassword = request.getParameter("password"); 

        // 入力されたパスワードをハッシュ化
//        String hashedPassword = tool.PasswordUtil.hashPassword(rawPassword);

        // 2. DAOを使ってデータベースを検索
        TeacherDAO dao = new TeacherDAO();
        TeacherBean teacher = dao.login(id, rawPassword);

        // 3. 結果に応じた画面（JSPのファイル名、または次のAction）を返す
        if (teacher != null) {
            // 【ログイン成功】
            // セッションにユーザー情報を保存
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", teacher);

            // ※FrontController経由でメニュー表示用のActionを呼ぶ想定
            return "/action/Menu.action"; 
            
        } else {
            // 【ログイン失敗】
            // エラーメッセージをセットして元のログイン画面へ戻す
            request.setAttribute("error", "IDまたはパスワードが間違っています");
            return "/login/login.jsp";         }
    }
}