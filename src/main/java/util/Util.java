package util;

import java.util.ArrayList;
import java.util.List;

// 【重要】javax.security.auth.Subject は削除し、自作の SubjectBean をインポートする
import bean.SubjectBean;
import bean.TeacherBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class Util {

    /**
     * セッションからログインユーザー情報を取得する
     */
    public TeacherBean getUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return (TeacherBean) session.getAttribute("loginUser");
    }

    /**
     * 入学年度のリストを生成してリクエストにセットする
     */
    public void setEntYearSet(HttpServletRequest request) {
        List<Integer> entYearSet = new ArrayList<>();
        int currentYear = java.time.Year.now().getValue();
        // 過去10年分程度をリスト化
        for (int i = currentYear - 10; i <= currentYear; i++) {
            entYearSet.add(i);
        }
        request.setAttribute("ent_year_set", entYearSet);
    }

    /**
     * 科目一覧をDBから取得してリクエストにセットする
     */
    public void setSubjects(HttpServletRequest request) throws Exception {
        TeacherBean teacher = getUser(request);
        if (teacher != null) {
            SubjectDAO subjectDao = new SubjectDAO();
            // 【修正箇所】型を SubjectBean に合わせ、static呼び出しではなくインスタンス経由にする
            List<SubjectBean> subjects = subjectDao.filter(teacher.getSchool());
            request.setAttribute("subjects", subjects);
        }
    }

    /**
     * 回数（1回, 2回...）のリストをリクエストにセットする
     */
    public void setNumSet(HttpServletRequest request) {
        List<Integer> numSet = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            numSet.add(i);
        }
        request.setAttribute("num_set", numSet);
    }
    
    /**
     * クラス図にあるメソッド：クラス番号セット
     */
    public void setClassNumSet(HttpServletRequest request) {
        // 必要に応じて、ClassNumDaoなどから取得するロジックをここに記述します
    }
}