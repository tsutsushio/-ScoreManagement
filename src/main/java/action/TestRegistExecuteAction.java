package action;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistExecuteAction
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

        if (loginUser == null) {

            return
                "/login/login.jsp";
        }

        SchoolBean school =
                loginUser.getSchool();

        TestDAO dao =
                new TestDAO();

        List<TestBean> list =
                new ArrayList<>();

        Enumeration<String>
            parameterNames =
                req.getParameterNames();

        while (
            parameterNames
            .hasMoreElements()
        ) {

            String paramName =
                    parameterNames
                    .nextElement();

            if (
                paramName.startsWith(
                    "point_"
                )
            ) {

                String studentNo =
                    paramName.replace(
                        "point_",
                        ""
                    );

                String pointStr =
                    req.getParameter(
                        paramName
                    );

                if (
                    pointStr == null
                    ||
                    pointStr.isEmpty()
                ) {
                    continue;
                }

                int point =
                    Integer.parseInt(
                        pointStr
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

                String classNum =
                    req.getParameter(
                        "classNum"
                    );

                // ===== Bean生成 =====

                StudentBean student =
                        new StudentBean();

                student.setNo(
                        studentNo
                );

                SubjectBean subject =
                        new SubjectBean();

                subject.setCd(
                        subjectCd
                );

                TestBean test =
                        new TestBean();

                test.setStudent(
                        student
                );

                test.setSubject(
                        subject
                );

                test.setSchool(
                        school
                );

                test.setNo(
                        no
                );

                test.setPoint(
                        point
                );

                test.setClassNum(
                        classNum
                );

                list.add(
                        test
                );
            }
        }

        dao.save(list);

        return
            "/WEB-INF/view/test/test-regist-done.jsp";
    }
}