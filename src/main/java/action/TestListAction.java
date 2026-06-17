package action;

import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.ClassNumDAO;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction
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

        // 未ログイン対策
        if (loginUser == null) {

            return
                "/login/login.jsp";
        }

        SchoolBean school =
                loginUser.getSchool();

        // ===== プルダウン =====

        ClassNumDAO cDao =
                new ClassNumDAO();

        SubjectDAO sDao =
                new SubjectDAO();

        req.setAttribute(
                "classList",
                cDao.filter(
                    school
                )
        );

        req.setAttribute(
                "subjectList",
                sDao.filter(
                    school.getCd()
                )
        );

        // 入学年度（仮）
        List<Integer> yearList =
                new ArrayList<>();

        for (
            int i = 2020;
            i <= 2030;
            i++
        ) {

            yearList.add(i);
        }

        req.setAttribute(
                "yearList",
                yearList
        );

        // ===== 検索 =====

        String f =
                req.getParameter(
                    "f"
                );

        /* =========================
         * 科目検索
         * ========================= */
        if ("sj".equals(f)) {

            req.setAttribute(
                    "searchType",
                    "sj"
            );

            String entYear =
                    req.getParameter(
                        "f1"
                    );

            String classNum =
                    req.getParameter(
                        "f2"
                    );

            String subjectCd =
                    req.getParameter(
                        "f3"
                    );

            // 学生検索条件クリア
            req.setAttribute(
                    "f4",
                    ""
            );
            if (
                entYear == null
                || entYear.isEmpty()
                || classNum == null
                || classNum.isEmpty()
                || subjectCd == null
                || subjectCd.isEmpty()
            ) {

                req.setAttribute(
                        "error",
                        "科目情報を選択してください"
                );

            } else {

                TestDAO dao =
                        new TestDAO();

                List<TestBean>
                    testList =
                        dao.searchBySubject(
                                Integer.parseInt(
                                        entYear
                                ),
                                classNum,
                                subjectCd,
                                null,
                                school
                        );

                if (
                    testList.isEmpty()
                ) {

                    req.setAttribute(
                            "error",
                            "成績情報が存在しませんでした"
                    );

                } else {

                    req.setAttribute(
                            "testList",
                            testList
                    );
                    for (SubjectBean sub : sDao.filter(school.getCd())) {

                        if (
                            sub.getCd().equals(subjectCd)
                        ) {

                            req.setAttribute(
                                    "subjectName",
                                    sub.getName()
                            );

                            break;
                        }
                    }
                }
            }
        }

        /* =========================
         * 学生検索
         * ========================= */
        else if ("st".equals(f)) {

            req.setAttribute(
                    "searchType",
                    "st"
            );

            String studentNo =
                    req.getParameter(
                        "f4"
                    );

            // 科目条件クリア
            req.setAttribute(
                    "f1",
                    ""
            );

            req.setAttribute(
                    "f2",
                    ""
            );

            req.setAttribute(
                    "f3",
                    ""
            );

            if (
                studentNo == null
                || studentNo.isEmpty()
            ) {

                req.setAttribute(
                        "error",
                        "学生番号を入力してください"
                );

            } else {

                StudentDAO studentDao =
                        new StudentDAO();

                TestDAO testDao =
                        new TestDAO();

                List<TestBean> testList =
                        testDao.searchByStudent(
                                studentNo,
                                school
                        );

                if (
                    testList.isEmpty()
                ) {

                    req.setAttribute(
                            "error",
                            "成績情報が存在しませんでした"
                    );

                } else {

                    req.setAttribute(
                            "testList",
                            testList
                    );

                    req.setAttribute(
                            "student",
                            studentDao.get(
                                    studentNo
                            )
                    );
                }
            }
        }
        return
            "/WEB-INF/view/test/test-list.jsp";
    }
}