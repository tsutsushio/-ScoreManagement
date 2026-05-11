import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.Subject;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;

/**
 * TestDaoクラス
 * Testテーブルに対するデータベース操作を担当します
 */
public class TestDAO extends DAO {

    // クラス図にあるベースとなるSQL文
    private String baseSql = "SELECT * FROM TEST WHERE school_cd = ?";

    /**
     * 学生、科目、学校、回数を条件に単一のTestデータを取得する
     */
    public Test get(StudentBean student, SubjectBean subject, SchoolBean school, int no) throws SQLException {
        String sql = baseSql + " AND student_no = ? AND subject_cd = ? AND no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, school.getCd());
            st.setString(2, student.getNo());
            st.setString(3, subject.getCd());
            st.setInt(4, no);

            ResultSet rs = st.executeQuery();
            List<Test> list = postFilter(rs, school);
            return list.isEmpty() ? null : list.get(0);
        }
    }

    /**
     * ResultSetからTestオブジェクトのリストへ変換する（事後フィルタリング）
     */
    private List<Test> postFilter(ResultSet rs, School school) throws SQLException {
        List<Test> list = new ArrayList<>();
        while (rs.next()) {
            Test test = new Test();
            // ResultSetから値をセット（実装詳細は各Entityに依存）
            test.setNo(rs.getInt("no"));
            test.setPoint(rs.getInt("point"));
            // 関連オブジェクトのセット（簡略化）
            test.setSchool(school);
            list.add(test);
        }
        return list;
    }

    /**
     * 入学年度、クラス番号、科目、学校を条件にTestリストを取得する
     */
    public List<Test> filter(int entYear, String classNum, Subject subject, int num, School school) throws SQLException {
        // 複雑な結合SQL、またはResultSet取得後のロジックをここに記述
        List<Test> results = new ArrayList<>();
        // ... SQL実行とpostFilterの呼び出し ...
        return results;
    }

    /**
     * Testリストを保存する
     */
    public boolean save(List<Test> list) throws SQLException {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false); // トランザクション開始
            try {
                for (Test test : list) {
                    save(test, con);
                }
                con.commit();
                return true;
            } catch (Exception e) {
                con.rollback();
                return false;
            }
        }
    }

    /**
     * 単一のTestを保存する（同一コネクション内での実行用）
     */
    public boolean save(Test test, Connection connection) throws SQLException {
        String sql = "INSERT INTO TEST (student_no, subject_cd, school_cd, no, point) " +
                     "VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE point = VALUES(point)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, test.getStudent().getNo());
            st.setString(2, test.getSubject().getCd());
            st.setString(3, test.getSchool().getCd());
            st.setInt(4, test.getNo());
            st.setInt(5, test.getPoint());
            return st.executeUpdate() > 0;
        }
    }

    /**
     * Testリストを削除する
     */
    public boolean delete(List<Test> list) throws SQLException {
        // リストをループして削除、または一括削除
        return true; 
    }
}