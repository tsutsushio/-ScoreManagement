package action;

import java.util.List;

import javax.security.auth.Subject;

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

        // 科目一覧を取得
        List<Subject> subjectList = dao.list();

        // JSPへ渡す
        request.setAttribute("subjectList", subjectList);

        // 一覧画面へ
        return "/subject/subject_list.jsp";
    }
}
