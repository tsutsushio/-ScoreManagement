package action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

/**
 * 科目登録画面を表示するアクション
 */
public class SubjectCreateAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 初回表示用なので特に処理はしない
        // 必要に応じて request.setAttribute() で初期値を設定する

        // 科目登録画面へ遷移
        return "/WEB-INF/view/subject/subject-create.jsp";
    }
}