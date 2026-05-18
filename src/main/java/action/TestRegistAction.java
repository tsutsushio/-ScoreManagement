package action;

<<<<<<< HEAD
import java.util.List;

=======
import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import bean.StudentBean;
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
import bean.TeacherBean;
<<<<<<< HEAD
import bean.TestBean;
import dao.ClassNumDAO;
import dao.TestDAO;
=======
import dao.StudentDAO;
import dao.SubjectDAO;
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
import util.Util;

public class TestRegistAction
extends Action {
//	✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

<<<<<<< HEAD
        // 1. 自作のUtilクラスを使用してログインユーザーを取得
        Util util = new Util();
        TeacherBean teacher = util.getUser(request);
=======
        HttpSession session =
                req.getSession();
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

<<<<<<< HEAD
        // 未ログインチェック
        if (teacher == null) {
            return "/login/login.jsp";
        }
=======
        TeacherBean loginUser =
                (TeacherBean)
                session.getAttribute(
                        "loginUser"
                );
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

<<<<<<< HEAD
        // 2. 画面表示に必要なデータをセット（入学年度・科目・回数・クラス番号）
        this.setRequestData(request, response);
=======
        if (loginUser == null) {
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

<<<<<<< HEAD
        // パラメータ取得
        String studentNo = request.getParameter("student_no");
        String subjectCd = request.getParameter("subject_cd");
        String classNum = request.getParameter("class_num"); // クラス番号を追加
        String noStr = request.getParameter("no");
        String pointStr = request.getParameter("point");

        // 3. 初回表示（検索・入力前）はチェックを行わずJSPへ
        if (studentNo == null) {
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // 入力値の保持（エラーで画面に戻った際、入力内容が消えないようにする）
        request.setAttribute("student_no", studentNo);
        request.setAttribute("subject_cd", subjectCd);
        request.setAttribute("class_num", classNum);
        request.setAttribute("no", noStr);
        request.setAttribute("point", pointStr);

        // 4. バリデーション（必須入力チェック）
        if (studentNo.isBlank() || subjectCd.isBlank() || classNum == null || classNum.isBlank() || noStr.isBlank() || pointStr.isBlank()) {
            request.setAttribute("errorMessage", "未入力の項目があります。");
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        int no;
        int point;
        try {
            no = Integer.parseInt(noStr);
            point = Integer.parseInt(pointStr);
            
            // 点数の範囲チェック
            if (point < 0 || point > 100) {
                request.setAttribute("errorMessage", "点数は0〜100の範囲で入力してください。");
                return "/WEB-INF/view/test/test-regist.jsp";
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "数字を正しく入力してください。");
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // 5. 登録処理
        TestDAO testDao = new TestDAO();
        String schoolCd = teacher.getSchool().getCd();

        // 登録用Beanに値をセット
        TestBean test = new TestBean();
        test.setStudentNo(studentNo);
        test.setSubjectCd(subjectCd);
        test.setSchoolCd(schoolCd);
        test.setNo(no);
        test.setPoint(point);
        test.setClassNum(classNum); // データベース追加に伴うセットの追加
        
        // 登録実行
        boolean result = testDao.save(test);

        if (!result) {
            request.setAttribute("errorMessage", "登録に失敗しました。");
            return "/WEB-INF/view/test/test-regist.jsp";
        }

        // 登録成功時は一覧へ遷移
        return "TestList.action";
    }

    /**
     * 画面表示に必要なマスタデータをリクエストにセットする
     */
    private void setRequestData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Util util = new Util();
        
        // 自作Utilのメソッドを呼び出して選択肢をセット
        util.setEntYearSet(request);    // 入学年度セット
        util.setSubjects(request);      // 科目セット
        util.setNumSet(request);        // 回数セット
        
        // クラス番号（ClassNum）のセット
        TeacherBean teacher = util.getUser(request);
        ClassNumDAO classNumDao = new ClassNumDAO();
        
        // 学校(SchoolBean)を引数に渡して取得
        List<String> classNumList = classNumDao.filter(teacher.getSchool());
        request.setAttribute("class_num_set", classNumList);
=======
            return
                "/login/login.jsp";
        }

        String schoolCd =
                loginUser
                .getSchool()
                .getCd();

        // ========= 科目一覧 =========
        SubjectDAO subjectDAO =
                new SubjectDAO();

        req.setAttribute(
                "subjectList",
                subjectDAO.filter(
                        schoolCd
                )
        );

        // ========= 入学年度 =========
        List<Integer>
            entYearList =
                new ArrayList<>();

        int currentYear =
                Year.now()
                .getValue();

        for (
            int i = currentYear;
            i >= 2020;
            i--
        ) {
            entYearList.add(i);
        }

        req.setAttribute(
                "entYearList",
                entYearList
        );

        // ========= クラス一覧 =========
        StudentDAO studentDAO =
                new StudentDAO();

        List<StudentBean>
        studentList =
            studentDAO.filter(
                    schoolCd,
                    0,
                    null,
                    true
            );

        Set<String>
            classSet =
                new TreeSet<>();

        for (
            StudentBean student
            : studentList
        ) {

            classSet.add(
                student.getClassNum()
            );
        }

        req.setAttribute(
                "classList",
                classSet
        );

        return
            "/WEB-INF/view/test/test-regist.jsp";
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
    }
}