package action;

import bean.SubjectBean;
import bean.TeacherBean; // クラス名はこれで合っています
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 💡 修正：セッションの属性名を "loginUser" に変更します
        HttpSession session = request.getSession();
        TeacherBean teacher = (TeacherBean) session.getAttribute("loginUser"); 

        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // SubjectBean を使用
        SubjectBean subject = new SubjectBean();
        subject.setCd(cd);
        subject.setName(name);
        
        // セッションから取得した学校情報をセット
        if (teacher != null) {
            subject.setSchool(teacher.getSchool());
        } else {
            throw new Exception("セッションがタイムアウトしました。再度ログインしてください。");
        }

        SubjectDAO dao = new SubjectDAO();
        dao.update(subject);

        // 更新後の一覧を取得
        request.setAttribute("subjectList", dao.list());

        return "/subject/subject_list.jsp";
    }
}
