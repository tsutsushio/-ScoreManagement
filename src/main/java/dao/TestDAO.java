package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;
// Beanクラスのインポート
import bean.TestBean;

/**
 * TestDaoクラス
 * データベースのTestテーブルへのアクセスを担当します。
 */
public class TestDAO extends DAO {

    // クラス図にあるベースSQL
    private String baseSql = "SELECT * FROM TEST WHERE school_cd = ?";

    /**
     * 特定の成績データを1件取得します。
     */
    public TestBean get(StudentBean student, SubjectBean subject, SchoolBean school, int no) throws Exception {
        String sql = baseSql + " AND student_no = ? AND subject_cd = ? AND no = ?";
        
        // getConnection() が投げる例外を throws Exception で呼び出し元に丸投げします
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, school.getCd());
            st.setString(2, student.getNo());
            st.setString(3, subject.getCd());
            st.setInt(4, no);

            try (ResultSet rs = st.executeQuery()) {
                List<TestBean> list = postFilter(rs, school);
                if (!list.isEmpty()) {
                    return list.get(0);
                }
                return null;
            }
        }
    }

    /**
     * ResultSetからTestBeanのリストを作成します。
     */
    private List<TestBean> postFilter(ResultSet rs, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        while (rs.next()) {
            TestBean test = new TestBean();
            test.setNo(rs.getInt("no"));
            test.setPoint(rs.getInt("point"));
            test.setSchool(school);
            // 本来はここでstudent_no等を使ってStudentBeanをセットします
            list.add(test);
        }
        return list;
    }

    /**
     * 条件を指定して成績リストを取得します。
     */
    public List<TestBean> filter(int entYear, String classNum, SubjectBean subject, int num, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        // 検索ロジックの実装（SQLの組み立てなど）
        return list;
    }

    /**
     * 複数の成績データを一括保存します（トランザクション管理付き）。
     */
    public boolean save(List<TestBean> list) throws Exception {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false); // トランザクション開始
            try {
                for (TestBean test : list) {
                    save(test, con);
                }
                con.commit();
                return true;
            } catch (Exception e) {
                con.rollback(); // エラー時はロールバック
                throw e; // エラー内容を呼び出し元に伝える
            }
        }
    }

    /**
     * 1件の成績データを保存または更新します。
     */
    public boolean save(TestBean test, Connection connection) throws Exception {
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
     * 複数の成績データを一括削除します。
     */
    public boolean delete(List<TestBean> list) throws Exception {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try {
                for (TestBean test : list) {
                    delete(test, con);
                }
                con.commit();
                return true;
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
    }

    /**
     * 1件の成績データを削除します。
     */
    public boolean delete(TestBean test, Connection connection) throws Exception {
        String sql = "DELETE FROM TEST WHERE student_no = ? AND subject_cd = ? AND no = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, test.getStudent().getNo());
            st.setString(2, test.getSubject().getCd());
            st.setInt(3, test.getNo());
            return st.executeUpdate() > 0;
        }
    }
}