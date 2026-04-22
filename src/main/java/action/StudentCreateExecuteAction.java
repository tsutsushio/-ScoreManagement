package action;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.StudentBean;
import bean.TeacherBean;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentCreateExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null ) {
            return "/login/login.jsp"; 
        }

        // 2. 画面から入力されたデータを受け取る
        String entYearStr = req.getParameter("entYear");
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        String classNum = req.getParameter("classNum");

        int entYear = 0;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }

        // エラーメッセージを格納するためのMapを準備
        Map<String, String> errors = new HashMap<>();

        // 3. 入力値のチェック（バリデーション）※画像のエラー画面を再現
        if (entYear == 0) {
            errors.put("entYear", "入学年度を選択してください");
        }
        if (no == null || no.isEmpty()) {
            errors.put("no", "学生番号を入力してください");
        }
        if (name == null || name.isEmpty()) {
            errors.put("name", "氏名を入力してください");
        }
        
        StudentDAO dao = new StudentDAO();

        // 未入力エラーがない場合のみ、学生番号の重複チェックを行う
        if (errors.isEmpty()) {
            StudentBean existingStudent = dao.get(no);
            if (existingStudent != null) {
                // すでに同じ学生番号がDBに存在する場合
                errors.put("no", "学生番号が重複しています");
            }
        }

        // 4. エラーがあった場合は、登録画面（student_create.jsp）に戻す
        if (!errors.isEmpty()) {
            // エラーメッセージと、入力途中のデータをリクエストに保存
            req.setAttribute("errors", errors);
            req.setAttribute("entYear", entYearStr);
            req.setAttribute("no", no);
            req.setAttribute("name", name);
            req.setAttribute("classNum", classNum);
            
            // ドロップダウンのリストを再生成（StudentCreateActionと同じ処理）
            setDropdownLists(req);
            
            return "/WEB-INF/view/student/student-create.jsp";
        }

        // 5. エラーがない場合、StudentBeanにデータを詰めてDBに保存
        StudentBean student = new StudentBean();
        student.setEntYear(entYear);
        student.setNo(no);
        student.setName(name);
        student.setClassNum(classNum);
        student.setIsAttend(true); // 新規登録なので在学中(true)にする
        student.setSchool(loginUser.getSchool()); // 先生の学校コードをセット

        // クラス図にある save メソッドを呼び出す
        dao.save(student);

        // 6. 登録完了画面へ遷移
        return "/WEB-INF/view/student/student-create-done.jsp";
    }

    /**
     * エラーで元の画面に戻る際に、ドロップダウンのリストを再生成するヘルパーメソッド
     */
    private void setDropdownLists(HttpServletRequest req) {
        int currentYear = LocalDate.now().getYear();
        List<Integer> entYearList = new ArrayList<>();
        for (int i = currentYear - 10; i <= currentYear + 1; i++) {
            entYearList.add(i);
        }
        List<String> classList = new ArrayList<>();
        classList.add("101");
        classList.add("201");
        req.setAttribute("entYearList", entYearList);
        req.setAttribute("classList", classList);
    }
}