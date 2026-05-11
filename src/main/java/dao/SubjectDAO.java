package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean; // ここを SubjectBean に変更

public class SubjectDAO extends DAO {

<<<<<<< HEAD
    /**
     * 科目コードと学校から、特定の科目を1件取得する
     */
    public SubjectBean get(String cd, SchoolBean school) throws Exception {
=======
    // 科目コードで1件取得
    public SubjectBean get(String cd) throws Exception {

>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
        SubjectBean subject = null;
        String sql = "SELECT * FROM subject WHERE cd = ? AND school_cd = ?";

        // try-with-resources文を使うと close() 漏れがなくて安全です
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, cd);
            st.setString(2, school.getCd());

<<<<<<< HEAD
            try (ResultSet rSet = st.executeQuery()) {
                if (rSet.next()) {
                    subject = new SubjectBean();
                    subject.setCd(rSet.getString("cd"));
                    subject.setName(rSet.getString("name"));
                    subject.setSchool(school);
                }
            }
=======
        String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT WHERE CD = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, cd);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            subject = new SubjectBean();
            subject.setSchoolCd(rs.getString("SCHOOL_CD"));
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
        }
        return subject;
    }

<<<<<<< HEAD
    /**
     * 学校に紐づく科目一覧を取得する（セレクトボックス用）
     */
    public List<SubjectBean> filter(SchoolBean school) throws Exception {
        List<SubjectBean> list = new ArrayList<>();
        String sql = "SELECT * FROM subject WHERE school_cd = ? ORDER BY cd ASC";
=======
    // 新規登録
    public int insert(SubjectBean subject) throws Exception {
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, school.getCd());

<<<<<<< HEAD
            try (ResultSet rSet = st.executeQuery()) {
                while (rSet.next()) {
                    SubjectBean subject = new SubjectBean();
                    subject.setCd(rSet.getString("cd"));
                    subject.setName(rSet.getString("name"));
                    subject.setSchool(school);
                    list.add(subject);
                }
            }
        }
        return list;
=======
        String sql =
            "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, subject.getSchoolCd());
        st.setString(2, subject.getCd());
        st.setString(3, subject.getName());

        int count = st.executeUpdate();

        st.close();
        con.close();

        return count;
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
    }

<<<<<<< HEAD
    /**
     * 科目情報の保存
     */
    public boolean save(SubjectBean subject) throws Exception {
=======
    // 一覧取得
    public List<SubjectBean> list() throws Exception {

        List<SubjectBean> list = new ArrayList<>();

>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
        Connection con = getConnection();
        PreparedStatement st = null;
        int count = 0;

<<<<<<< HEAD
        try {
            SubjectBean exists = get(subject.getCd(), subject.getSchool());
            if (exists == null) {
                st = con.prepareStatement("INSERT INTO subject (cd, name, school_cd) VALUES(?, ?, ?)");
                st.setString(1, subject.getCd());
                st.setString(2, subject.getName());
                st.setString(3, subject.getSchool().getCd());
            } else {
                st = con.prepareStatement("UPDATE subject SET name = ? WHERE cd = ? AND school_cd = ?");
                st.setString(1, subject.getName());
                st.setString(2, subject.getCd());
                st.setString(3, subject.getSchool().getCd());
            }
            count = st.executeUpdate();
        } finally {
            if (st != null) st.close();
            if (con != null) con.close();
=======
        String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT ORDER BY CD";

        PreparedStatement st = con.prepareStatement(sql);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            SubjectBean subject = new SubjectBean();
            subject.setSchoolCd(rs.getString("SCHOOL_CD"));
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));

            list.add(subject);
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
        }
        return count > 0;
    }

    /**
     * 科目情報の削除
     */
    public boolean delete(SubjectBean subject) throws Exception {
        int count = 0;
        String sql = "DELETE FROM subject WHERE cd = ? AND school_cd = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, subject.getCd());
            st.setString(2, subject.getSchool().getCd());
            count = st.executeUpdate();
        }
        return count > 0;
        
}
}