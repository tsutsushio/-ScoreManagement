package action;

import java.util.Enumeration;

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

        // ログイン情報
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

        TestDAO dao =
                new TestDAO();

        // フォーム全体取得
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

            // point_で始まるものだけ対象
            if (
                paramName.startsWith(
                    "point_"
                )
            ) {

                // 学生番号取得
                String studentNo =
                    paramName.replace(
                        "point_",
                        ""
                    );

                String pointStr =
                    req.getParameter(
                        paramName
                    );

                // 空欄ならスキップ
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

                // hidden値取得
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

                // Bean作成
                TestBean test =
                    new TestBean();

                test.setStudentNo(
                    studentNo
                );

                test.setSubjectCd(
                    subjectCd
                );

                test.setSchoolCd(
                    schoolCd
                );

                test.setNo(no);

                test.setPoint(
                    point
                );

                test.setClassNum(
                    classNum
                );

                // 既存なら更新
                boolean exists =
                    dao.exists(
                        studentNo,
                        subjectCd,
                        schoolCd,
                        no
                    );

                if (exists) {

                    dao.update(
                        test
                    );

                } else {

                    dao.save(
                        test
                    );
                }
            }
        }

        return
            "/WEB-INF/view/test/test-regist-done.jsp";
    }
}