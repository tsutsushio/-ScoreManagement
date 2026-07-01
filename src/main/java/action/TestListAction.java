package action;

import java.time.Year;
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

            // 🌟【要件】科目情報を選択保持し、学生側の検索条件（f4）はクリアして画面に返す
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
                
                // 🌟【確認完了】DAOに実在するオーバーロードされたメソッドを呼び出す
                // DAOが内部で自動的に横並び（point1, point2）にマージしたリストを返してくれます
                List<TestBean> testList = dao.searchBySubject(Integer.parseInt(entYear), classNum, subjectCd, null, school);

                if (testList.isEmpty()) {
                    req.setAttribute("message", "成績情報が存在しませんでした");
                } else {
                    req.setAttribute("testList", testList);

                    // 画面表示用の科目名を取得
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

            // 🌟【要件】学生情報を保持し、科目側の検索条件（f1〜f3）はクリアして画面に返す
            req.setAttribute("f1", "");
            req.setAttribute("f2", "");
            req.setAttribute("f3", "");
            req.setAttribute("f4", studentNo);

            if (studentNo == null || studentNo.isEmpty()) {
            	req.setAttribute("inputError", "学生番号を入力してください");
            	} else {
                StudentDAO studentDao = new StudentDAO();
                TestDAO testDao = new TestDAO();

                // 🌟【確認完了】DAOに実在する「searchByStudent」を正しく呼び出す
                List<TestBean> testList = testDao.searchByStudent(studentNo, school);

                if (testList.isEmpty()) {
                	req.setAttribute("message", "成績情報が存在しませんでした");
                	} else {
                    req.setAttribute("testList", testList);
                    req.setAttribute("student", studentDao.get(studentNo));
                }
            }
        }

        return "/WEB-INF/view/test/test-list.jsp";
    }
}
