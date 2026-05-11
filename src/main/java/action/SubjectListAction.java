package action;

import java.util.List;

import bean.SubjectBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        SubjectDAO dao = new SubjectDAO();

        List<SubjectBean> subjectList = dao.list();

        request.setAttribute("subjectList", subjectList);

        return "/subject/subject_list.jsp";
    }
}