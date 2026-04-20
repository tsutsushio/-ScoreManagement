package action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LogoutAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 現在のセッションを取得
        HttpSession session = request.getSession();
        
        // 2. セッションの情報をすべて消去（破棄）する！
        session.invalidate();
        
        // 3. ログアウト完了画面（JSP）へ遷移
        return "/WEB-INF/view/logout/logout.jsp";
    }
}
