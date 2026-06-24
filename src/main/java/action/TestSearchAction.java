package action;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestSearchAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "/login/login.jsp";
        }

        String schoolCd = loginUser.getSchool().getCd();

        // 🌟【修正】要件定義のname属性（f1〜f4）から取得
        String entYearStr = req.getParameter("f1");
        String classNum = req.getParameter("f2");
        String subjectCd = req.getParameter("f3");
        String noStr = req.getParameter("f4");

        int entYear = 0;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }

        int no = 0;
        if (noStr != null && !noStr.isEmpty()) {
            no = Integer.parseInt(noStr);
        }

        StudentDAO studentDAO = new StudentDAO();
        TestDAO testDAO = new TestDAO();
        List<TestBean> testList = new ArrayList<>();
        String subjectName = "";

        // 検索条件が揃っている場合のみ実行
        if (entYear > 0 && classNum != null && !classNum.isEmpty() && subjectCd != null && !subjectCd.isEmpty() && no > 0) {
            
            List<StudentBean> studentList = studentDAO.filter(schoolCd, entYear, classNum, true);
            SubjectBean subject = new SubjectBean();
            subject.setCd(subjectCd);
            SchoolBean school = loginUser.getSchool();

            for (StudentBean student : studentList) {
                TestBean test = testDAO.get(student, subject, school, no);

                if (test == null) {
                    test = new TestBean();
                    test.setPoint(0);
                }

                test.setStudent(student);
                test.setSubject(subject);
                test.setSchool(school);
                test.setClassNum(student.getClassNum());
                test.setNo(no);

                testList.add(test);
            }

            // 🌟【追加】要件定義にある「科目名」の表示用データを取得
            SubjectDAO subjectDAO = new SubjectDAO();
            for (SubjectBean sub : subjectDAO.filter(schoolCd)) {
                if (sub.getCd().equals(subjectCd)) {
                    subjectName = sub.getName();
                    break;
                }
            }
        }

        // ドロップダウン再設定
        SubjectDAO subjectDAO = new SubjectDAO();
        req.setAttribute("subjectList", subjectDAO.filter(schoolCd));

        List<Integer> entYearList = new ArrayList<>();
        int currentYear = Year.now().getValue();
        for (int i = currentYear; i >= 2020; i--) {
            entYearList.add(i);
        }
        req.setAttribute("entYearList", entYearList);

        List<StudentBean> allStudentList = studentDAO.filter(schoolCd, 0, null, true);
        Set<String> classSet = new TreeSet<>();
        for (StudentBean student : allStudentList) {
            classSet.add(student.getClassNum());
        }
        req.setAttribute("classList", classSet);

        List<Integer> noList = new ArrayList<>();
        noList.add(1);
        noList.add(2);
        req.setAttribute("noList", noList);

        // 画面に渡すスコープ変数
        req.setAttribute("testList", testList);
        req.setAttribute("subjectName", subjectName); // 科目名表示用
        req.setAttribute("fEntYear", entYear);
        req.setAttribute("fClassNum", classNum);
        req.setAttribute("fSubjectCd", subjectCd);
        req.setAttribute("fNo", no);

        return "/WEB-INF/view/test/test-regist.jsp";
    }
}
