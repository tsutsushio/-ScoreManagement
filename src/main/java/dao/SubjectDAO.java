package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean;

public class SubjectDAO extends DAO {

    /**
     * 【追加】クラス図: get(cd: String, school: School): Subject
     * 学校と科目コードを指定して1件取得する
     */
    public SubjectBean get(String cd, SchoolBean school) throws Exception {
        SubjectBean subject = null;
        Connection con = getConnection();
        String sql = "SELECT CD, NAME FROM SUBJECT WHERE CD = ? AND SCHOOL_CD = ?";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, cd);
        st.setString(2, school.getCd());
        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            subject = new SubjectBean();
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));
            // SubjectBeanに合わせてString型の学校コードをセット
            subject.setSchoolCd(school.getCd()); 
        }

        rs.close();
        st.close();
        con.close();
        return subject;
    }

    /**
     * 【追加】クラス図: filter(school: School): List<Subject>
     * 特定の学校に紐づく科目一覧を取得する
     */
    public List<SubjectBean> filter(SchoolBean school) throws Exception {
        List<SubjectBean> list = new ArrayList<>();
        Connection con = getConnection();
        String sql = "SELECT CD, NAME FROM SUBJECT WHERE SCHOOL_CD = ? ORDER BY CD ASC";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, school.getCd());
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            SubjectBean subject = new SubjectBean();
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));
            // SubjectBeanに合わせてString型の学校コードをセット
            subject.setSchoolCd(school.getCd());
            list.add(subject);
        }

        rs.close();
        st.close();
        con.close();
        return list;
    }

    /**
     * 【追加】クラス図: save(subject: Subject): boolean
     * 存在すれば更新、なければ登録を行う
     */
    public boolean save(SubjectBean subject) throws Exception {
        Connection con = getConnection();
        // 学校コードを取得（既存のget(String)は学校を見ないので注意）
        // ここでは安全のためDB接続して存在確認
        String checkSql = "SELECT COUNT(*) FROM SUBJECT WHERE CD = ? AND SCHOOL_CD = ?";
        PreparedStatement stCheck = con.prepareStatement(checkSql);
        stCheck.setString(1, subject.getCd());
        stCheck.setString(2, subject.getSchoolCd());
        ResultSet rs = stCheck.executeQuery();
        
        boolean exists = false;
        if (rs.next() && rs.getInt(1) > 0) {
            exists = true;
        }
        rs.close();
        stCheck.close();

        int count = 0;
        if (!exists) {
            // 新規登録
            String sql = "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, subject.getSchoolCd());
            st.setString(2, subject.getCd());
            st.setString(3, subject.getName());
            count = st.executeUpdate();
            st.close();
        } else {
            // 更新
            String sql = "UPDATE SUBJECT SET NAME = ? WHERE CD = ? AND SCHOOL_CD = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, subject.getName());
            st.setString(2, subject.getCd());
            st.setString(3, subject.getSchoolCd());
            count = st.executeUpdate();
            st.close();
        }

        con.close();
        return count > 0;
    }

    /**
     * 【追加】クラス図: delete(subject: Subject): boolean
     * データを削除する
     */
    public boolean delete(SubjectBean subject) throws Exception {
        Connection con = getConnection();
        String sql = "DELETE FROM SUBJECT WHERE CD = ? AND SCHOOL_CD = ?";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, subject.getCd());
        st.setString(2, subject.getSchoolCd());
        int count = st.executeUpdate();

        st.close();
        con.close();
        return count > 0;
    }
}