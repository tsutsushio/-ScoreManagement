package action;

import bean.SubjectBean;
import bean.TeacherBean;
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

        HttpSession session = request.getSession();
        TeacherBean teacher = (TeacherBean) session.getAttribute("loginUser"); 

        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 💡 エラーで戻ったとき、画面の入力欄にこの値を残すためにセット
        request.setAttribute("cd", cd);
        request.setAttribute("name", name);

        SubjectBean subject = new SubjectBean();
        subject.setCd(cd);
        subject.setName(name);
        
        if (teacher != null) {
            subject.setSchool(teacher.getSchool());
        } else {
            throw new Exception("セッションがタイムアウトしました。再度ログインしてください。");
        }

        SubjectDAO dao = new SubjectDAO();

        try {
            // 登録・更新を実行
            dao.update(subject);
            
            // 成功したら一覧を取得して一覧画面へ
            request.setAttribute("subjectList", dao.list());
            return "/subject/subject_list.jsp";

        } catch (Exception e) {
            // 💡 エラーメッセージをリクエストに保存（JSPの ${errorMessage} に入ります）
            request.setAttribute("errorMessage", e.getMessage());
            
            // 🌟 修正ポイント：直接JSPに戻すのではなく、表示用のアクションを経由して戻す
            return "/action/SubjectUpdate.action"; 
        }
    }
}
