package action;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import bean.StudentBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.ClassNumDAO;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
import util.Util;

public class TestRegistAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // ログインユーザー取得
        Util util = new Util();
        TeacherBean teacher = util.getUser(request);

        // 未ログインチェック
        if (teacher == null) {
            return "/login/login.jsp";
        }

        // 画面表示用データセット
        setRequestData(request, response);

        // パラメータ取得
        String studentNo = request.getParameter("student_no");
        String subjectCd = request.getParameter("subject_cd");
        String classNum = request.getParameter("class_num");
        String noStr = request.getParameter("no");
        String pointStr = request.getParameter("point");

        // 初回表示
        if (studentNo == null) {
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // 入力保持
        request.setAttribute("student_no", studentNo);
        request.setAttribute("subject_cd", subjectCd);
        request.setAttribute("class_num", classNum);
        request.setAttribute("no", noStr);
        request.setAttribute("point", pointStr);

        // 必須チェック
        if (studentNo.isBlank()
                || subjectCd.isBlank()
                || classNum == null
                || classNum.isBlank()
                || noStr.isBlank()
                || pointStr.isBlank()) {

            request.setAttribute(
                    "errorMessage",
                    "未入力の項目があります。"
            );

            return "/WEB-INF/view/test/test-regist.jsp";
        }

        int no;
        int point;

        try {

            no = Integer.parseInt(noStr);
            point = Integer.parseInt(pointStr);

            // 点数範囲チェック
            if (point < 0 || point > 100) {

                request.setAttribute(
                        "errorMessage",
                        "点数は0〜100の範囲で入力してください。"
                );

                return "/WEB-INF/view/test/test-regist.jsp";
            }

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "errorMessage",
                    "数字を正しく入力してください。"
            );

            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // 登録処理
        TestDAO testDao = new TestDAO();

        String schoolCd =
                teacher.getSchool().getCd();

        TestBean test = new TestBean();

        test.setStudentNo(studentNo);
        test.setSubjectCd(subjectCd);
        test.setSchoolCd(schoolCd);
        test.setNo(no);
        test.setPoint(point);
        test.setClassNum(classNum);

        boolean result =
                testDao.save(test);

        if (!result) {

            request.setAttribute(
                    "errorMessage",
                    "登録に失敗しました。"
            );

            return "/WEB-INF/view/test/test-regist.jsp";
        }

        return "TestList.action";
    }

    /**
     * 画面表示用データ設定
     */
    private void setRequestData(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {

        Util util = new Util();

        TeacherBean teacher =
                util.getUser(request);

        String schoolCd =
                teacher.getSchool().getCd();

        // 科目一覧
        SubjectDAO subjectDAO =
                new SubjectDAO();

        request.setAttribute(
                "subjectList",
                subjectDAO.filter(schoolCd)
        );

        // 入学年度一覧
        List<Integer> entYearList =
                new ArrayList<>();

        int currentYear =
                Year.now().getValue();

        for (int i = currentYear;
                i >= 2020;
                i--) {

            entYearList.add(i);
        }

        request.setAttribute(
                "entYearList",
                entYearList
        );

        // クラス一覧
        StudentDAO studentDAO =
                new StudentDAO();

        List<StudentBean> studentList =
                studentDAO.filter(
                        schoolCd,
                        0,
                        null,
                        true
                );

        Set<String> classSet =
                new TreeSet<>();

        for (StudentBean student : studentList) {

            classSet.add(
                    student.getClassNum()
            );
        }

        request.setAttribute(
                "classList",
                classSet
        );

        // ClassNumDAO
        ClassNumDAO classNumDao =
                new ClassNumDAO();

        List<String> classNumList =
                classNumDao.filter(
                        teacher.getSchool()
                );

        request.setAttribute(
                "class_num_set",
                classNumList
        );
    }
}