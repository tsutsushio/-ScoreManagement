package action;

import java.util.List;

import bean.ErrorPostBean;
import bean.SubjectBean;
import bean.TeacherBean;
import dao.ErrorPostDao;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ErrorListAction extends Action {

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
        // ログイン中の先生の学校コード
        // ==========================================

        String schoolCd =
                loginUser.getSchool().getCd();


        // ==========================================
        // 科目一覧を取得
        // ログインしている学校の科目だけ
        // ==========================================

        SubjectDAO subjectDAO =
                new SubjectDAO();

        List<SubjectBean> subjectList =
                subjectDAO.filter(schoolCd);


        // ==========================================
        // 検索条件を取得
        // ==========================================

        String subjectCd =
                request.getParameter("subjectCd");


        // ==========================================
        // エラー情報を取得
        // ==========================================

        ErrorPostDao errorPostDAO =
                new ErrorPostDao();

        List<ErrorPostBean> errorList;


        // 科目が指定されている場合
        if (subjectCd != null && !subjectCd.isEmpty()) {

            // 指定された科目だけ検索
            errorList =
                    errorPostDAO.filter(schoolCd, subjectCd);

        } else {

            // 科目が指定されていない場合
            // ログイン中の学校のエラーをすべて表示
            errorList =
                    errorPostDAO.list(schoolCd);
        }


        // ==========================================
        // JSPに渡す
        // ==========================================

        request.setAttribute(
                "subjectList",
                subjectList
        );

        request.setAttribute(
                "errorList",
                errorList
        );

        // 選択した科目を保持
        request.setAttribute(
                "selectedSubjectCd",
                subjectCd
        );


        return "/WEB-INF/view/error/error_list.jsp";
    }
}