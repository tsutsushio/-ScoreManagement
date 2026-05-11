package action;

import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.ClassNumDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        
        // 1. セッションからユーザー情報を取得
        TeacherBean teacher = (TeacherBean) session.getAttribute("user");
        
        // ★修正ポイント: teacherがnull（ログインしていない状態）ならログイン画面へ
        if (teacher == null) {
            return "/login/login.jsp";
        }

        // ここまで来れば、teacherは必ず存在するのでぬるぽになりません
        SchoolBean school = teacher.getSchool();

        String entYearStr = request.getParameter("f1");
        String classNum = request.getParameter("f2");
        String subjectCd = request.getParameter("f3");
        String numStr = request.getParameter("f4");

        ClassNumDAO cNumDAO = new ClassNumDAO();
        SubjectDAO subDAO = new SubjectDAO();
        TestDAO tDAO = new TestDAO();

        List<String> classNumList = cNumDAO.filter(school);
        List<SubjectBean> subjectList = subDAO.filter(school);

        request.setAttribute("class_num_set", classNumList);
        request.setAttribute("subject_set", subjectList);

        if (entYearStr != null && classNum != null && subjectCd != null && numStr != null) {
            try {
                int entYear = Integer.parseInt(entYearStr);
                int num = Integer.parseInt(numStr);
                
                SubjectBean subject = subDAO.get(subjectCd, school);
                List<TestBean> tests = tDAO.filter(entYear, classNum, subject, num, school);
                
                request.setAttribute("tests", tests);
            } catch (NumberFormatException e) {
                // 数値変換エラーが起きても止まらないように、必要に応じてログ出力など
            }
        }

        return "test_regist.jsp";
    }
}