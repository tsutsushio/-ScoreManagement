package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SubjectBean;

public class SubjectDAO extends DAO {

    // =========================================================
    // 【1件取得】科目コードで1件取得
    // =========================================================
    public SubjectBean get(String cd) throws Exception {

        SubjectBean subject = null;
        String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT WHERE CD = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
             
            st.setString(1, cd);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    subject = new SubjectBean();
                    subject.setSchoolCd(rs.getString("SCHOOL_CD"));
                    subject.setCd(rs.getString("CD"));
                    subject.setName(rs.getString("NAME"));
                }
            }
        }
        return subject;
    }

    // =========================================================
    // 【新規登録】科目を登録する
    // =========================================================
    public int insert(SubjectBean subject) throws Exception {
        
        // 🌟【例外処理】事前バリデーション（DBの文字数あふれ防止）
        if (subject.getCd() != null && subject.getCd().length() != 3) {
            throw new Exception("科目コードは3文字で入力してください。");
        }
        if (subject.getName() != null && subject.getName().length() > 20) {
            throw new Exception("科目名は20文字以内で入力してください。");
        }

        int count = 0;
        String sql = "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
             
            st.setString(1, subject.getSchoolCd());
            st.setString(2, subject.getCd());
            st.setString(3, subject.getName());

            // 🌟【例外処理】SQL実行時のエラーキャッチ
            try {
                count = st.executeUpdate();
            } catch (java.sql.SQLException e) {
                e.printStackTrace();
                throw new Exception("データベースの保存に失敗しました。科目コードが既に存在する可能性があります。");
            }
        }
        return count;
    }

    // =========================================================
    // 【一覧取得】すべての科目を取得
    // =========================================================
    public List<SubjectBean> list() throws Exception {

        List<SubjectBean> list = new ArrayList<>();
        String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT ORDER BY CD";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                SubjectBean subject = new SubjectBean();
                subject.setSchoolCd(rs.getString("SCHOOL_CD"));
                subject.setCd(rs.getString("CD"));
                subject.setName(rs.getString("NAME"));

                list.add(subject);
            }
        }
        return list;
    }

    // =========================================================
    // 【削除】成績データを先に消してから科目を削除
    // =========================================================
    public boolean delete(String cd, String schoolCd) throws Exception {
        boolean isSuccess = false;

        try (Connection con = getConnection()) {
            // トランザクションを開始して、両方の削除が確実にセットで行われるようにする
            con.setAutoCommit(false);
            
            try {
                // TESTテーブルの関連データを先に削除
                String sql1 = "DELETE FROM TEST WHERE SCHOOL_CD = ? AND SUBJECT_CD = ?";
                try (PreparedStatement st1 = con.prepareStatement(sql1)) {
                    st1.setString(1, schoolCd);
                    st1.setString(2, cd);
                    st1.executeUpdate();
                }

                // SUBJECTテーブルから科目を削除
                String sql2 = "DELETE FROM SUBJECT WHERE SCHOOL_CD = ? AND CD = ?";
                try (PreparedStatement st2 = con.prepareStatement(sql2)) {
                    st2.setString(1, schoolCd);
                    st2.setString(2, cd);
                    int count = st2.executeUpdate();
                    isSuccess = (count > 0);
                }
                
                // 両方成功したら確定
                con.commit();
                
            } catch (Exception e) {
                // 途中でエラーが起きたら巻き戻す
                con.rollback();
                throw new Exception("科目の削除に失敗しました。関連するデータが存在する可能性があります。");
            }
        }
        return isSuccess;
    }

    // =========================================================
    // 【更新】科目名を更新
    // =========================================================
    public boolean update(SubjectBean subject) throws Exception {
        
        // 🌟【例外処理】事前バリデーション
        if (subject.getName() != null && subject.getName().length() > 20) {
            throw new Exception("科目名は20文字以内で入力してください。");
        }

        boolean isSuccess = false;
        String sql = "UPDATE SUBJECT SET NAME = ? WHERE SCHOOL_CD = ? AND CD = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, subject.getName());
            st.setString(2, subject.getSchoolCd());
            st.setString(3, subject.getCd());

            try {
                int count = st.executeUpdate();
                isSuccess = (count > 0);
            } catch (java.sql.SQLException e) {
                e.printStackTrace();
                throw new Exception("科目の更新に失敗しました。");
            }
        }
        return isSuccess;
    }

    // =========================================================
    // 【条件検索】学校ごとの科目一覧取得
    // =========================================================
    public List<SubjectBean> filter(String schoolCd) throws Exception {

        List<SubjectBean> list = new ArrayList<>();
        String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT WHERE SCHOOL_CD = ? ORDER BY CD";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, schoolCd);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    SubjectBean subject = new SubjectBean();
                    subject.setSchoolCd(rs.getString("SCHOOL_CD"));
                    subject.setCd(rs.getString("CD"));
                    subject.setName(rs.getString("NAME"));

                    list.add(subject);
                }
            }
        }
        return list;
    }
}