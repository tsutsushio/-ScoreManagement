package dao;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

// DAOの共通親クラス
// データベースへの接続（コネクション）を提供する役割
public class DAO {

    // データソース（DB接続情報）
    // staticにすることで、全DAOクラスで接続プールを共有できる
    static DataSource ds;

    // データベース接続を取得するメソッド
    public Connection getConnection() throws Exception {

        // まだデータソースを取得していない場合（初回のみ実行）
        if (ds == null) {
            // ① Tomcatの設定(context.xml)を取得
            InitialContext ic = new InitialContext();

            // ② データ取得
            // ※出席管理システム用に "jdbc/exam" と命名
            ds = (DataSource) ic.lookup("java:comp/env/jdbc/test");
        }

        // データソースからDB接続を取得して返す
        return ds.getConnection();
    }
}