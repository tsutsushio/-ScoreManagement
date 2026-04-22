package action;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import bean.TeacherBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentCreateAction extends Action {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. ログインチェック
        HttpSession session = req.getSession();
        TeacherBean loginUser = (TeacherBean) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "/login/login.jsp"; 
        }

        // 2. セレクトボックス（ドロップダウン）用のデータを準備する
        // （シーケンス図：「セレクトボックス用のデータを取得」の該当箇所）
        
        // 【入学年度のリスト】
        // 現在の年から3年前までのリストを動的に作成します
        int currentYear = LocalDate.now().getYear();
        List<Integer> entYearList = new ArrayList<>();
        for (int i = currentYear - 3; i <= currentYear + 1; i++) {
            entYearList.add(i);
        }
        
        List<String> classList = new ArrayList<>();
        classList.add("101");
        classList.add("201");

        // 3. JSPへデータを渡す
        req.setAttribute("entYearList", entYearList);
        req.setAttribute("classList", classList);

        // 4. 学生登録画面へ遷移
        return "/WEB-INF/view/student/student-create.jsp";
    }
}