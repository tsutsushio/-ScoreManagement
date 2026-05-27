package action;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.TestListStudentBean;
import dao.ClassNumDAO; // クラス一覧取得用DAO（未作成なら適宜読み替え）
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestListStudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        TeacherBean teacher = (TeacherBean) session.getAttribute("loginUser");
        SchoolBean school = teacher.getSchool();

        // 1. パラメータの取得
        String method = req.getParameter("method");

        // 2. 検索処理の分岐
        if ("subject".equals(method)) {
            setTestListSubject(req, res);
        } else if ("student".equals(method)) {
            setTestListStudent(req, res);
        }

        // --- シーケンス図前半：初期表示のためのデータ準備 ---
        
        // 入学年度リスト（現在から10年前まで）
        List<Integer> entYearSet = new ArrayList<>();
        int year = LocalDate.now().getYear();
        for (int i = year; i >= year - 10; i--) {
            entYearSet.add(i);
        }

        // クラス番号リスト
        ClassNumDAO cDao = new ClassNumDAO();
        List<String> classNumSet = cDao.filter(school);

        // 科目リスト
        SubjectDAO sDao = new SubjectDAO();
        List<SubjectBean> subjects = sDao.filter(school);

        // リクエスト属性にセットしてJSPへ送る
        req.setAttribute("ent_year_set", entYearSet);
        req.setAttribute("class_num_set", classNumSet);
        req.setAttribute("subjects", subjects);
        // ------------------------------------------------

        return "/WEB-INF/view/test/test_list.jsp";
    }

    public void setTestListSubject(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // 科目別成績の検索ロジックをここに実装
    }

    public void setTestListStudent(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String studentNo = req.getParameter("f4");
        StudentDAO sDao = new StudentDAO();
        TestListStudentDAO tStudentDao = new TestListStudentDAO();
        
        StudentBean student = sDao.get(studentNo);
        if (student != null) {
            List<TestListStudentBean> list = tStudentDao.filter(student);
            req.setAttribute("tests", list);
        }
    }
}