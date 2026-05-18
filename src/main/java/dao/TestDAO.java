package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.TestBean;

public class TestDAO extends DAO {

    // =========================================
    // 1件取得（重複チェック用）
    // =========================================
    public TestBean get(String studentNo, String subjectCd, int no, String schoolCd) throws Exception {

        TestBean test = null;

        Connection con = getConnection();

        String sql =
            "SELECT STUDENT_NO, SUBJECT_CD, NO, POINT, SCHOOL_CD " +
            "FROM TEST " +
            "WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ? AND SCHOOL_CD = ?";

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, studentNo);
        st.setString(2, subjectCd);
        st.setInt(3, no);
        st.setString(4, schoolCd);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {

            test = new TestBean();
            test.setStudentNo(rs.getString("STUDENT_NO"));
            test.setSubjectCd(rs.getString("SUBJECT_CD"));
            test.setNo(rs.getInt("NO"));
            test.setPoint(rs.getInt("POINT"));
            test.setSchoolCd(rs.getString("SCHOOL_CD"));
        }

        rs.close();
        st.close();
        con.close();

        return test;
    }

    // =========================================
    // 登録
    // =========================================
    public boolean save(TestBean test) throws Exception {

        Connection con = getConnection();

        String sql =
            "INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, NO, POINT, SCHOOL_CD) " +
            "VALUES (?, ?, ?, ?, ?)";

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, test.getStudentNo());
        st.setString(2, test.getSubjectCd());
        st.setInt(3, test.getNo());
        st.setInt(4, test.getPoint());
        st.setString(5, test.getSchoolCd());

        int count = st.executeUpdate();

        st.close();
        con.close();

        return count > 0;
    }

    // =========================================
    // 一覧取得（学校＋科目検索対応）
    // =========================================
    public List<TestBean> filter(String schoolCd, String subjectCd) throws Exception {

        List<TestBean> list = new ArrayList<>();

        Connection con = getConnection();

        String sql =
            "SELECT STUDENT_NO, SUBJECT_CD, NO, POINT, SCHOOL_CD " +
            "FROM TEST WHERE SCHOOL_CD = ? ";

        if (subjectCd != null) {
            sql += "AND SUBJECT_CD = ? ";
        }

        sql += "ORDER BY STUDENT_NO, SUBJECT_CD, NO";

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, schoolCd);

        if (subjectCd != null) {
            st.setString(2, subjectCd);
        }

        ResultSet rs = st.executeQuery();

        while (rs.next()) {

            TestBean test = new TestBean();

            test.setStudentNo(rs.getString("STUDENT_NO"));
            test.setSubjectCd(rs.getString("SUBJECT_CD"));
            test.setNo(rs.getInt("NO"));
            test.setPoint(rs.getInt("POINT"));
            test.setSchoolCd(rs.getString("SCHOOL_CD"));

            list.add(test);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    // =========================================
    // 削除
    // =========================================
    public boolean delete(TestBean test) throws Exception {

        Connection con = getConnection();

        String sql =
            "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ? AND SCHOOL_CD = ?";

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, test.getStudentNo());
        st.setString(2, test.getSubjectCd());
        st.setInt(3, test.getNo());
        st.setString(4, test.getSchoolCd());

        int count = st.executeUpdate();

        st.close();
        con.close();

        return count > 0;
    }
}