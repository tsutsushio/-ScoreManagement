package action;

import bean.SchoolBean;
import bean.SubjectBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {

@Override
public String execute(
        HttpServletRequest request,
        HttpServletResponse response) throws Exception {

    String cd = request.getParameter("cd");
    String name = request.getParameter("name");
    String schoolCd = request.getParameter("schoolCd");

    SubjectBean subject = new SubjectBean();
    subject.setCd(cd);
    subject.setName(name);

    SchoolBean school = new SchoolBean();
    school.setCd(schoolCd);
    subject.setSchool(school);

    SubjectDAO dao = new SubjectDAO();

    try {

        dao.update(subject);

        return "/subject/subject_update_done.jsp";

    } catch (Exception e) {

        request.setAttribute("errorMessage", e.getMessage());
        request.setAttribute("subject", subject);

        return "/subject/subject_update.jsp";
    }
}

}
