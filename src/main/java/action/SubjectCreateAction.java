
package action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectCreateAction extends Action {

    @Override
    public String execute(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // 初回表示用なので特に処理はしない
        // 必要なら初期値を request に設定する

        return "/subject/subjectcreate.jsp";
    }
}
