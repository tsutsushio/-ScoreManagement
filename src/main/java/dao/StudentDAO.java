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

    private String baseSql = "select * from student where school_cd=?";

    public StudentBean get(String no) throws Exception {
        StudentBean student = null;
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement("select * from student where no=?");
            statement.setString(1, no);
            ResultSet rSet = statement.executeQuery();

            // 学校情報の取得（本来は該当する学校をセットすべきですが、型合わせのため生成）
            SchoolBean school = new SchoolBean(); 

            List<StudentBean> list = postFilter(rSet, school);
            if (list.size() > 0) {
                student = list.get(0);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return student;
    }

    /**
     * 引数の型を School -> SchoolBean に修正しました
     */
    private List<StudentBean> postFilter(ResultSet rSet, SchoolBean school) throws Exception {
        List<StudentBean> list = new ArrayList<>();
        try {
            while (rSet.next()) {
                StudentBean student = new StudentBean();
                student.setNo(rSet.getString("no"));
                student.setName(rSet.getString("name"));
                student.setEntYear(rSet.getInt("ent_year"));
                student.setClassNum(rSet.getString("class_num"));
                student.setIsAttend(rSet.getBoolean("is_attend"));
                student.setSchool(school);
                list.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    public List<StudentBean> filter(SchoolBean school, int entYear, String classNum, boolean isAttend) throws Exception {
        List<StudentBean> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        String condition = " and ent_year=? and class_num=?";
        String order = " order by no asc";
        String attendCondition = isAttend ? " and is_attend=true" : "";

        try {
            statement = connection.prepareStatement(baseSql + condition + attendCondition + order);
            statement.setString(1, school.getCd());
            statement.setInt(2, entYear);
            statement.setString(3, classNum);

            ResultSet rSet = statement.executeQuery();
            list = postFilter(rSet, school);
        } catch (Exception e) {
            throw e;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return list;
    }

    /**
     * 引数の型を Student -> StudentBean に修正しました
     */
    public boolean save(StudentBean student) throws Exception {
        return true; 
    }

    /**
     * 引数の型を Student -> StudentBean に修正しました
     */
    public boolean delete(StudentBean student) throws Exception {
        return true;
    }
}