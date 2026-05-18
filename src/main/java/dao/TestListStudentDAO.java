package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.StudentBean;
import bean.TestListStudentBean;

/**
 * TestListStudentDaoクラス
 * 学生ごとの成績一覧を取得するためのDAOです。
 */
public class TestListStudentDAO extends DAO {

    // 図の「- baseSql: String」
    private String baseSql = "SELECT * FROM test WHERE student_no = ?";

    /**
     * ResultSetをTestListStudentBeanのリストに変換します。
     * 図の「- postFilter(rSet: ResultSet): List<TestListStudent>」に対応
     */
    private List<TestListStudentBean> postFilter(ResultSet rSet) throws Exception {
        List<TestListStudentBean> list = new ArrayList<>();
        try {
            while (rSet.next()) {
                TestListStudentBean testListStudent = new TestListStudentBean();
                // クラス図のフィールド定義に合わせてセット
                testListStudent.setSubjectName(rSet.getString("subject_name"));
                testListStudent.setSubjectCd(rSet.getString("subject_cd"));
                testListStudent.setNum(rSet.getInt("num")); // 回数（第n回）
                testListStudent.setPoint(rSet.getInt("point")); // 得点
                
                list.add(testListStudent);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    /**
     * 特定の学生の成績一覧を取得します。
     * 図の「+ filter(student: Student): List<TestListStudent>」に対応
     */
    public List<TestListStudentBean> filter(StudentBean student) throws Exception {
        List<TestListStudentBean> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            // 基本SQLを利用して学生番号で検索
            statement = connection.prepareStatement(baseSql);
            statement.setString(1, student.getNo());

            ResultSet rSet = statement.executeQuery();
            
            // postFilterでListに変換
            list = postFilter(rSet);
            
        } catch (Exception e) {
            throw e;
        } finally {
            // リソース解放
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return list;
    }
}