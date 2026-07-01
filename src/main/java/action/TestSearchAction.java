package action;

import java.util.ArrayList;
import java.util.List;

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

     // ---（前略：パラメータのパース処理まで）---
        int no = 0;
        if (noStr != null && !noStr.isEmpty()) {
            no = Integer.parseInt(noStr);
        }

        StudentDAO studentDAO = new StudentDAO();
        TestDAO testDAO = new TestDAO();
        List<TestBean> testList = null; // 🌟 初期値を「null」に変更（未検索と検索結果0件を区別するため）
        String subjectName = "";

        // 🌟【追加】エラーメッセージ格納用のMapを用意
        java.util.Map<String, String> errors = new java.util.HashMap<>();

        // 検索条件が揃っている場合のみ実行
        if (entYear > 0 && classNum != null && !classNum.isEmpty() && subjectCd != null && !subjectCd.isEmpty() && no > 0) {
            
            testList = new ArrayList<>(); // 検索条件が揃ったらリストを生成
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

            SubjectDAO subjectDAO = new SubjectDAO();
            for (SubjectBean sub : subjectDAO.filter(schoolCd)) {
                if (sub.getCd().equals(subjectCd)) {
                    subjectName = sub.getName();
                    break;
                }
            }
        } else {
            // 🌟【追加】どれか一つでも未入力があった場合のエラー処理
            // ※最初に入発した初期表示（すべて未入力）の時はエラーを出さないように、
            // 「どれか一つでも入力されているが、足りない」または「リクエストが来ている」ときの判定にします。
            if (entYearStr != null || classNum != null || subjectCd != null || noStr != null) {
                errors.put("point", "クラス、科目、回数を選択してください。");
            }
        }

        // ---（中略：ドロップダウン再設定処理などはそのまま）---

        // 画面に渡すスコープ変数
        req.setAttribute("errors", errors); // 🌟【追加】エラーMapをJSPに渡す
        req.setAttribute("testList", testList);
        req.setAttribute("subjectName", subjectName);
        req.setAttribute("fEntYear", entYear == 0 ? "" : entYear); // 0のときは空文字にして選択を戻す
        req.setAttribute("fClassNum", classNum);
        req.setAttribute("fSubjectCd", subjectCd);
        req.setAttribute("fNo", no == 0 ? "" : no); // 0のときは空文字にして選択を戻す

        return "/WEB-INF/view/test/test-regist.jsp";

    }
}
