package action;

import bean.SubjectBean; // 科目情報を入れるBean（環境に合わせて変更してください）
import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectDeleteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログインユーザー取得
        HttpSession session = request.getSession();
        TeacherBean user = (TeacherBean) session.getAttribute("loginUser");

        if (user == null) {
            return "/login/login.jsp";
        }

        // 削除対象科目コード
        String cd = request.getParameter("cd");
        String schoolCd = user.getSchool().getCd();

        SubjectDAO dao = new SubjectDAO();
        
        // 【重要】画面に科目名（Javaプログラミング基礎など）を出すため、DBから1件取得する
        // ※ もし get メソッドの名前が異なる場合は、既存のDAOに合わせて変更してください
     // dao.get の引数を cd だけ（1つ）に変更します
        SubjectBean subject = dao.get(cd); 


        // 画面（JSP）に渡すデータをセット
        request.setAttribute("cd", cd);
        request.setAttribute("name", subject.getName()); // 科目名

        // 削除「確認」画面へ進む
        return "/subject/subject_delete.jsp";
    }
}
