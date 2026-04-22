package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;

public class StudentDAO extends DAO {

    // =========================================================
    // 【一覧取得】指定された条件で学生リストを取得するメソッド
    // ※今回は画面の仕様に合わせて、すべての条件を受け取るこのメソッドをメインで使います
    // =========================================================
    public List<StudentBean> filter(String schoolCd, int entYear, String classNum, boolean isAttend) throws Exception {
        
        // 戻り値となるリストを準備
        List<StudentBean> list = new ArrayList<>();
        
        // 基本となるSQL文（WHERE句の1つ目は学校コードで固定）
        String sql = "SELECT * FROM STUDENT WHERE SCHOOL_CD = ?";

        // 検索条件（entYear, classNum）が指定されている場合、SQLに条件を付け足す
        // （※entYearが0の場合は「指定なし」、classNumが"--------"等の場合は「指定なし」とみなす設計）
        if (entYear > 0) {
            sql += " AND ENT_YEAR = ?";
        }
        // classNumがnullではなく、かつ"--------"（指定なしを表す値）ではない場合
        if (classNum != null && !classNum.equals("--------") && !classNum.isEmpty()) {
            sql += " AND CLASS_NUM = ?";
        }
        
        // 在学中フラグの条件を付け足す（画面のチェックボックス用）
        if (isAttend == true) {
            sql += " AND IS_ATTEND = TRUE";
        } else {
            // もし「退学者も含める」ような仕様にしたい場合はここを書き換えますが、
            // 今回は boolean のため、とりあえずそのままにしておきます（必要に応じて調整）
        }

        // データベース接続
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            // ？（プレースホルダ）に値をセットしていく
            int parameterIndex = 1; // 何番目の？にセットするかを管理する変数
            
            // 1番目は必ず学校コード
            st.setString(parameterIndex++, schoolCd);
            
            // もしSQLに ENT_YEAR を足していたら、その値をセット
            if (entYear > 0) {
                st.setInt(parameterIndex++, entYear);
            }
            // もしSQLに CLASS_NUM を足していたら、その値をセット
            if (classNum != null && !classNum.equals("--------") && !classNum.isEmpty()) {
                st.setString(parameterIndex++, classNum);
            }

            // SQL実行
            try (ResultSet rs = st.executeQuery()) {
                // 結果が複数あるので、whileで回してリストに追加していく
                while (rs.next()) {
                    StudentBean student = new StudentBean();
                    student.setNo(rs.getString("NO"));
                    student.setName(rs.getString("NAME"));
                    student.setEntYear(rs.getInt("ENT_YEAR"));
                    student.setClassNum(rs.getString("CLASS_NUM"));
                    student.setIsAttend(rs.getBoolean("IS_ATTEND"));
                    
                    SchoolBean school = new SchoolBean();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    student.setSchool(school);
                    
                    // リストに追加
                    list.add(student);
                }
            }
        }
        
        return list;
    }

    // =========================================================
    // 【1件取得】学生番号(NO)をキーに学生データを1件取得するメソッド
    // （※成績登録画面など、特定の学生を指定する際に使います）
    // =========================================================
    public StudentBean get(String no) throws Exception {
        StudentBean student = null;
        
        String sql = "SELECT * FROM STUDENT WHERE NO = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, no);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    student = new StudentBean();
                    student.setNo(rs.getString("NO"));
                    student.setName(rs.getString("NAME"));
                    student.setEntYear(rs.getInt("ENT_YEAR"));
                    student.setClassNum(rs.getString("CLASS_NUM"));
                    student.setIsAttend(rs.getBoolean("IS_ATTEND"));
                    
                    SchoolBean school = new SchoolBean();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    student.setSchool(school);
                }
            }
        }
        return student;
    }
    
 // =========================================================
    // 【登録・更新】学生データを保存するメソッド
    // （※データがなければ新規登録(INSERT)、あれば更新(UPDATE)を行う）
    // =========================================================
    public boolean save(StudentBean student) throws Exception {
        boolean isSuccess = false;
        
        // 1. 渡された学生番号(NO)のデータが既に存在するかチェック
        StudentBean existingStudent = get(student.getNo());
        
        String sql = "";
        
        try (Connection con = getConnection()) {
            
            PreparedStatement st = null;
            
            if (existingStudent == null) {
                // -------------------------------------------
                // データが存在しない場合：新規登録（INSERT）
                // -------------------------------------------
                sql = "INSERT INTO STUDENT (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
                st = con.prepareStatement(sql);
                
                st.setString(1, student.getNo());
                st.setString(2, student.getName());
                st.setInt(3, student.getEntYear());
                st.setString(4, student.getClassNum());
                st.setBoolean(5, student.getIsAttend());
                st.setString(6, student.getSchool().getCd());
                
            } else {
                // -------------------------------------------
                // データが存在する場合：情報の更新（UPDATE）
                // -------------------------------------------
                sql = "UPDATE STUDENT SET NAME = ?, ENT_YEAR = ?, CLASS_NUM = ?, IS_ATTEND = ?, SCHOOL_CD = ? WHERE NO = ?";
                st = con.prepareStatement(sql);
                
                st.setString(1, student.getName());
                st.setInt(2, student.getEntYear());
                st.setString(3, student.getClassNum());
                st.setBoolean(4, student.getIsAttend());
                st.setString(5, student.getSchool().getCd());
                st.setString(6, student.getNo()); // WHERE句の条件
            }
            
            // SQLを実行する
            // executeUpdate() は、変更が成功した「行数」を返します
            int result = st.executeUpdate();
            
            // 1行以上変更されていれば成功
            if (result > 0) {
                isSuccess = true;
            }
            
            st.close();
        }
        
        return isSuccess;
    }
}