// ===============================
// TestRegistExecuteAction.java
// ===============================
package action;

import java.util.HashMap;
import java.util.Map;

import bean.StudentBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.StudentDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestEditExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest req,
            HttpServletResponse res
    ) throws Exception {

        // ログインチェック
        HttpSession session = req.getSession();

        TeacherBean loginUser =
            (TeacherBean) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "/login/login.jsp";
        }

        // パラメータ取得
        String studentNo = req.getParameter("studentNo");
        String subjectCd = req.getParameter("subjectCd");
        String noStr = req.getParameter("no");
        String pointStr = req.getParameter("point");
        String classNum = req.getParameter("classNum");

        int no = 0;
        int point = 0;

        Map<String, String> errors = new HashMap<>();

        // 回数(no)チェック
        if (noStr == null || noStr.isEmpty()) {

            errors.put("no", "回数を入力してください");

        } else {

            try {
                no = Integer.parseInt(noStr);

                if (no < 1) {
                    errors.put("no", "回数は1以上で入力してください");
                }

            } catch (Exception e) {
                errors.put("no", "回数は数字で入力してください");
            }
        }

        // 点数(point)チェック
        if (pointStr == null || pointStr.isEmpty()) {

            errors.put("point", "点数を入力してください");

        } else {

            try {
                point = Integer.parseInt(pointStr);

                if (point < 0 || point > 100) {
                    errors.put("point", "0〜100で入力してください");
                }

            } catch (Exception e) {
                errors.put("point", "点数は数字で入力してください");
            }
        }

        // 学生番号チェック
        if (studentNo == null || studentNo.isEmpty()) {
            errors.put("studentNo", "学生番号を入力してください");
        }

        // 科目チェック
        if (subjectCd == null || subjectCd.isEmpty()) {
            errors.put("subjectCd", "科目を選択してください");
        }

        // 学生存在チェック
        if (studentNo != null && !studentNo.isEmpty()) {

            StudentDAO studentDao = new StudentDAO();

            StudentBean student =
                studentDao.get(studentNo);

            if (student == null) {
                errors.put("studentNo", "存在しない学生です");
            }
        }

        // エラー時
        if (!errors.isEmpty()) {

            req.setAttribute("errors", errors);

            req.setAttribute("studentNo", studentNo);
            req.setAttribute("subjectCd", subjectCd);
            req.setAttribute("no", noStr);
            req.setAttribute("point", pointStr);
            req.setAttribute("classNum", classNum);

            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // Beanに詰める
        TestBean test = new TestBean();

        test.setStudentNo(studentNo);
        test.setSubjectCd(subjectCd);
        test.setSchoolCd(
            loginUser.getSchool().getCd()
        );
        test.setNo(no);
        test.setPoint(point);
        test.setClassNum(classNum);

        // 保存
        TestDAO dao = new TestDAO();
        dao.update(test);

        // 完了画面へ
        return "/WEB-INF/view/test/test-regist-done.jsp";
    }
}