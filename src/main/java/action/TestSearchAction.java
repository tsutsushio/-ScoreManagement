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
        SubjectDAO subjectDAO = new SubjectDAO(); // 🌟 重複を避けるため、DAOのインスタンス化をここにまとめました
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

            // 🌟 修正：上部で宣言した subjectDAO をそのまま利用（再宣言を削除）
            for (SubjectBean sub : subjectDAO.filter(schoolCd)) {
                if (sub.getCd().equals(subjectCd)) {
                    subjectName = sub.getName();
                    break;
                }
            }
        } else {
            // 🌟【追加】どれか一つでも未入力があった場合のエラー処理
            if (entYearStr != null || classNum != null || subjectCd != null || noStr != null) {
                errors.put("point", "クラス、科目、回数を選択してください。");
            }
        }

        // 画面に渡すスコープ変数
        req.setAttribute("errors", errors);
        req.setAttribute("testList", testList);
        req.setAttribute("subjectName", subjectName);
     // 数値を文字列に変換して渡す（未選択なら空文字 ""）
        req.setAttribute("fEntYear", entYear == 0 ? "" : String.valueOf(entYear));

        req.setAttribute("fClassNum", classNum);
        req.setAttribute("fSubjectCd", subjectCd);
        req.setAttribute("fNo", no == 0 ? "" : no);

        // ====================================================================
        // ★ここを追加：検索後もプルダウンの選択肢（リスト）を維持するための再設定処理
        // ====================================================================
        // 1. 入学年度リスト
        java.util.List<Integer> entYearList = new java.util.ArrayList<>();
        int currentYear = java.time.LocalDate.now().getYear();
        for (int i = currentYear; i >= currentYear - 10; i--) {
            entYearList.add(i);
        }
        req.setAttribute("entYearList", entYearList);

        // 2. クラス番号リスト（ClassNumDAO を利用して取得）
        dao.ClassNumDAO classNumDAO = new dao.ClassNumDAO();
        // 引数に文字列ではなく、ログインユーザーの学校オブジェクト（SchoolBean）を渡します
        List<String> classList = classNumDAO.filter(loginUser.getSchool()); 
        req.setAttribute("classList", classList);



        // 3. 科目リスト（🌟 修正：すでにインスタンス化されている subjectDAO を利用）
        List<SubjectBean> subjectList = subjectDAO.filter(schoolCd);
        req.setAttribute("subjectList", subjectList);

        // 4. 回数リスト
        List<Integer> noList = new java.util.ArrayList<>();
        for (int i = 1; i <= 2; i++) {
            noList.add(i);
        }
        req.setAttribute("noList", noList);
        // ====================================================================

        return "/WEB-INF/view/test/test-regist.jsp";
    }
}
