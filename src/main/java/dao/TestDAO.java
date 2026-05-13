package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.TestBean;

public class TestDAO extends DAO {

    // 新規登録
    public boolean save(TestBean test)
            throws Exception {

        Connection con =
            getConnection();

        String sql =
            "INSERT INTO TEST " +
            "(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement st =
            con.prepareStatement(sql);

        st.setString(1, test.getStudentNo());
        st.setString(2, test.getSubjectCd());
        st.setString(3, test.getSchoolCd());
        st.setInt(4, test.getNo());
        st.setInt(5, test.getPoint());
        st.setString(6, test.getClassNum());

        int count =
            st.executeUpdate();

        st.close();
        con.close();

        return count > 0;
    }

    // 編集（更新）
    public boolean update(TestBean test)
            throws Exception {

        Connection con =
            getConnection();

        String sql =
            "UPDATE TEST " +
            "SET POINT = ?, CLASS_NUM = ? " +
            "WHERE STUDENT_NO = ? " +
            "AND SUBJECT_CD = ? " +
            "AND SCHOOL_CD = ? " +
            "AND NO = ?";

        PreparedStatement st =
            con.prepareStatement(sql);

        st.setInt(1, test.getPoint());
        st.setString(2, test.getClassNum());
        st.setString(3, test.getStudentNo());
        st.setString(4, test.getSubjectCd());
        st.setString(5, test.getSchoolCd());
        st.setInt(6, test.getNo());

        int count =
            st.executeUpdate();

        st.close();
        con.close();

        return count > 0;
    }

    // 重複チェック
    public boolean exists(
            String studentNo,
            String subjectCd,
            String schoolCd,
            int no
    ) throws Exception {

        Connection con =
            getConnection();

        String sql =
            "SELECT COUNT(*) " +
            "FROM TEST " +
            "WHERE STUDENT_NO = ? " +
            "AND SUBJECT_CD = ? " +
            "AND SCHOOL_CD = ? " +
            "AND NO = ?";

        PreparedStatement st =
            con.prepareStatement(sql);

        st.setString(1, studentNo);
        st.setString(2, subjectCd);
        st.setString(3, schoolCd);
        st.setInt(4, no);

        ResultSet rs =
            st.executeQuery();

        boolean exists = false;

        if (rs.next()) {
            exists =
                rs.getInt(1) > 0;
        }

        rs.close();
        st.close();
        con.close();

        return exists;
    }
}