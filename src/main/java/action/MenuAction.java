package action;

import bean.TeacherBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class MenuAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        TeacherBean loginTeacher = (TeacherBean) session.getAttribute("loginUser");

        // ログインしていない（セッションが空の）場合は、不正アクセスとしてログイン画面へ弾く
        if (loginTeacher == null) {
            // 必要に応じてエラーメッセージをセット
            request.setAttribute("error", "ログインしてください。");
            return "/login/login.jsp";
        }

        // ログイン済みであることが確認できたら、メニュー画面へ遷移
        return "/WEB-INF/view/menu/menu.jsp";
    }
}