package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.TestBean;

public class TestDAO extends DAO {

    // =========================================
    // 1件取得
    // =========================================
    public TestBean get(String studentNo, String subjectCd, String schoolCd, int no) throws Exception {
        TestBean test = null;
        Connection con = getConnection();

        try {
            String sql = "SELECT STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM " +
                         "FROM TEST " +
                         "WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, studentNo);
            st.setString(2, subjectCd);
            st.setString(3, schoolCd);
            st.setInt(4, no);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                test = new TestBean();
                test.setStudentNo(rs.getString("STUDENT_NO"));
                test.setSubjectCd(rs.getString("SUBJECT_CD"));
                test.setSchoolCd(rs.getString("SCHOOL_CD"));
                test.setNo(rs.getInt("NO"));
                test.setPoint(rs.getInt("POINT"));
                test.setClassNum(rs.getString("CLASS_NUM"));
            }
            rs.close();
            st.close();
        } finally {
            con.close();
        }

        return test;
    }

    // =========================================
    // 重複チェック
    // =========================================
    public boolean exists(String studentNo, String subjectCd, String schoolCd, int no) throws Exception {
        Connection con = getConnection();
        boolean exists = false;

        try {
            String sql = "SELECT COUNT(*) FROM TEST " +
                         "WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, studentNo);
            st.setString(2, subjectCd);
            st.setString(3, schoolCd);
            st.setInt(4, no);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            rs.close();
            st.close();
        } finally {
            con.close();
        }

        return exists;
    }

    // =========================================
    // 登録（CLASS_NUM対応）
    // =========================================
    public boolean save(TestBean test) throws Exception {
        Connection con = getConnection();

        try {
            String sql = "INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, test.getStudentNo());
            st.setString(2, test.getSubjectCd());
            st.setString(3, test.getSchoolCd());
            st.setInt(4, test.getNo());
            st.setInt(5, test.getPoint());
            st.setString(6, test.getClassNum());

            int count = st.executeUpdate();
            st.close();
            return count > 0;
        } finally {
            con.close();
        }
    }

    // =========================================
    // 編集（更新）
    // =========================================
    public boolean update(TestBean test) throws Exception {
        Connection con = getConnection();

        try {
            String sql = "UPDATE TEST " +
                         "SET POINT = ?, CLASS_NUM = ? " +
                         "WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, test.getPoint());
            st.setString(2, test.getClassNum());
            st.setString(3, test.getStudentNo());
            st.setString(4, test.getSubjectCd());
            st.setString(5, test.getSchoolCd());
            st.setInt(6, test.getNo());

            int count = st.executeUpdate();
            st.close();
            return count > 0;
        } finally {
            con.close();
        }
    }

    // =========================================
    // 一覧取得（学校＋科目検索対応、CLASS_NUMも取得）
    // =========================================
    public List<TestBean> filter(String schoolCd, String subjectCd) throws Exception {
        List<TestBean> list = new ArrayList<>();
        Connection con = getConnection();

        try {
            String sql = "SELECT STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM " +
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
                test.setSchoolCd(rs.getString("SCHOOL_CD"));
                test.setNo(rs.getInt("NO"));
                test.setPoint(rs.getInt("POINT"));
                test.setClassNum(rs.getString("CLASS_NUM"));

                list.add(test);
            }
            rs.close();
            st.close();
        } finally {
            con.close();
        }

        return list;
    }

    // =========================================
    // 削除
    // =========================================
    public boolean delete(TestBean test) throws Exception {
        Connection con = getConnection();

        try {
            String sql = "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, test.getStudentNo());
            st.setString(2, test.getSubjectCd());
            st.setString(3, test.getSchoolCd());
            st.setInt(4, test.getNo());

            int count = st.executeUpdate();
            st.close();
            return count > 0;
        } finally {
            con.close();
        }
    }
}