package action;

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

        // SubjectBean を使用
        SubjectBean subject = new SubjectBean();
        subject.setCd(cd);
        subject.setName(name);

        SubjectDAO dao = new SubjectDAO();
        dao.update(subject);

        // 更新後の一覧を取得
        request.setAttribute("subjectList", dao.list());

        return "/subject/subject_list.jsp";
    }
}