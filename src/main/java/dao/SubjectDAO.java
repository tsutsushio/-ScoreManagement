package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SubjectBean;

public class SubjectDAO extends DAO {

    /**
     * 科目コードで1件取得
     */
    public SubjectBean get(String cd) throws Exception {

        SubjectBean subject = null;

        Connection con = getConnection();

        String sql = "SELECT CD, NAME FROM SUBJECT WHERE CD = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, cd);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            subject = new SubjectBean();
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));
        }

        rs.close();
        st.close();
        con.close();

        return subject;
    }

    /**
     * 科目を新規登録
     */
    public int insert(SubjectBean subject) throws Exception {

        Connection con = getConnection();

        String sql = "INSERT INTO SUBJECT (CD, NAME) VALUES (?, ?)";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, subject.getCd());
        st.setString(2, subject.getName());

        int count = st.executeUpdate();

        st.close();
        con.close();

        return count;
    }

    /**
     * 科目一覧を取得
     */
    public List<SubjectBean> list() throws Exception {

        List<SubjectBean> list = new ArrayList<>();

        Connection con = getConnection();

        String sql = "SELECT CD, NAME FROM SUBJECT ORDER BY CD";

        PreparedStatement st = con.prepareStatement(sql);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            SubjectBean subject = new SubjectBean();
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));

            list.add(subject);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }
}