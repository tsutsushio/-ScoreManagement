package action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class LoginAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String password = request.getParameter("password");

        if ("admin".equals(id) && "1234".equals(password)) {
            return "menu.jsp";
        } else {
            request.setAttribute("error", "IDかパスワードが違う😭😭😭😭😭😭😭");
            return "/login/login.jsp";
        }
    }
}