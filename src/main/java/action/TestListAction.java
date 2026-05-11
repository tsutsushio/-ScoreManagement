package action;

import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean;
import bean.TeacherBean; // 追加
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // 1. セッションからログインユーザー情報を取得
        HttpSession session = req.getSession();
        
        // 注意：LoginActionで保存したのが "user" (TeacherBean) なら
        TeacherBean teacher = (TeacherBean) session.getAttribute("user");
        
        // ぬるぽ対策：ログインしていなければログイン画面へ
        if (teacher == null) {
            return "/login/login.jsp";
        }
        
        // 先生の所属する学校を取得
        SchoolBean school = teacher.getSchool();

        // 2. SubjectDaoを使って、その学校の科目一覧を取得
        SubjectDAO sDao = new SubjectDAO();
        List<SubjectBean> subjects = sDao.filter(school);

        // 3. 取得したリストをリクエストにセット
        req.setAttribute("subjects", subjects);

        // 4. JSPのファイル名を返す (Actionクラスのルールに従う)
        // ※ tool.Action クラスの戻り値型に合わせて String を返します
        return "test_list.jsp";
    }

    // クラス図にある残りのメソッド
    private void setTestListSubject(HttpServletRequest req, HttpServletResponse res) throws Exception {
    }

    private void setTestListStudent(HttpServletRequest req, HttpServletResponse res) throws Exception {
    }
}