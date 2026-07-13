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
        String password = req.getParameter( "password");

        int entYear = 0;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }

        Map<String, String> errors = new HashMap<>();

        // 🌟 3. 入力値のチェック（バリデーション）
        if (entYear == 0) {
            errors.put("entYear", "入学年度を選択してください");
        }
        
        // 学生番号のチェック（未入力 ＋ 10文字オーバー）
        if (no == null || no.isEmpty()) {
            errors.put("no", "学生番号を入力してください");
        } else if (no.length() > 10) {
            errors.put("no", "学生番号は10文字以内で入力してください");
        }
        
        // 氏名のチェック（未入力 ＋ 10文字オーバー）
        if (name == null || name.isEmpty()) {
            errors.put("name", "氏名を入力してください");
        } else if (name.length() > 10) {
            errors.put("name", "氏名は10文字以内で入力してください");
        }
        
        if (password == null || password.isEmpty()) {
            errors.put("password", "パスワードを入力してください");
        }
        
        StudentDAO dao = new StudentDAO();

        // 未入力や文字数エラーがない場合のみ、学生番号の重複チェックを行う
        if (errors.isEmpty()) {
            StudentBean existingStudent = dao.get(no);
            if (existingStudent != null) {
                errors.put("no", "学生番号が重複しています");
            }
        }

        // 4. エラーがあった場合は、登録画面に戻す
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("entYear", entYearStr);
            req.setAttribute("no", no);
            req.setAttribute("name", name);
            req.setAttribute("classNum", classNum);
            req.setAttribute("password", password);
            setDropdownLists(req);
            
            return "/WEB-INF/view/student/student_create.jsp";
        }

        // 5. エラーがない場合、StudentBeanにデータを詰めてDBに保存
        StudentBean student = new StudentBean();
        student.setEntYear(entYear);
        student.setNo(no);
        student.setName(name);
        student.setClassNum(classNum);
        student.setIsAttend(true);
        student.setSchool(loginUser.getSchool());
        student.setPassword(password);

        try {
            dao.save(student);
        } catch (Exception e) {
            // DAOで想定外のDBエラーが起きた場合は、学生番号の下にエラーを出す
            errors.put("no", e.getMessage()); 
            
            req.setAttribute("errors", errors);
            req.setAttribute("entYear", entYearStr);
            req.setAttribute("no", no);
            req.setAttribute("name", name);
            req.setAttribute("classNum", classNum);
            req.setAttribute("password", password);
            setDropdownLists(req);
            
            return "/WEB-INF/view/student/student_create.jsp";
        }

        return "/WEB-INF/view/student/student_create_done.jsp";
    }

    private void setDropdownLists(HttpServletRequest req) {
        int currentYear = LocalDate.now().getYear();
        List<Integer> entYearList = new ArrayList<>();
        for (int i = currentYear - 10; i <= currentYear + 10; i++) {
            entYearList.add(i);
        }
        List<String> classList = new ArrayList<>();
        classList.add("101");
        classList.add("201");
        req.setAttribute("entYearList", entYearList);
        req.setAttribute("classList", classList);
    }
}