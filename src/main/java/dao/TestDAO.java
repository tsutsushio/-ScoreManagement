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
    // ベースSQL・共通処理
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

    // =========================================================
    // 1件取得
    // =========================================================

    public TestBean get(StudentBean student, SubjectBean subject, SchoolBean school, int no) throws Exception {
        TestBean test = null;
        String sql = baseSql
            + "WHERE STUDENT_NO = ? "
            + "AND SUBJECT_CD = ? "
            + "AND SCHOOL_CD = ? "
            + "AND NO = ?";

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

    // =========================================================
    // 条件検索
    // =========================================================

    public List<TestBean> filter(int entYear, String classNum, SubjectBean subject, int num, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        String sql = baseSql + "WHERE SCHOOL_CD = ?";

        if (subject != null && subject.getCd() != null) {
            sql += " AND SUBJECT_CD = ?";
        }
        if (num > 0) {
            sql += " AND NO = ?";
        }

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            int idx = 1;
            st.setString(idx++, school.getCd());

            if (subject != null && subject.getCd() != null) {
                st.setString(idx++, subject.getCd());
            }
            if (num > 0) {
                st.setInt(idx++, num);
            }

            try (ResultSet rs = st.executeQuery()) {
                list = postFilter(rs, school);
            }
        }
        return list;
    }

    // =========================================================
    // 科目検索
    // =========================================================

    public List<TestBean> searchBySubject(int entYear, String classNum, String subjectCd, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        String sql = "SELECT * FROM TEST WHERE SCHOOL_CD = ? AND CLASS_NUM = ? AND SUBJECT_CD = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, school.getCd());
            st.setString(2, classNum);
            st.setString(3, subjectCd);

            try (ResultSet rs = st.executeQuery()) {
                list = postFilter(rs, school);
            }
        }
        return list;
    }

    public List<TestBean> searchBySubject(Integer entYear, String classNum, String subjectCd, String studentNo, SchoolBean school) throws Exception {
        List<TestBean> list = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
                "SELECT ST.NO AS STUDENT_NO, ST.NAME AS STUDENT_NAME, ST.ENT_YEAR, ST.CLASS_NUM, " +
                "T.NO, T.POINT, T.SUBJECT_CD, S.NAME AS SUBJECT_NAME " +
                "FROM TEST T " +
                "JOIN STUDENT ST ON T.STUDENT_NO = ST.NO AND T.SCHOOL_CD = ST.SCHOOL_CD " +
                "JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
                "WHERE T.SCHOOL_CD = ? "
        );

        if (entYear != null) { sql.append(" AND ST.ENT_YEAR = ? "); }
        if (classNum != null && !classNum.isEmpty()) { sql.append(" AND ST.CLASS_NUM = ? "); }
        if (subjectCd != null && !subjectCd.isEmpty()) { sql.append(" AND T.SUBJECT_CD = ? "); }
        if (studentNo != null && !studentNo.isEmpty()) { sql.append(" AND ST.NO = ? "); }
        
        sql.append(" ORDER BY ST.NO, T.NO");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {

            int idx = 1;
            st.setString(idx++, school.getCd());

            if (entYear != null) { st.setInt(idx++, entYear); }
            if (classNum != null && !classNum.isEmpty()) { st.setString(idx++, classNum); }
            if (subjectCd != null && !subjectCd.isEmpty()) { st.setString(idx++, subjectCd); }
            if (studentNo != null && !studentNo.isEmpty()) { st.setString(idx++, studentNo); }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TestBean test = new TestBean();
                    test.setNo(rs.getInt("NO"));
                    test.setPoint(rs.getInt("POINT"));
                    test.setClassNum(rs.getString("CLASS_NUM"));

                    // 学生情報のセット
                    StudentBean student = new StudentBean();
                    student.setNo(rs.getString("STUDENT_NO"));
                    student.setName(rs.getString("STUDENT_NAME"));
                    student.setEntYear(rs.getInt("ENT_YEAR"));
                    student.setClassNum(rs.getString("CLASS_NUM"));
                    test.setStudent(student);

                    // 科目情報のセット（これが追加されたことでJSP側で科目名が表示可能になります）
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

    // =========================================================
    // 【学生用】最新成績取得（＋順位・平均・最高点）
    // =========================================================

    public List<TestBean> getLatestScores(String studentNo) throws Exception {
        List<TestBean> list = new ArrayList<>();
        String sql = 
            "SELECT T2.SUBJECT_CD, T2.SUBJECT_NAME, T2.POINT, T2.NO, T2.RANK_NUM, T2.MAX_POINT, T2.AVG_POINT " +
            "FROM ( " +
            "    SELECT T.STUDENT_NO, T.SUBJECT_CD, S.NAME AS SUBJECT_NAME, T.POINT, T.NO, " +
            "           RANK() OVER (PARTITION BY T.SUBJECT_CD, T.NO ORDER BY T.POINT DESC) AS RANK_NUM, " +
            "           MAX(T.POINT) OVER (PARTITION BY T.SUBJECT_CD, T.NO) AS MAX_POINT, " +
            "           AVG(CAST(T.POINT AS DOUBLE)) OVER (PARTITION BY T.SUBJECT_CD, T.NO) AS AVG_POINT " +
            "    FROM TEST T " +
            "    JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
            ") T2 " +
            "WHERE T2.STUDENT_NO = ? AND T2.NO = (SELECT MAX(NO) FROM TEST WHERE STUDENT_NO = ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

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

    // =========================================================
    // 【学生用】全成績取得（＋順位・平均・最高点）
    // =========================================================

    public List<TestBean> getAllScores(String studentNo) throws Exception {
        List<TestBean> list = new ArrayList<>();
        String sql = 
            "SELECT T2.NO, T2.SUBJECT_CD, T2.SUBJECT_NAME, T2.POINT, T2.RANK_NUM, T2.MAX_POINT, T2.AVG_POINT " +
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

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

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

    // =========================================================
    // 保存（トランザクション処理）
    // =========================================================

    public boolean save(List<TestBean> list) throws Exception {
        boolean isSuccess = true;
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try {
                for (TestBean test : list) {
                    if (!save(test, con)) {
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

    // =========================================================
    // 個別保存（バリデーション追加）
    // =========================================================

    private boolean save(TestBean test, Connection connection) throws Exception {
        
        // 🌟【例外処理】点数が0〜100の範囲外ならエラーとして弾く
        if (test.getPoint() < 0 || test.getPoint() > 100) {
            throw new Exception("テストの点数は0〜100の間で入力してください。（対象学生: " 
                + test.getStudent().getNo() + ", 異常値: " + test.getPoint() + "）");
        }

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
            
        } catch (java.sql.SQLException e) {
            // 万が一、科目コードが存在しないなどの外部キー制約エラーが起きた場合
            e.printStackTrace();
            throw new Exception("データベース保存エラーが発生しました。学生情報や科目情報が正しく登録されているか確認してください。");
        }

        return isSuccess;
    }
}