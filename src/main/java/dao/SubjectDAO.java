package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean; // ここを SubjectBean に変更

public class SubjectDAO extends DAO {

    /**
     * 科目コードと学校から、特定の科目を1件取得する
     */
    public SubjectBean get(String cd, SchoolBean school) throws Exception {
        SubjectBean subject = null;
        String sql = "SELECT * FROM subject WHERE cd = ? AND school_cd = ?";

        // try-with-resources文を使うと close() 漏れがなくて安全です
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, cd);
            st.setString(2, school.getCd());

            try (ResultSet rSet = st.executeQuery()) {
                if (rSet.next()) {
                    subject = new SubjectBean();
                    subject.setCd(rSet.getString("cd"));
                    subject.setName(rSet.getString("name"));
                    subject.setSchool(school);
                }
            }
        }
        return subject;
    }

    /**
     * 学校に紐づく科目一覧を取得する（セレクトボックス用）
     */
    public List<SubjectBean> filter(SchoolBean school) throws Exception {
        List<SubjectBean> list = new ArrayList<>();
        String sql = "SELECT * FROM subject WHERE school_cd = ? ORDER BY cd ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, school.getCd());

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
    }

    /**
     * 科目情報の保存
     */
    public boolean save(SubjectBean subject) throws Exception {
        Connection con = getConnection();
        PreparedStatement st = null;
        int count = 0;

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