package action;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean; // StudentBeanのインポートを追加してください
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

public class TestListAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");

        // 未ログイン対策
        if (loginUser == null) {
            return "/login/login.jsp";
        }

        SchoolBean school = loginUser.getSchool();

        // ===== プルダウン共通設定 =====
        ClassNumDAO cDao = new ClassNumDAO();
        SubjectDAO sDao = new SubjectDAO();

        req.setAttribute("classList", cDao.filter(school));
        req.setAttribute("subjectList", sDao.filter(school.getCd()));

        // 入学年度リスト（動的生成）
        List<Integer> yearList = new ArrayList<>();
        int currentYear = Year.now().getValue();
        for (int i = currentYear; i >= 2020; i--) {
            yearList.add(i);
        }
        req.setAttribute("yearList", yearList);

        // ===== 検索処理切り替え判定 =====
        String f = req.getParameter("f");

        /* =========================
         * 科目検索
         * ========================= */
        if ("sj".equals(f)) {
            req.setAttribute("searchType", "sj");

            String entYear = req.getParameter("f1");
            String classNum = req.getParameter("f2");
            String subjectCd = req.getParameter("f3");

            req.setAttribute("f1", entYear);
            req.setAttribute("f2", classNum);
            req.setAttribute("f3", subjectCd);
            req.setAttribute("f4", ""); // 学生番号クリア

            if (entYear == null || entYear.isEmpty() ||
                classNum == null || classNum.isEmpty() ||
                subjectCd == null || subjectCd.isEmpty()) {

                req.setAttribute("inputError", "入学年度とクラスと科目を選択してください");

            } else {
                TestDAO dao = new TestDAO();
                List<TestBean> testList = dao.searchBySubject(Integer.parseInt(entYear), classNum, subjectCd, null, school);

                if (testList.isEmpty()) {
                    req.setAttribute("message", "学生情報が存在しませんでした");
                } else {
                    req.setAttribute("testList", testList);

                    for (SubjectBean sub : sDao.filter(school.getCd())) {
                        if (sub.getCd().equals(subjectCd)) {
                            req.setAttribute("subjectName", sub.getName());
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
            req.setAttribute("searchType", "st");

            String studentNo = req.getParameter("f4");

            req.setAttribute("f1", "");
            req.setAttribute("f2", "");
            req.setAttribute("f3", "");
            req.setAttribute("f4", studentNo);

            if (studentNo == null || studentNo.isEmpty()) {
                req.setAttribute("inputError", "学生番号を入力してください");
            } else {
                StudentDAO studentDao = new StudentDAO();
                TestDAO testDao = new TestDAO();

                // 1. 学生が存在するか先に確認
                StudentBean student = studentDao.get(studentNo);
                
                if (student == null) {
                    // 学生が存在しない場合
                    req.setAttribute("message", "学生情報が存在しませんでした");
                } else {
                    // 2. 学生が存在する場合のみ成績検索
                    List<TestBean> testList = testDao.searchByStudent(studentNo, school);

                    if (testList.isEmpty()) {
                        req.setAttribute("message", "成績情報が存在しませんでした");
                    } else {
                        req.setAttribute("testList", testList);
                        req.setAttribute("student", student);
                    }
                }
            }
        }

        return "/WEB-INF/view/test/test-list.jsp";
    }
}