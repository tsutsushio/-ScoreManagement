package action;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistAction
extends Action {
//	✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️

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

        String schoolCd =
                loginUser
                .getSchool()
                .getCd();

        // ========= 科目一覧 =========
        SubjectDAO subjectDAO =
                new SubjectDAO();

        req.setAttribute(
                "subjectList",
                subjectDAO.filter(
                        schoolCd
                )
        );

        // ========= 入学年度 =========
        List<Integer>
            entYearList =
                new ArrayList<>();

        int currentYear =
                Year.now()
                .getValue();

        for (
            int i = currentYear;
            i >= 2020;
            i--
        ) {
            entYearList.add(i);
        }

        req.setAttribute(
                "entYearList",
                entYearList
        );

        // ========= クラス一覧 =========
        StudentDAO studentDAO =
                new StudentDAO();

        List<StudentBean>
        studentList =
            studentDAO.filter(
                    schoolCd,
                    0,
                    null,
                    true
            );

        Set<String>
            classSet =
                new TreeSet<>();

        for (
            StudentBean student
            : studentList
        ) {

            classSet.add(
                student.getClassNum()
            );
        }

        req.setAttribute(
                "classList",
                classSet
        );

        return
            "/WEB-INF/view/test/test-regist.jsp";
    }
}