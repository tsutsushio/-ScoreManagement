package action;

import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistAction extends Action {

    @Override
    public String execute(
            HttpServletRequest req,
            HttpServletResponse res
    ) throws Exception {

    	
    	HttpSession session =
    		    req.getSession();

    		TeacherBean loginUser =
    		    (TeacherBean)
    		    session.getAttribute(
    		        "loginUser"
    		    );

    		SubjectDAO dao =
    		    new SubjectDAO();

    		req.setAttribute(
    		    "subjectList",
    		    dao.filter(
    		        loginUser
    		            .getSchool()
    		            .getCd()
    		    )
    		);
    	
    	
    	
        return "/WEB-INF/view/test/test-regist.jsp";
    }
}