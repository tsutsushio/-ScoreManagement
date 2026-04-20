package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.SchoolBean;
import bean.TeacherBean;

public class TeacherDAO extends DAO {
    
    // =========================================================
    // ログイン処理メソッド
    // =========================================================
    public TeacherBean login(String id, String password) throws Exception {
        TeacherBean teacher = null;
        
        // SQL文を定数化（またはそのまま書いてもOK）
        String sql = "SELECT * FROM TEACHER WHERE ID = ? AND PASSWORD = ?";

        // try-with-resources 文
        // () の中で宣言したリソース(Connection, PreparedStatement)は、
        // tryブロックを抜ける時に自動的にclose()されます！
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            // パラメータのセット
            st.setString(1, id);
            st.setString(2, password);
            
            // ResultSet も close が必要なので、ここでさらに try-with-resources
            try (ResultSet rs = st.executeQuery()) {
                
                // データが見つかった場合の処理
                if (rs.next()) {
                    teacher = new TeacherBean(); 
                    teacher.setId(rs.getString("ID"));
                    teacher.setPassword(rs.getString("PASSWORD"));
                    teacher.setName(rs.getString("NAME"));
                    
                    SchoolBean school = new SchoolBean();
                    school.setCd(rs.getString("SCHOOL_CD")); 
                    teacher.setSchool(school);
                }
            } // ここで rs.close() が自動実行される
            
        } // ここで st.close() と con.close() が自動実行される（エラーが起きても必ず実行される）
        
        return teacher;
    }
}