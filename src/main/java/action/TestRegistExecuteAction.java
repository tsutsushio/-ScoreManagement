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
        
        // 🌟 エラーメッセージ格納用のMap
        Map<String, String> errors = new HashMap<>();

        Enumeration<String> parameterNames = req.getParameterNames();

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();

            if (paramName.startsWith("point_")) {
                String studentNo = paramName.replace("point_", "");
                String pointStr = req.getParameter(paramName);

                if (pointStr == null || pointStr.isEmpty()) {
                    continue;
                }

                int point = 0;
                // 🌟【例外処理 1】数字以外の文字が入力された場合のクラッシュを防ぐ
                try {
                    point = Integer.parseInt(pointStr);
                } catch (NumberFormatException e) {
                    errors.put("point", "点数は半角数字で入力してください。（対象学生: " + studentNo + "）");
                    break; // 1つでもエラーがあればループを抜ける
                }

                String subjectCd = req.getParameter("subjectCd");
                int no = Integer.parseInt(req.getParameter("no"));
                String classNum = req.getParameter("classNum");

                // ===== Bean生成 =====
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

        // 入力値（数字以外）のエラーがあった場合は元の画面に戻す
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            setDropdownLists(req, school.getCd()); // ドロップダウンを再準備
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // 🌟【例外処理 2】DAOでの保存処理（0〜100の範囲外チェック等）を受け止める
        try {
            dao.save(list);
        } catch (Exception e) {
            // DAOが投げた例外メッセージを取得して画面に返す
            errors.put("point", e.getMessage());
            req.setAttribute("errors", errors);
            setDropdownLists(req, school.getCd()); // ドロップダウンを再準備
            
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        return "/WEB-INF/view/test/test-regist-done.jsp";
    }
    
    /**
     * 🌟 エラーで元の画面に戻る際に、ドロップダウンのリストを再生成するヘルパーメソッド
     * （TestRegistAction と同じ処理を行い、画面の表示崩れを防ぐ）
     */
    private void setDropdownLists(HttpServletRequest req, String schoolCd) throws Exception {
        // 科目一覧
        SubjectDAO subjectDAO = new SubjectDAO();
        req.setAttribute("subjectList", subjectDAO.filter(schoolCd));

        // 入学年度
        List<Integer> entYearList = new ArrayList<>();
        int currentYear = Year.now().getValue();
        for (int i = currentYear; i >= 2020; i--) {
            entYearList.add(i);
        }
        req.setAttribute("entYearList", entYearList);

        // クラス一覧
        StudentDAO studentDAO = new StudentDAO();
        List<StudentBean> studentList = studentDAO.filter(schoolCd, 0, null, true);
        Set<String> classSet = new TreeSet<>();
        for (StudentBean student : studentList) {
            classSet.add(student.getClassNum());
        }
        req.setAttribute("classList", classSet);
    }
}