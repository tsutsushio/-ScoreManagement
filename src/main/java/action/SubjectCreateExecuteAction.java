package action;

import bean.SubjectBean;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 文字コード設定
        request.setCharacterEncoding("UTF-8");

        // フォームから入力値を取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 入力値をJSPに戻すために保持
        request.setAttribute("cd", cd);
        request.setAttribute("name", name);

        // 未入力チェック
        if (cd == null || cd.isBlank()
                || name == null || name.isBlank()) {

            request.setAttribute("errorMessage",
                    "科目コードと科目名を入力してください。");

            return "/WEB-INF/view/subject/subject-create.jsp";
        }

        // DAO生成
        SubjectDAO dao = new SubjectDAO();

        // 重複チェック
        SubjectBean exists = dao.get(cd);

        if (exists != null) {
            request.setAttribute("errorMessage",
                    "その科目コードは既に登録されています。");

            return "/WEB-INF/view/subject/subject-create.jsp";
        }

        // SubjectBean作成
        SubjectBean subject = new SubjectBean();
        subject.setCd(cd);
        subject.setName(name);

        // 登録実行
        dao.insert(subject);

        // 登録成功メッセージ
        request.setAttribute("successMessage",
                "科目を登録しました。");

        // 科目一覧画面へ遷移
        return "SubjectList.action";
    }
}