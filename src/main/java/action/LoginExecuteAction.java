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

	    try {

	        String id = req.getParameter("id");
	        String rawPassword = req.getParameter("password");

	        TeacherDAO teacherdao = new TeacherDAO();
	        TeacherBean teacher = teacherdao.login(id, rawPassword);

	        StudentDAO studentdao = new StudentDAO();
	        StudentBean student = studentdao.login(id, rawPassword);

	        if (teacher != null) {
	            HttpSession session = req.getSession();
	            session.setAttribute("loginUser", teacher);

	            return "/action/Menu.action";

	        } else if (student != null) {
	            HttpSession session = req.getSession();
	            session.setAttribute("loginStudent", student);

	            return "/action/StudentMenu.action";

	        } else {
	            req.setAttribute("error", "IDまたはパスワードが間違っています");
	            req.setAttribute("id", id);
	            return "/login/login.jsp";
	        }

	    } catch (Exception e) {

	        e.printStackTrace();

	        return "/login/error.jsp";
	    }
	
    }
}
