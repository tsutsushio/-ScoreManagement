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

        // 💡 修正ポイント：エラーメッセージが「無い」場合のみ、DBから最新情報を取得する
        if (request.getAttribute("errorMessage") == null) {
            SubjectDAO dao = new SubjectDAO();
            SubjectBean subject = dao.get(cd);

            // 通常の遷移時は、DBから取得したデータをそのままセット
            request.setAttribute("subject", subject);
            
            // JSP側の ${cd} や ${name} としても扱えるように個別にセットしておくと安全です
            request.setAttribute("cd", subject.getCd());
            request.setAttribute("name", subject.getName());
        } else {
            // 💡 エラーで戻ってきた場合は、すでに SubjectUpdateExecuteAction で 
            // request.setAttribute("cd", cd); された値が残っているので、
            // JSPの ${subject.name} や ${subject.cd} が空にならないようにBeanに詰め直してセットします
            SubjectBean errorSubject = new SubjectBean();
            errorSubject.setCd((String) request.getAttribute("cd"));
            errorSubject.setName((String) request.getAttribute("name"));
            
            request.setAttribute("subject", errorSubject);
        }

        return "/subject/subject_update.jsp";
    }
}
