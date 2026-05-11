package action;

import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean; // SubjectBeanをインポート
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // 1. セッションからログインユーザーの学校情報を取得
        HttpSession session = req.getSession();
        SchoolBean school = (SchoolBean) session.getAttribute("user_school");

        // 2. SubjectDaoを使って、その学校の科目一覧を取得
        SubjectDao sDao = new SubjectDao();
        List<SubjectBean> subjects = sDao.filter(school);

        // 3. 取得したリストを「subjects」という名前でリクエストにセット
        // これでJSP側の ${subjects} で取り出せるようになります
        req.setAttribute("subjects", subjects);

        // 4. JSP（成績参照画面）へフォワード
        // パスはWEB-INFの構造に合わせて調整してください
        req.getRequestDispatcher("test_list.jsp").forward(req, res);
    }

    // クラス図にある残りのメソッド（中身は後で実装でもOK）
    private void setTestListSubject(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // 成績表示が必要になったらここに記述
    }

    private void setTestListStudent(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // 学生別表示が必要になったらここに記述
    }
}