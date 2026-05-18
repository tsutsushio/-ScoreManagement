package action;

import java.util.ArrayList;
import java.util.List;

import bean.StudentBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestSearchAction
extends Action {

    @Override
    public String execute(
            HttpServletRequest req,
            HttpServletResponse res
    ) throws Exception {

        HttpSession session =
                req.getSession();

        TeacherBean loginUser =
                (TeacherBean)
                session.getAttribute(
                        "loginUser"
                );

        String schoolCd =
                loginUser
                .getSchool()
                .getCd();

        // 検索条件取得
        int entYear =
                Integer.parseInt(
                        req.getParameter(
                                "entYear"
                        )
                );

        String classNum =
                req.getParameter(
                        "classNum"
                );

        String subjectCd =
                req.getParameter(
                        "subjectCd"
                );

        int no =
                Integer.parseInt(
                        req.getParameter(
                                "no"
                        )
                );

        StudentDAO studentDAO =
                new StudentDAO();

        TestDAO testDAO =
                new TestDAO();

        // 学生一覧取得
        List<StudentBean>
            studentList =
                studentDAO.filter(
                        schoolCd,
                        entYear,
                        classNum,
                        true
                );

        List<TestBean>
            testList =
                new ArrayList<>();

        // 学生ごとに点数取得
        for (
            StudentBean student
            : studentList
        ) {

            TestBean test =
                    testDAO.get(
                            student.getNo(),
                            subjectCd,
                            schoolCd,
                            no
                    );

            // 点数未登録の場合
            if (test == null) {

                test =
                    new TestBean();

                test.setPoint(0);
            }

            test.setStudentNo(
                    student.getNo()
            );

            test.setStudentName(
                    student.getName()
            );

            test.setEntYear(
                    student.getEntYear()
            );

            test.setClassNum(
                    student.getClassNum()
            );

            test.setSubjectCd(
                    subjectCd
            );

            test.setSchoolCd(
                    schoolCd
            );

            test.setNo(no);

            testList.add(
                    test
            );
        }

        // 科目一覧再取得
        SubjectDAO subjectDAO =
                new SubjectDAO();

        req.setAttribute(
                "subjectList",
                subjectDAO.filter(
                        schoolCd
                )
        );

        // 検索結果
        req.setAttribute(
                "testList",
                testList
        );
        
     // 検索条件保持
        req.setAttribute(
                "fEntYear",
                entYear
        );

        req.setAttribute(
                "fClassNum",
                classNum
        );

        req.setAttribute(
                "fSubjectCd",
                subjectCd
        );

        req.setAttribute(
                "fNo",
                no
        );
        
        

        return
            "/WEB-INF/view/test/test-regist.jsp";
    }
}