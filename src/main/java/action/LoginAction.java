package action;

import bean.SchoolBean; // SchoolBeanのインポートが必要
import bean.TeacherBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. セッションを開始または取得
        HttpSession session = request.getSession();

        // 2. 学校オブジェクト(SchoolBean)を作成して値をセット
        SchoolBean school = new SchoolBean();
        // school.setName("テスト校"); // もしSchoolBeanに名前をセットするメソッドがあれば記述

        // 3. 先生オブジェクト(TeacherBean)を作成
        TeacherBean teacher = new TeacherBean();
        
        // ★ここでSchoolBeanオブジェクトをセット（Stringではなく型を合わせる）
        teacher.setSchool(school); 

        // 4. セッションに "user" という名前で保存
        // これで TestRegistAction の getAttribute("user") が null にならなくなります
        session.setAttribute("user", teacher);

        // 5. ログイン後の画面、またはログイン画面を表示
        return "/login/login.jsp"; 
    }
}