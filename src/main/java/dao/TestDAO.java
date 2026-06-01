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

    // =========================================================
    // 【クラス図準拠】ベースとなるSQL・共通処理
    // =========================================================
    private String baseSql = "SELECT * FROM TEST ";

    private List<TestBean> postFilter(ResultSet rSet, SchoolBean school) throws Exception {

        List<TestBean> list = new ArrayList<>();

        while (rSet.next()) {

            TestBean test = new TestBean();

            test.setNo(rSet.getInt("NO"));
            test.setPoint(rSet.getInt("POINT"));
            test.setClassNum(rSet.getString("CLASS_NUM"));

            test.setSchool(school);

            StudentBean student = new StudentBean();
            student.setNo(rSet.getString("STUDENT_NO"));
            test.setStudent(student);

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
                if (!list.isEmpty()) { test = list.get(0); }
            }
        }

        return test;
    }

    public List<TestBean> filter(int entYear,
            String classNum,
            SubjectBean subject,
            int num,
            SchoolBean school) throws Exception {
    	
        List<TestBean> list = new ArrayList<>();

        String sql = baseSql + "WHERE SCHOOL_CD = ?";
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
            con.setAutoCommit(false);
            try {
                for (TestBean test : list) {
                    if (!save(test, con)) { isSuccess = false; break; }
                }
                if (isSuccess) con.commit(); else con.rollback();
            } catch (Exception e) { con.rollback(); throw e; }
        }
        return isSuccess;
    }

    private boolean save(TestBean test, Connection connection)
            throws Exception {

        boolean isSuccess = false;
        TestBean existingTest = get(test.getStudent(), test.getSubject(), test.getSchool(), test.getNo());
        String sql;
        if (existingTest == null) {

            sql = "INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) VALUES (?, ?, ?, ?, ?, ?)";

        } else {
            sql = "UPDATE TEST SET POINT = ?, CLASS_NUM = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        }
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (existingTest == null) {

                st.setString(1, test.getStudentNo());
                st.setString(2, test.getSubjectCd());
                st.setString(3, test.getSchoolCd());
                st.setInt(4, test.getNo());
                st.setInt(5, test.getPoint());
                st.setString(6, test.getClassNum());

            } else {

                st.setInt(1, test.getPoint());
                st.setString(2, test.getClassNum());
                st.setString(3, test.getStudentNo());
                st.setString(4, test.getSubjectCd());
                st.setString(5, test.getSchoolCd());
                st.setInt(6, test.getNo());
           }

            if (st.executeUpdate() > 0) isSuccess = true;
        }

        return isSuccess;
    }

    public boolean delete(List<TestBean> list) throws Exception {

        boolean isSuccess = true;

        try (Connection con = getConnection()) {

            con.setAutoCommit(false);

            try {

                for (TestBean test : list) {

                    if (!delete(test, con)) { isSuccess = false; break; }
                }
                if (isSuccess) con.commit(); else con.rollback();
            } catch (Exception e) { con.rollback(); throw e; }
        }

        return isSuccess;
    }

    private boolean delete(TestBean test,
            Connection connection) throws Exception {

        boolean isSuccess = false;

        String sql = "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, test.getStudent().getNo());
            st.setString(2, test.getSubject().getCd());
            st.setString(3, test.getSchool().getCd());

            st.setInt(4, test.getNo());
            if (st.executeUpdate() > 0) isSuccess = true;

        }

        return isSuccess;
    }


    // =========================================================
    // 🌟【学生用】オリジナル追加機能（順位・平均・最高点の計算付き）
    // =========================================================

    public List<TestBean> getLatestScores(String studentNo) throws Exception {
        List<TestBean> list = new ArrayList<>();
        // サブクエリで全員の順位や平均を計算し、自分の分だけ取得
        String sql = "SELECT T2.SUBJECT_CD, T2.SUBJECT_NAME, T2.POINT, T2.NO, " +
                     "       T2.RANK_NUM, T2.MAX_POINT, T2.AVG_POINT " +
                     "FROM ( " +
                     "    SELECT T.STUDENT_NO, T.SUBJECT_CD, S.NAME AS SUBJECT_NAME, T.POINT, T.NO, " +
                     "           RANK() OVER (PARTITION BY T.SUBJECT_CD, T.NO ORDER BY T.POINT DESC) AS RANK_NUM, " +
                     "           MAX(T.POINT) OVER (PARTITION BY T.SUBJECT_CD, T.NO) AS MAX_POINT, " +
                     "           AVG(CAST(T.POINT AS DOUBLE)) OVER (PARTITION BY T.SUBJECT_CD, T.NO) AS AVG_POINT " +
                     "    FROM TEST T " +
                     "    JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
                     ") T2 " +
                     "WHERE T2.STUDENT_NO = ? " +
                     "AND T2.NO = (SELECT MAX(NO) FROM TEST WHERE STUDENT_NO = ?)";

        List<TestBean> list_1 = new ArrayList<>();

        String sql_1 =
                "SELECT T.SUBJECT_CD, "
                + "S.NAME AS SUBJECT_NAME, "
                + "T.POINT, "
                + "T.NO "
                + "FROM TEST T "
                + "JOIN SUBJECT S "
                + "ON T.SUBJECT_CD = S.CD "
                + "AND T.SCHOOL_CD = S.SCHOOL_CD "
                + "WHERE T.STUDENT_NO = ? "
                + "AND T.NO = ("
                + "SELECT MAX(NO) "
                + "FROM TEST "
                + "WHERE STUDENT_NO = ?)";

        try (
                Connection con = getConnection();
                PreparedStatement st =
                        con.prepareStatement(sql)) {

            st.setString(1, studentNo);
            st.setString(2, studentNo);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    TestBean test = new TestBean();

                    test.setPoint(rs.getInt("POINT"));
                    test.setNo(rs.getInt("NO"));

                    test.setRank(rs.getInt("RANK_NUM"));
                    test.setMaxPoint(rs.getInt("MAX_POINT"));
                    test.setAveragePoint(Math.round(rs.getDouble("AVG_POINT") * 10.0) / 10.0);
                    
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
        String sql = "SELECT T2.NO, T2.SUBJECT_CD, T2.SUBJECT_NAME, T2.POINT, " +
                     "       T2.RANK_NUM, T2.MAX_POINT, T2.AVG_POINT " +
                     "FROM ( " +
                     "    SELECT T.STUDENT_NO, T.SUBJECT_CD, S.NAME AS SUBJECT_NAME, T.POINT, T.NO, " +
                     "           RANK() OVER (PARTITION BY T.SUBJECT_CD, T.NO ORDER BY T.POINT DESC) AS RANK_NUM, " +
                     "           MAX(T.POINT) OVER (PARTITION BY T.SUBJECT_CD, T.NO) AS MAX_POINT, " +
                     "           AVG(CAST(T.POINT AS DOUBLE)) OVER (PARTITION BY T.SUBJECT_CD, T.NO) AS AVG_POINT " +
                     "    FROM TEST T " +
                     "    JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
                     ") T2 " +
                     "WHERE T2.STUDENT_NO = ? " +
                     "ORDER BY T2.NO DESC, T2.SUBJECT_CD ASC";

        List<TestBean> list_1 = new ArrayList<>();

        String sql_1 =
                "SELECT T.NO, "
                + "T.SUBJECT_CD, "
                + "S.NAME AS SUBJECT_NAME, "
                + "T.POINT "
                + "FROM TEST T "
                + "JOIN SUBJECT S "
                + "ON T.SUBJECT_CD = S.CD "
                + "AND T.SCHOOL_CD = S.SCHOOL_CD "
                + "WHERE T.STUDENT_NO = ? "
                + "ORDER BY T.NO DESC, T.SUBJECT_CD ASC";

        try (
                Connection con = getConnection();
                PreparedStatement st =
                        con.prepareStatement(sql)) {

            st.setString(1, studentNo);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    TestBean test = new TestBean();

                    test.setNo(rs.getInt("NO"));
                    test.setPoint(rs.getInt("POINT"));
                    test.setRank(rs.getInt("RANK_NUM"));
                    test.setMaxPoint(rs.getInt("MAX_POINT"));
                    test.setAveragePoint(Math.round(rs.getDouble("AVG_POINT") * 10.0) / 10.0);
                    
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
	public List<TestBean> searchBySubject(int int1, String classNum, String subjectCd, SchoolBean school) {
		return null;
	}
	public boolean save(TestBean test) {return false;}
	public TestBean get(SubjectBean subject, SchoolBean school, int no) {return null;}
}