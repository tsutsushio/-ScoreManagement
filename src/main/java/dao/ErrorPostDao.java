package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ErrorPostBean;

public class ErrorPostDao extends DAO {

    // =========================================================
    // 【新規登録】エラー情報を登録する
    // =========================================================
    public int insert(ErrorPostBean errorPost) throws Exception {

        int count = 0;

        String sql =
            "INSERT INTO ERROR_POST " +
            "(SCHOOL_CD, SUBJECT_CD, TITLE, CONTENT, SOLUTION) " +
            "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, errorPost.getSchoolCd());
            st.setString(2, errorPost.getSubjectCd());
            st.setString(3, errorPost.getTitle());
            st.setString(4, errorPost.getContent());
            st.setString(5, errorPost.getSolution());

            count = st.executeUpdate();
        }

        return count;
    }


    // =========================================================
    // 【一覧取得】学校ごとのエラー情報を取得
    // =========================================================
    public List<ErrorPostBean> list(String schoolCd) throws Exception {

        List<ErrorPostBean> list = new ArrayList<>();

        String sql =
            "SELECT E.NO, " +
            "       E.SCHOOL_CD, " +
            "       E.SUBJECT_CD, " +
            "       S.NAME AS SUBJECT_NAME, " +
            "       E.TITLE, " +
            "       E.CONTENT, " +
            "       E.SOLUTION " +
            "FROM ERROR_POST E " +
            "INNER JOIN SUBJECT S " +
            "ON E.SCHOOL_CD = S.SCHOOL_CD " +
            "AND E.SUBJECT_CD = S.CD " +
            "WHERE E.SCHOOL_CD = ? " +
            "ORDER BY E.NO DESC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, schoolCd);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    ErrorPostBean errorPost = new ErrorPostBean();

                    errorPost.setNo(rs.getInt("NO"));
                    errorPost.setSchoolCd(rs.getString("SCHOOL_CD"));
                    errorPost.setSubjectCd(rs.getString("SUBJECT_CD"));
                    errorPost.setSubjectName(rs.getString("SUBJECT_NAME"));
                    errorPost.setTitle(rs.getString("TITLE"));
                    errorPost.setContent(rs.getString("CONTENT"));
                    errorPost.setSolution(rs.getString("SOLUTION"));

                    list.add(errorPost);
                }
            }
        }

        return list;
    }


    // =========================================================
    // 【条件検索】学校＋科目コードでエラー情報を検索
    // =========================================================
    public List<ErrorPostBean> filter(
            String schoolCd,
            String subjectCd
    ) throws Exception {

        List<ErrorPostBean> list = new ArrayList<>();

        String sql =
            "SELECT E.NO, " +
            "       E.SCHOOL_CD, " +
            "       E.SUBJECT_CD, " +
            "       S.NAME AS SUBJECT_NAME, " +
            "       E.TITLE, " +
            "       E.CONTENT, " +
            "       E.SOLUTION " +
            "FROM ERROR_POST E " +
            "INNER JOIN SUBJECT S " +
            "ON E.SCHOOL_CD = S.SCHOOL_CD " +
            "AND E.SUBJECT_CD = S.CD " +
            "WHERE E.SCHOOL_CD = ? " +
            "AND E.SUBJECT_CD = ? " +
            "ORDER BY E.NO DESC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, schoolCd);
            st.setString(2, subjectCd);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    ErrorPostBean errorPost = new ErrorPostBean();

                    errorPost.setNo(rs.getInt("NO"));
                    errorPost.setSchoolCd(rs.getString("SCHOOL_CD"));
                    errorPost.setSubjectCd(rs.getString("SUBJECT_CD"));
                    errorPost.setSubjectName(rs.getString("SUBJECT_NAME"));
                    errorPost.setTitle(rs.getString("TITLE"));
                    errorPost.setContent(rs.getString("CONTENT"));
                    errorPost.setSolution(rs.getString("SOLUTION"));

                    list.add(errorPost);
                }
            }
        }

        return list;
    }
}