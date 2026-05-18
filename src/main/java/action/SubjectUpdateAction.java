package action;

import bean.SubjectBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectUpdateAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String cd = request.getParameter("cd");

        SubjectDAO dao = new SubjectDAO();
        SubjectBean subject = dao.get(cd, null);

        request.setAttribute("subject", subject);

        return "/subject/subject_update.jsp";
    }
}