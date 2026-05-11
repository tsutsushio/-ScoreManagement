package action;

import bean.SchoolBean;
import bean.TeacherBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();

        // テスト用のデータ作成
        SchoolBean school = new SchoolBean();
        // school.setCd("001"); // DAOでfilterを使うならコードが必要かもしれません
        
        TeacherBean teacher = new TeacherBean();
        teacher.setSchool(school); 

        // セッションに保存
        session.setAttribute("user", teacher);

        // ★修正ポイント：ログイン「後」に表示したいページを返却する
        // login.jspに戻るのではなく、メニュー画面などに飛ばす
        return "/main.jsp"; // あなたのプロジェクトのメイン画面のパスに合わせてください
    }
}