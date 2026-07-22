package action;

import bean.ErrorPostBean;
import bean.TeacherBean;
import dao.ErrorPostDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ErrorPostCreateExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        // ==========================================
        // ログイン確認
        // ==========================================

        HttpSession session = request.getSession();

        TeacherBean loginUser =
                (TeacherBean) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "/login/login.jsp";
        }


        // ==========================================
        // フォームから入力値を取得
        // ==========================================

        String subjectCd =
                request.getParameter("subjectCd");

        String title =
                request.getParameter("title");

        String content =
                request.getParameter("content");

        String solution =
                request.getParameter("solution");


        // ==========================================
        // ErrorPostBeanを作成
        // ==========================================

        ErrorPostBean errorPost =
                new ErrorPostBean();

        // 学校コード
        errorPost.setSchoolCd(
                loginUser.getSchool().getCd()
        );

        errorPost.setSubjectCd(subjectCd);
        errorPost.setTitle(title);
        errorPost.setContent(content);
        errorPost.setSolution(solution);


        // ==========================================
        // DBに登録
        // ==========================================

        ErrorPostDao errorPostDAO =
                new ErrorPostDao();

        errorPostDAO.insert(errorPost);


        // ==========================================
        // エラー一覧画面へ戻る
        // 科目コードは渡さない
        // ==========================================

        response.sendRedirect(
        	    request.getContextPath() + "/action/ErrorList.action"
        	);

        	return null;
    }
}