package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.SchoolBean;

/**
 * SchoolDaoクラス
 * クラス図に基づき、学校情報の参照を担当します。
 */
public class SchoolDAO extends DAO {

    /**
     * 学校コードから学校情報を取得します。
     * 図の「+ get(no: String): School」に対応
     * * @param no 学校コード
     * @return Schoolオブジェクト
     * @throws Exception データベース接続やSQL実行時の例外
     */
    public SchoolBean get(String no) throws Exception {
        SchoolBean school = null;
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            // 学校コード(cd)で検索するSQL
            // クラス図では引数が(no: String)となっていますが、
            // Schoolクラスのフィールド名(cd)に合わせて検索します。
            statement = connection.prepareStatement("SELECT * FROM school WHERE cd = ?");
            statement.setString(1, no);
            
            ResultSet rSet = statement.executeQuery();

            if (rSet.next()) {
                school = new SchoolBean();
                // クラス図のSchoolクラスのフィールド（cd, name）をセット
                school.setCd(rSet.getString("cd"));
                school.setName(rSet.getString("name"));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            // リソースの解放
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return school;
    }
}