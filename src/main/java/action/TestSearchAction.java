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
    public String execute(
            HttpServletRequest req,
            HttpServletResponse res
    ) throws Exception {

        HttpSession session =
                req.getSession();

        TeacherBean loginUser =
                (TeacherBean)
                session.getAttribute("loginUser");

        // ログイン確認
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        String schoolCd =
                loginUser.getSchool().getCd();

        // ========= 検索条件取得 =========
        int entYear =
                Integer.parseInt(req.getParameter("entYear"));

        String classNum =
                req.getParameter("classNum");

        String subjectCd =
                req.getParameter("subjectCd");

        int no =
                Integer.parseInt(req.getParameter("no"));

        StudentDAO studentDAO =
                new StudentDAO();

        TestDAO testDAO =
                new TestDAO();

        // ========= 学生一覧取得 =========
        List<StudentBean> studentList =
                studentDAO.filter(
                        schoolCd,
                        entYear,
                        classNum,
                        true
                );

        List<TestBean> testList =
                new ArrayList<>();

        // ========= 科目作成 =========
        SubjectBean subject =
                new SubjectBean();

        subject.setCd(
                subjectCd
        );

        // ========= 学校情報 =========
        SchoolBean school =
                loginUser
                .getSchool();

        // ========= 学生ごとに点数取得 =========
        for (StudentBean student : studentList) {

            // ★ TestDAOに合わせてBean化する
            StudentBean sBean = new StudentBean();
            sBean.setNo(student.getNo());

            SubjectBean subject_1 = new SubjectBean();
            subject.setCd(subjectCd);

            SchoolBean school_1 = new SchoolBean();
            school.setCd(schoolCd);

            TestBean test =
                    testDAO.get(
                            subject,
                            school,
                            no
                    );

            // 点数未登録の場合
            if (test == null) {
                test = new TestBean();
                test.setPoint(0);
            }
            // Beanセット
            test.setStudent(
                    student
            );

            test.setSubject(
                    subject
            );

            test.setSchool(
                    school
            );

            test.setClassNum(
                    student.getClassNum()
            );

            test.setNo(
                    no
            );

            testList.add(
                    test
            );
        }

        // ========= 科目一覧 =========
        SubjectDAO subjectDAO =
                new SubjectDAO();

        req.setAttribute(
                "subjectList",
                subjectDAO.filter(schoolCd)
        );

        // ========= 入学年度 =========
        List<Integer> entYearList =
                new ArrayList<>();

        int currentYear =
                Year.now().getValue();

        for (int i = currentYear; i >= 2020; i--) {
            entYearList.add(i);
        }

        req.setAttribute(
                "entYearList",
                entYearList
        );

        // ========= クラス一覧 =========
        List<StudentBean> allStudentList =
                studentDAO.filter(
                        schoolCd,
                        0,
                        null,
                        true
                );

        Set<String> classSet =
                new TreeSet<>();

        for (StudentBean student : allStudentList) {
            classSet.add(student.getClassNum());
        }

        req.setAttribute(
                "classList",
                classSet
        );

        // ========= 検索結果 =========
        req.setAttribute(
                "testList",
                testList
        );

        // ========= 検索条件保持 =========
        req.setAttribute("fEntYear", entYear);
        req.setAttribute("fClassNum", classNum);
        req.setAttribute("fSubjectCd", subjectCd);
        req.setAttribute("fNo", no);

        return "/WEB-INF/view/test/test-regist.jsp";
    }
}