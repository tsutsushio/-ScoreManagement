package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.security.auth.Subject;

public class SubjectDAO extends DAO {

    // 科目コードで1件取得
    public Subject get(String cd) throws Exception {

        Subject subject = null;

        Connection con = getConnection();

        String sql = "SELECT CD, NAME FROM SUBJECT WHERE CD = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, cd);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            subject = new Subject();
            subject.setCd(rs.getString("CD"));
            subject.setName(rs.getString("NAME"));
        }

        rs.close();
        st.close();
        con.close();

        return subject;
    }

    // 新規登録
    public int insert(Subject subject) throws Exception {

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
}
