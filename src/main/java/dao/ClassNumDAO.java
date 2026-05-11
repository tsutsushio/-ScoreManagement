package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// Beanのインポート
import bean.SchoolBean;

/**
 * ClassNumDaoクラス
 * 学校に紐づくクラス番号の一覧を取得します。
 */
public class ClassNumDAO extends DAO {

    /**
     * 指定された学校に所属する全クラス番号を取得する
     * @param school 学校Bean
     * @return クラス番号（String）のリスト
     * @throws Exception データベース操作エラー
     */
    public List<String> filter(SchoolBean school) throws Exception {
        List<String> list = new ArrayList<>();
        
        // 重複を除いたクラス番号を取得するSQL
        // 学生テーブル(STUDENT)から、その学校のクラス一覧を抽出する想定です
        String sql = "SELECT DISTINCT class_num FROM STUDENT WHERE school_cd = ? ORDER BY class_num ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, school.getCd());

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    // クラス番号をリストに追加
                    list.add(rs.getString("class_num"));
                }
            }
        } catch (Exception e) {
            throw e;
        }

        return list;
    }
}