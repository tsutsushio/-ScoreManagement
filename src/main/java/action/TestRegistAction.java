package action;

import java.util.List;

import bean.TeacherBean;
import bean.TestBean;
import dao.ClassNumDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;
// 【修正】間違ったUtilインポートを削除し、自作のUtilをインポートする
import util.Util;

public class TestRegistAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 1. 自作のUtilクラスを使用してログインユーザーを取得
        Util util = new Util();
        TeacherBean teacher = util.getUser(request);

        // 未ログインチェック
        if (teacher == null) {
            return "/login/login.jsp";
        }

        // 2. 画面表示に必要なデータをセット（シーケンス図の初期表示準備）
        this.setRequestData(request, response);

        // パラメータ取得
        String studentNo = request.getParameter("student_no");
        String subjectCd = request.getParameter("subject_cd");
        String noStr = request.getParameter("no");
        String pointStr = request.getParameter("point");

        // 3. 初回表示（検索前）はチェックを行わずJSPへ
        if (studentNo == null) {
            return "/test/test_regist.jsp";
        }

        // 入力値の保持（入力ミスで戻った時に消えないようにする）
        request.setAttribute("student_no", studentNo);
        request.setAttribute("subject_cd", subjectCd);
        request.setAttribute("no", noStr);
        request.setAttribute("point", pointStr);

        // 4. バリデーション
        if (studentNo.isBlank() || subjectCd.isBlank() || noStr.isBlank() || pointStr.isBlank()) {
            request.setAttribute("errorMessage", "未入力の項目があります。");
            return "/test/test_regist.jsp";
        }

        int no;
        int point;
        try {
            no = Integer.parseInt(noStr);
            point = Integer.parseInt(pointStr);
            
            // シーケンス図にある「0〜100の範囲チェック」
            if (point < 0 || point > 100) {
                request.setAttribute("errorMessage", "点数は0〜100の範囲で入力してください。");
                return "/test/test_regist.jsp";
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "数字を正しく入力してください。");
            return "/test/test_regist.jsp";
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
        
        // 登録実行（戻り値がbooleanであることを確認してください）
        boolean result = testDao.save(test);

        if (!result) {
            request.setAttribute("errorMessage", "登録に失敗しました。");
            return "/test/test_regist.jsp";
        }

        // 登録成功時は一覧へ
        return "TestList.action";
    }

    /**
     * 画面表示に必要なマスタデータをリクエストにセットする
     */
    private void setRequestData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Util util = new Util();
        
        // 自作Utilのメソッドを呼び出す
        util.setEntYearSet(request);    // 入学年度セット
        util.setSubjects(request);      // 科目セット
        util.setNumSet(request);        // 回数セット
        
        // クラス番号（ClassNum）のセット
        TeacherBean teacher = util.getUser(request);
        ClassNumDAO classNumDao = new ClassNumDAO();
        // 学校(SchoolBean)を引数に渡す
        List<String> classNumList = classNumDao.filter(teacher.getSchool());
        request.setAttribute("class_num_set", classNumList);
    }
}