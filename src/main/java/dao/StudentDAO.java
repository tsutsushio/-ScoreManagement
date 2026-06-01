package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;

public class StudentDAO extends DAO {

    /**
     * 【1件取得】学生番号(NO)をキーに学生データを1件取得するメソッド
     */
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
                    student.setPassword(rs.getString("PASSWORD")); 
                    
                    SchoolBean school = new SchoolBean();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    student.setSchool(school);
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return student;
    }

    /**
     * 【一覧取得】指定された条件で学生リストを取得するメソッド
     */
    public List<StudentBean> filter(SchoolBean school, int entYear, String classNum, boolean isAttend) throws Exception {
        List<StudentBean> list = new ArrayList<>();
        String sql = "SELECT * FROM STUDENT WHERE SCHOOL_CD = ?";

        if (entYear > 0) {
            sql += " AND ENT_YEAR = ?";
        }
        if (classNum != null && !classNum.equals("--------") && !classNum.isEmpty()) {
            sql += " AND CLASS_NUM = ?";
        }
        if (isAttend) {
            sql += " AND IS_ATTEND = TRUE";
        }
        sql += " ORDER BY NO ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            int parameterIndex = 1;
            st.setString(parameterIndex++, school.getCd());
            
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
                    
                    student.setSchool(school);
                    list.add(student);
                }
            }
        }
        return list;
    }

    /**
     * 【登録・更新】学生データを保存するメソッド
     */
    public boolean save(StudentBean student) throws Exception {
        boolean isSuccess = false;
        StudentBean existingStudent = get(student.getNo());
        String sql = "";
        
        try (Connection con = getConnection()) {
            PreparedStatement st = null;
            
            if (existingStudent == null) {
                // 新規登録
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
                // 更新
                sql = "UPDATE STUDENT SET NAME = ?, ENT_YEAR = ?, CLASS_NUM = ?, IS_ATTEND = ?, SCHOOL_CD = ? WHERE NO = ?";
                st = con.prepareStatement(sql);
                st.setString(1, student.getName());
                st.setInt(2, student.getEntYear());
                st.setString(3, student.getClassNum());
                st.setBoolean(4, student.getIsAttend());
                st.setString(5, student.getSchool().getCd());
                st.setString(6, student.getNo());
            }

            int result = st.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return isSuccess;
    }

    /**
     * 【削除】学生データをデータベースから削除するメソッド
     */
    public boolean delete(StudentBean student) throws Exception {
        boolean isSuccess = false;
        String sql = "DELETE FROM STUDENT WHERE NO = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, student.getNo());
            int result = st.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }
        }
        return isSuccess;
    }

    /**
     * 【学生用】ログイン認証を行うメソッド
     */
    public StudentBean login(String no, String password) throws Exception {
        StudentBean student = null;
        String sql = "SELECT * FROM STUDENT WHERE NO = ? AND PASSWORD = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, no);
            st.setString(2, password);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
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
        return student;
    }

	public List<StudentBean> filter(String schoolCd, int entYear, String classNum, boolean isAttend) throws Exception {
		SchoolBean school = new SchoolBean();
		school.setCd(schoolCd);
		// TODO 自動生成されたメソッド・スタブ
		return filter(school, entYear, classNum, isAttend);
	}
	
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
}