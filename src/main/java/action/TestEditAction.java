package action;

import java.util.List;

import bean.StudentBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestEditAction extends Action {

    @Override
    public String execute(
            HttpServletRequest req,
            HttpServletResponse res
    ) throws Exception {

        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        String schoolCd = loginUser.getSchool().getCd();

        // 2. 🌟データベースから最新の科目一覧を動的に取得してセット
        SubjectDAO subjectDAO = new SubjectDAO();
        List<SubjectBean> subjectList = subjectDAO.filter(schoolCd);
        req.setAttribute("subjectList", subjectList);

        // 3. 変更対象データを特定するためのパラメータを取得（一覧からの遷移を想定）
        String studentNo = req.getParameter("studentNo");
        String subjectCd = req.getParameter("subjectCd");
        String noStr = req.getParameter("no");

        // パラメータが送られてきている場合は、DBから既存の成績データを取得して初期値としてセット
        if (studentNo != null && subjectCd != null && noStr != null) {
            try {
                int no = Integer.parseInt(noStr);

                StudentBean student = new StudentBean();
                student.setNo(studentNo);

                SubjectBean subject = new SubjectBean();
                subject.setCd(subjectCd);

                TestDAO testDao = new TestDAO();
                TestBean test = testDao.get(student, subject, loginUser.getSchool(), no);

                if (test != null) {
                    req.setAttribute("studentNo", studentNo);
                    req.setAttribute("subjectCd", subjectCd);
                    req.setAttribute("no", no);
                    req.setAttribute("point", test.getPoint());
                    req.setAttribute("classNum", test.getClassNum());
                }
            } catch (NumberFormatException e) {
                // 回数の数値変換に失敗した場合は初期値セットをスキップ
            }
        }

        // 4. 🌟正しいフォワード先（test-edit.jsp）へ遷移させる
        return "/WEB-INF/view/test/test-edit.jsp";
    }
}