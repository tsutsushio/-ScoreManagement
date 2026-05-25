package action;

import java.util.HashMap;
import java.util.Map;

import bean.StudentBean;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentPasswordEditExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        StudentBean loginStudent = (StudentBean) session.getAttribute("loginStudent");
        if (loginStudent == null) {
            return "/login/login.jsp";
        }

        // 2. 画面からの入力値を受け取る
        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();

        // 3. 入力チェック（バリデーション）
        // ① 現在のパスワードが正しいかチェック
        if (currentPassword == null || currentPassword.isEmpty()) {
            errors.put("currentPassword", "現在のパスワードを入力してください");
        } else if (!currentPassword.equals(loginStudent.getPassword())) {
            // セッションに持っている自分のパスワードと一致するか確認！
            errors.put("currentPassword", "現在のパスワードが間違っています");
        }

        // ② 新しいパスワードの入力チェック
        if (newPassword == null || newPassword.isEmpty()) {
            errors.put("newPassword", "新しいパスワードを入力してください");
        }

        // ③ 確認用パスワードが一致するかチェック
        if (confirmPassword == null || confirmPassword.isEmpty()) {
            errors.put("confirmPassword", "確認用のパスワードを入力してください");
        } else if (!confirmPassword.equals(newPassword)) {
            errors.put("confirmPassword", "新しいパスワードと確認用パスワードが一致しません");
        }

        // 4. エラーがある場合は、エラーメッセージを持って元の画面に戻す
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            return "/WEB-INF/view/student/student_password_edit.jsp";
        }

        // 5. エラーがなければ、StudentDAOを使ってパスワードを更新
        StudentDAO dao = new StudentDAO();
        boolean isSuccess = dao.updatePassword(loginStudent.getNo(), newPassword);

        if (isSuccess) {
            // 【超重要】DBの更新に成功したら、セッション(名札)のパスワードも最新に書き換えておく！
            loginStudent.setPassword(newPassword);
            session.setAttribute("loginStudent", loginStudent);
            
            // 6. 更新成功画面へ遷移
            return "/WEB-INF/view/student/student_password_edit_done.jsp";
        } else {
            // 万が一DBの更新に失敗した場合
            errors.put("system", "パスワードの更新に失敗しました。時間をおいて再度お試しください。");
            req.setAttribute("errors", errors);
            return "/WEB-INF/view/student/student_password_edit.jsp";
        }
    }
}