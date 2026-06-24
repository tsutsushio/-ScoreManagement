package action;

import java.time.Year;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

public class TestRegistExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "/login/login.jsp";
        }

        SchoolBean school = loginUser.getSchool();
        TestDAO dao = new TestDAO();
        List<TestBean> list = new ArrayList<>();
        Map<String, String> errors = new HashMap<>();

        // 🌟【修正】新しいhiddenパラメータ（f2, f3, f4）から取得
        String classNum = req.getParameter("f2");
        String subjectCd = req.getParameter("f3");
        String noStr = req.getParameter("f4");

        int no = 0;
        if (noStr != null && !noStr.isEmpty()) {
            no = Integer.parseInt(noStr);
        }

        Enumeration<String> parameterNames = req.getParameterNames();

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();

            if (paramName.startsWith("point_")) {
                String studentNo = paramName.replace("point_", "");
                String pointStr = req.getParameter(paramName);

                // 🌟 要件定義：「空っぽOK」
                if (pointStr == null || pointStr.trim().isEmpty()) {
                    continue;
                }

                int point = 0;
                try {
                    point = Integer.parseInt(pointStr);
                    
                    // 🌟 要件定義：「入力する場合は0〜100のみ有効、それ以外はエラーメッセージ」
                    if (point < 0 || point > 100) {
                        errors.put("point", "点数は0〜100の範囲内で入力してください。");
                        break;
                    }
                } catch (NumberFormatException e) {
                    // 🌟 要件定義：有効でない入力へのエラーハンドリング
                    errors.put("point", "点数は半角数字で入力してください。");
                    break;
                }

                // Bean生成とマッピング
                StudentBean student = new StudentBean();
                student.setNo(studentNo);

                SubjectBean subject = new SubjectBean();
                subject.setCd(subjectCd);

                TestBean test = new TestBean();
                test.setStudent(student);
                test.setSubject(subject);
                test.setSchool(school);
                test.setNo(no);
                test.setPoint(point);
                test.setClassNum(classNum);

                list.add(test);
            }
        }

        // バリデーションエラー時はリストを再構築して画面を復旧させる
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            restoreSearchContext(req, school.getCd(), classNum, subjectCd, no, list);
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // DAOへの保存
        try {
            dao.save(list);
        } catch (Exception e) {
            errors.put("point", e.getMessage());
            req.setAttribute("errors", errors);
            restoreSearchContext(req, school.getCd(), classNum, subjectCd, no, list);
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        return "/WEB-INF/view/test/test-regist-done.jsp";
    }
    
    /**
     * エラー発生時に、JSPの一覧テーブルやセレクトボックス、科目名を完全に復旧させるメソッド
     */
    private void restoreSearchContext(HttpServletRequest req, String schoolCd, String classNum, String subjectCd, int no, List<TestBean> currentList) throws Exception {
        SubjectDAO subjectDAO = new SubjectDAO();
        req.setAttribute("subjectList", subjectDAO.filter(schoolCd));

        String subjectName = "";
        for (SubjectBean sub : subjectDAO.filter(schoolCd)) {
            if (sub.getCd().equals(subjectCd)) {
                subjectName = sub.getName();
                break;
            }
        }
        req.setAttribute("subjectName", subjectName);

        List<Integer> entYearList = new ArrayList<>();
        int currentYear = Year.now().getValue();
        for (int i = currentYear; i >= 2020; i--) {
            entYearList.add(i);
        }
        req.setAttribute("entYearList", entYearList);

        StudentDAO studentDAO = new StudentDAO();
        List<StudentBean> allStudentList = studentDAO.filter(schoolCd, 0, null, true);
        Set<String> classSet = new TreeSet<>();
        for (StudentBean student : allStudentList) {
            classSet.add(student.getClassNum());
        }
        req.setAttribute("classList", classSet);

        List<Integer> noList = new ArrayList<>();
        noList.add(1);
        noList.add(2);
        req.setAttribute("noList", noList);

        // 入力中のデータを保持してテーブルを再表示（学生マスターから不足情報を補完）
        if (currentList.isEmpty() && classNum != null) {
            // リストが空でエラーが起きた場合は、検索条件を元に空枠を再取得
            String f1 = req.getParameter("f1");
            int entYear = (f1 != null && !f1.isEmpty()) ? Integer.parseInt(f1) : 0;
            List<StudentBean> studentList = studentDAO.filter(schoolCd, entYear, classNum, true);
            for (StudentBean student : studentList) {
                TestBean test = new TestBean();
                test.setStudent(student);
                test.setClassNum(classNum);
                currentList.add(test);
            }
        } else {
            // すでに点数オブジェクトがある場合は学生オブジェクトのマスター情報を紐付け直す
            for (TestBean test : currentList) {
                StudentBean fullStudent = studentDAO.get(test.getStudent().getNo());
                if (fullStudent != null) {
                    test.setStudent(fullStudent);
                }
            }
        }

        req.setAttribute("testList", currentList);
        
        String f1 = req.getParameter("f1");
        req.setAttribute("fEntYear", (f1 != null && !f1.isEmpty()) ? Integer.parseInt(f1) : 0);
        req.setAttribute("fClassNum", classNum);
        req.setAttribute("fSubjectCd", subjectCd);
        req.setAttribute("fNo", no);
    }
}
