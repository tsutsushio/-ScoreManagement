package action;

import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SeatBean;
import bean.TeacherBean;
import bean.TestBean;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SeatShuffleAction extends Action {

    @Override
    public String execute(HttpServletRequest req,
            HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();

        TeacherBean loginUser =
                (TeacherBean) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "/login/login.jsp";
        }

        SchoolBean school = loginUser.getSchool();

        // パラメータ取得
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        String subjectCd = req.getParameter("subject");
        String testNoStr = req.getParameter("no");

        // 入力チェック
        if (entYearStr == null || entYearStr.isEmpty()
                || classNum == null || classNum.isEmpty()
                || subjectCd == null || subjectCd.isEmpty()
                || testNoStr == null || testNoStr.isEmpty()) {

            req.setAttribute("message", "すべての項目を選択してください。");

            // プルダウン用データを再取得して表示
            return new SeatListAction().execute(req, res);
        }

        int entYear = Integer.parseInt(entYearStr);
        int testNo = Integer.parseInt(testNoStr);

        TestDAO dao = new TestDAO();

        List<TestBean> scoreList =
                dao.getSeatScore(
                        entYear,
                        classNum,
                        subjectCd,
                        testNo,
                        school);

        // 総班数の計算 (1班4人)
        int groupCount =
                (int) Math.ceil((double) scoreList.size() / 4);

        List<SeatBean> seatList =
                shuffle(
                        scoreList,
                        classNum,
                        subjectCd,
                        testNo);

        // 席替え結果と班数をリクエストにセット
        req.setAttribute("seatList", seatList);
        req.setAttribute("groupCount", groupCount);

        // 選択された値をセット（JSP側で selected にしたい場合）
        req.setAttribute("entYear", entYear);
        req.setAttribute("classNum", classNum);
        req.setAttribute("subject", subjectCd);
        req.setAttribute("no", testNo);

        // ★ プルダウン用データ（subjectList, entYearList, classList, noList）をセットするために呼び出す
        new SeatListAction().execute(req, res);

        return "/WEB-INF/view/seat/seat.jsp";
    }

    /**
     * 実力均等席替え
     */
    private List<SeatBean> shuffle(
            List<TestBean> scoreList,
            String classNum,
            String subjectCd,
            int testNo) {

        List<SeatBean> result = new ArrayList<>();

        if (scoreList == null || scoreList.isEmpty()) {
            return result;
        }

        int groupSize = 4;
        int groupCount = (int) Math.ceil((double) scoreList.size() / groupSize);

        List<List<TestBean>> groups = new ArrayList<>();
        for (int i = 0; i < groupCount; i++) {
            groups.add(new ArrayList<>());
        }

        int index = 0;
        boolean reverse = false;

        for (TestBean test : scoreList) {
            groups.get(index).add(test);

            if (!reverse) {
                index++;
                if (index == groupCount) {
                    reverse = true;
                    index = groupCount - 1;
                }
            } else {
                index--;
                if (index < 0) {
                    reverse = false;
                    index = 0;
                }
            }
        }

        int baseCol = 1;
        int groupNo = 1;

        for (List<TestBean> group : groups) {
            for (int i = 0; i < group.size(); i++) {
                TestBean test = group.get(i);
                SeatBean seat = new SeatBean();

                seat.setClassNum(classNum);
                seat.setSubjectCd(subjectCd);
                seat.setTestNo(testNo);
                seat.setStudentNo(test.getStudent().getNo());
                seat.setStudentName(test.getStudent().getName());

                seat.setGroupNo(groupNo);
                seat.setPosition(i + 1);

                switch (i) {
                case 0:
                    seat.setRowNo(1);
                    seat.setColNo(baseCol);
                    break;
                case 1:
                    seat.setRowNo(2);
                    seat.setColNo(baseCol);
                    break;
                case 2:
                    seat.setRowNo(1);
                    seat.setColNo(baseCol + 1);
                    break;
                case 3:
                    seat.setRowNo(2);
                    seat.setColNo(baseCol + 1);
                    break;
                }

                result.add(seat);
            }

            baseCol += 2;
            groupNo++;
        }
        return result;
    }
}