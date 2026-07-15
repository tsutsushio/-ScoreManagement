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
    // =========================================================
    public List<StudentBean> filter(String schoolCd, int entYear, String classNum, boolean isAttend) throws Exception {
        List<StudentBean> list = new ArrayList<>();
        String sql = "SELECT * FROM STUDENT WHERE SCHOOL_CD = ?";

        if (entYear > 0) {
            sql += " AND ENT_YEAR = ?";
        }
        if (classNum != null && !classNum.equals("--------") && !classNum.isEmpty()) {
            sql += " AND CLASS_NUM = ?";
        }
        if (isAttend == true) {
            sql += " AND IS_ATTEND = TRUE";
        }

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            int parameterIndex = 1;
            st.setString(parameterIndex++, schoolCd);
            
            if (entYear > 0) {
                st.setInt(parameterIndex++, entYear);
            }
            if (classNum != null && !classNum.equals("--------") && !classNum.isEmpty()) {
                st.setString(parameterIndex++, classNum);
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    StudentBean student = new StudentBean();
                    student.setNo(rs.getString("NO"));
                    student.setName(rs.getString("NAME"));
                    student.setEntYear(rs.getInt("ENT_YEAR"));
                    student.setClassNum(rs.getString("CLASS_NUM"));
                    student.setIsAttend(rs.getBoolean("IS_ATTEND"));
                    
                    // ※一覧にはパスワードは不要なので取得していません
                    
                    SchoolBean school = new SchoolBean();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    student.setSchool(school);
                    
                    list.add(student);
                }
            }
        }
        return list;
    }

    // =========================================================
    // 【1件取得】学生番号(NO)をキーに学生データを1件取得するメソッド
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
                    
                    // Beanにパスワードを持たせるようにしたので、ここでも一応取得しておきます
                    student.setPassword(rs.getString("PASSWORD")); 
                    
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
    // =========================================================
    public boolean save(StudentBean student) throws Exception {
        
        // 🌟【例外処理 1】事前バリデーション（実行前チェック）
    	if (student.getNo() != null && student.getNo().length() > 10) {
            throw new Exception("学生番号が長すぎます。10文字以内で入力してください。");
        }
        if (student.getName() != null && student.getName().length() > 10) {
            throw new Exception("生徒の名前が長すぎます。10文字以内で入力してください。");
        }

        boolean isSuccess = false;
        StudentBean existingStudent = get(student.getNo());
        String sql = "";
        
        try (Connection con = getConnection()) {
            PreparedStatement st = null;
            
            if (existingStudent == null) {
                // 【新規登録】パスワードも一緒に登録する
                sql = "INSERT INTO STUDENT (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD, PASSWORD) VALUES (?, ?, ?, ?, ?, ?, ?)";
                st = con.prepareStatement(sql);
                
                st.setString(1, student.getNo());
                st.setString(2, student.getName());
                st.setInt(3, student.getEntYear());
                st.setString(4, student.getClassNum());
                st.setBoolean(5, student.getIsAttend());
                st.setString(6, student.getSchool().getCd());
                st.setString(7, student.getPassword());
                
            } else {
                // 【更新】教員が編集する際は、パスワードは上書きしない（セキュリティ対策）
                sql = "UPDATE STUDENT SET NAME = ?, ENT_YEAR = ?, CLASS_NUM = ?, IS_ATTEND = ?, SCHOOL_CD = ? WHERE NO = ?";
                st = con.prepareStatement(sql);
                
                st.setString(1, student.getName());
                st.setInt(2, student.getEntYear());
                st.setString(3, student.getClassNum());
                st.setBoolean(4, student.getIsAttend());
                st.setString(5, student.getSchool().getCd());
                st.setString(6, student.getNo());
            }
            
            // 🌟【例外処理 2】SQL実行時のエラーキャッチ
            try {
                int result = st.executeUpdate();
                if (result > 0) {
                    isSuccess = true;
                }
            } catch (java.sql.SQLException e) {
                // データベース側で何らかのエラー（桁あふれ、制約違反など）が起きた場合
                e.printStackTrace(); // コンソールに詳細なエラーログを残す
                throw new Exception("データベースの保存に失敗しました。入力文字数が多すぎる等の可能性があります。");
            } finally {
                // エラーが起きても起きなくても、確実にPreparedStatementを閉じる（メモリリーク防止）
                if (st != null) {
                    st.close();
                }
            }
        }
        return isSuccess;
    }
    
    // =========================================================
    // 【削除】学生データをデータベースから削除するメソッド
    // =========================================================
    public boolean delete(StudentBean student) throws Exception {
        boolean isSuccess = false;
        String no = student.getNo();
        Connection con = null;
        PreparedStatement stTest = null;
        PreparedStatement stStudent = null;

        try {
            con = getConnection();
            // トランザクション開始：自動コミットをオフにする
            con.setAutoCommit(false);

            // 1. まず、その学生に関連するテストデータを削除
            String sqlTest = "DELETE FROM TEST WHERE STUDENT_NO = ?";
            stTest = con.prepareStatement(sqlTest);
            stTest.setString(1, no);
            stTest.executeUpdate();

            // 2. 次に、学生データを削除
            String sqlStudent = "DELETE FROM STUDENT WHERE NO = ?";
            stStudent = con.prepareStatement(sqlStudent);
            stStudent.setString(1, no);
            int result = stStudent.executeUpdate();

            // 削除できたか確認（学生データが削除されたら成功）
            if (result > 0) {
                isSuccess = true;
            }

            // 全ての処理が成功したら確定（コミット）
            con.commit();

        } catch (Exception e) {
            // エラーが発生したら取り消し（ロールバック）
            if (con != null) {
                con.rollback();
            }
            throw e; // エラーを呼び出し元（Action）に伝える
        } finally {
            // リソースの解放
            if (stTest != null) stTest.close();
            if (stStudent != null) stStudent.close();
            if (con != null) {
                con.setAutoCommit(true); // 自動コミットを元に戻す
                con.close();
            }
        }
        return isSuccess;
    }

    // =========================================================
    // 【学生用】自分のパスワードだけを変更するメソッド
    // =========================================================
    public boolean updatePassword(String no, String newPassword) throws Exception {
        boolean isSuccess = false;
        // 指定された学籍番号のパスワードだけをピンポイントで書き換える
        String sql = "UPDATE STUDENT SET PASSWORD = ? WHERE NO = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, newPassword);
            st.setString(2, no);
            
            int result = st.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }
        }
        return isSuccess;
    }

    // =========================================================
    // 【学生用】ログイン認証を行うメソッド
    // =========================================================
    public StudentBean login(String no, String password) throws Exception {
        StudentBean student = null;
        // 学籍番号とパスワードの両方が完全に一致するユーザーを探す
        String sql = "SELECT * FROM STUDENT WHERE NO = ? AND PASSWORD = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, no);
            st.setString(2, password);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    // 一致するユーザーがいれば、データをBeanに詰めて返す
                    student = new StudentBean();
                    student.setNo(rs.getString("NO"));
                    student.setName(rs.getString("NAME"));
                    student.setEntYear(rs.getInt("ENT_YEAR"));
                    student.setClassNum(rs.getString("CLASS_NUM"));
                    student.setIsAttend(rs.getBoolean("IS_ATTEND"));
                    student.setPassword(rs.getString("PASSWORD"));
                    
                    SchoolBean school = new SchoolBean();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    student.setSchool(school);
                }
            }
        }
        // 一致するユーザーがいなければ null が返る（ログイン失敗）
        return student;
    }
}