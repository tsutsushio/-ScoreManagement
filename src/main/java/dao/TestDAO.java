package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;
import bean.TestBean;

public class TestDAO extends DAO {

    private String baseSql = "SELECT * FROM TEST ";

    private List<TestBean> postFilter(ResultSet rSet, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        while (rSet.next()) {
            TestBean test = new TestBean();
            test.setNo(rSet.getInt("NO"));
            test.setPoint(rSet.getInt("POINT"));
            test.setClassNum(rSet.getString("CLASS_NUM"));

            // SchoolBeanのセット
            test.setSchool(school);

            // StudentBeanのセット（IDのみ）
            StudentBean student = new StudentBean();
            student.setNo(rSet.getString("STUDENT_NO"));
            test.setStudent(student);

            // SubjectBeanのセット（IDのみ）
            SubjectBean subject = new SubjectBean();
            subject.setCd(rSet.getString("SUBJECT_CD"));
            test.setSubject(subject);

            list.add(test);
        }
        return list;
    }

    public TestBean get(StudentBean student, SubjectBean subject, SchoolBean school, int no) throws Exception {
        TestBean test = null;
        String sql = baseSql + "WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, student.getNo());
            st.setString(2, subject.getCd());
            st.setString(3, school.getCd());
            st.setInt(4, no);

            try (ResultSet rs = st.executeQuery()) {
                List<TestBean> list = postFilter(rs, school);
                if (!list.isEmpty()) {
                    test = list.get(0);
                }
            }
        }
        return test;
    }

    public List<TestBean> filter(int entYear, String classNum, SubjectBean subject, int num, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        // ※このSQLはチームの仕様（絞り込み条件）に合わせて適宜WHERE句を組み立てます
        String sql = baseSql + "WHERE SCHOOL_CD = ?";
        
        // （例）科目と回数が指定されている場合の条件追加など
        if (subject != null && subject.getCd() != null) {
            sql += " AND SUBJECT_CD = '" + subject.getCd() + "'";
        }
        if (num > 0) {
            sql += " AND NO = " + num;
        }

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, school.getCd());
            try (ResultSet rs = st.executeQuery()) {
                list = postFilter(rs, school);
            }
        }
        return list;
    }

    public boolean save(List<TestBean> list) throws Exception {
        boolean isSuccess = true;
        try (Connection con = getConnection()) {
            // トランザクション開始（途中でエラーが出たらロールバックするため）
            con.setAutoCommit(false);
            try {
                for (TestBean test : list) {
                    if (!save(test, con)) {
                        isSuccess = false;
                        break;
                    }
                }
                if (isSuccess) {
                    con.commit(); // 全て成功したら確定
                } else {
                    con.rollback(); // 失敗したら元に戻す
                }
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
        return isSuccess;
    }

    private boolean save(TestBean test, Connection connection) throws Exception {
        boolean isSuccess = false;
        // 既存データの有無をチェック
        TestBean existingTest = get(test.getStudent(), test.getSubject(), test.getSchool(), test.getNo());
        String sql;

        if (existingTest == null) {
            // 新規登録
            sql = "INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) VALUES (?, ?, ?, ?, ?, ?)";
        } else {
            // 更新
            sql = "UPDATE TEST SET POINT = ?, CLASS_NUM = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        }

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (existingTest == null) {
                st.setString(1, test.getStudent().getNo());
                st.setString(2, test.getSubject().getCd());
                st.setString(3, test.getSchool().getCd());
                st.setInt(4, test.getNo());
                st.setInt(5, test.getPoint());
                st.setString(6, test.getClassNum());
            } else {
                st.setInt(1, test.getPoint());
                st.setString(2, test.getClassNum());
                st.setString(3, test.getStudent().getNo());
                st.setString(4, test.getSubject().getCd());
                st.setString(5, test.getSchool().getCd());
                st.setInt(6, test.getNo());
            }
            if (st.executeUpdate() > 0) {
                isSuccess = true;
            }
        }
        return isSuccess;
    }

    public boolean delete(List<TestBean> list) throws Exception {
        boolean isSuccess = true;
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try {
                for (TestBean test : list) {
                    if (!delete(test, con)) {
                        isSuccess = false;
                        break;
                    }
                }
                if (isSuccess) {
                    con.commit();
                } else {
                    con.rollback();
                }
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
        return isSuccess;
    }

    private boolean delete(TestBean test, Connection connection) throws Exception {
        boolean isSuccess = false;
        String sql = "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, test.getStudent().getNo());
            st.setString(2, test.getSubject().getCd());
            st.setString(3, test.getSchool().getCd());
            st.setInt(4, test.getNo());
            
            if (st.executeUpdate() > 0) {
                isSuccess = true;
            }
        }
        return isSuccess;
    }

    public List<TestBean> getLatestScores(String studentNo) throws Exception {
        List<TestBean> list = new ArrayList<>();
        String sql = "SELECT T.SUBJECT_CD, S.NAME AS SUBJECT_NAME, T.POINT, T.NO " +
                     "FROM TEST T " +
                     "JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
                     "WHERE T.STUDENT_NO = ? " +
                     "AND T.NO = (SELECT MAX(NO) FROM TEST WHERE STUDENT_NO = ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, studentNo);
            st.setString(2, studentNo);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TestBean test = new TestBean();
                    test.setPoint(rs.getInt("POINT"));
                    test.setNo(rs.getInt("NO"));
                    
                    SubjectBean subject = new SubjectBean();
                    subject.setCd(rs.getString("SUBJECT_CD"));
                    subject.setName(rs.getString("SUBJECT_NAME"));
                    test.setSubject(subject);
                    
                    list.add(test);
                }
            }
        }
        return list;
    }

    public List<TestBean> getAllScores(String studentNo) throws Exception {
        List<TestBean> list = new ArrayList<>();
        String sql = "SELECT T.NO, T.SUBJECT_CD, S.NAME AS SUBJECT_NAME, T.POINT " +
                     "FROM TEST T " +
                     "JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
                     "WHERE T.STUDENT_NO = ? " +
                     "ORDER BY T.NO DESC, T.SUBJECT_CD ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, studentNo);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TestBean test = new TestBean();
                    test.setNo(rs.getInt("NO"));
                    test.setPoint(rs.getInt("POINT"));
                    
                    SubjectBean subject = new SubjectBean();
                    subject.setCd(rs.getString("SUBJECT_CD"));
                    subject.setName(rs.getString("SUBJECT_NAME"));
                    test.setSubject(subject);
                    
                    list.add(test);
                }
            }
        }
        return list;
    }
}