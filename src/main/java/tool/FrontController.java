package tool;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// すべてのリクエストを受け取る「司令塔」のボス
@WebServlet(urlPatterns={"*.action"})  
public class FrontController extends HttpServlet {

    public void doPost(
        HttpServletRequest request,
        HttpServletResponse response
    ) throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        try {
            // ③ URLパスを取得（例：/Search.action）
            String path = request.getServletPath().substring(1);

            // ④ クラス名に変換
            // 例：Search.action → SearchAction
            String name = path.replace(".a", "A").replace('/', '.');

            // ⑤ クラスを生成（リフレクション）
            Action action = (Action)Class.forName(name)
                .getDeclaredConstructor().newInstance();

            // ⑥ 処理を実行（Actionのexecute）
            String url = action.execute(request, response);

            // ⑦ JSPへフォワード
            request.getRequestDispatcher(url)
                .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }

    // GETリクエストもPOSTにまとめる

    public void doGet(
        HttpServletRequest request,
        HttpServletResponse response
    ) throws ServletException, IOException {

        doPost(request, response);
    }
}