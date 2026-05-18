package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean;
import bean.TestListSubjectBean;

/**
 * TestListSubjectDaoクラス
 * 科目ごとの成績一覧を取得するためのDAOです。
 */
public class TestListSubjectDAO extends DAO {

    // 図の「- baseSql: String」
    private String baseSql = "SELECT * FROM test WHERE ent_year=? AND class_num=? AND subject_cd=? AND school_cd=?";

    /**
     * ResultSetをTestListSubjectBeanのリストに変換します。
     * 図の「- postFilter(rSet: ResultSet): List<TestListSubject>」に対応
     */
    private List<TestListSubjectBean> postFilter(ResultSet rSet) throws Exception {
        List<TestListSubjectBean> list = new ArrayList<>();
        try {
            while (rSet.next()) {
                TestListSubjectBean testListSubject = new TestListSubjectBean();
                // 以下、Beanのフィールドに合わせてセット
                testListSubject.setEntYear(rSet.getInt("ent_year"));
                testListSubject.setStudentNo(rSet.getString("student_no"));
                testListSubject.setStudentName(rSet.getString("student_name"));
                testListSubject.setClassNum(rSet.getString("class_num"));
                // 点数は回数(Integer)と得点(Integer)のMapとして処理する設計（図より）
                testListSubject.putPoint(rSet.getInt("no"), rSet.getInt("point"));
                
                list.add(testListSubject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    /**
     * 指定された条件で科目別成績一覧を取得します。
     * 図の「+ filter(entYear: int, classNum: String, subject: Subject, school: School): List<TestListSubject>」に対応
     */
    public List<TestListSubjectBean> filter(int entYear, String classNum, SubjectBean subject, SchoolBean school) throws Exception {
        List<TestListSubjectBean> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(baseSql);
            statement.setInt(1, entYear);
            statement.setString(2, classNum);
            statement.setString(3, subject.getCd());
            statement.setString(4, school.getCd());

            ResultSet rSet = statement.executeQuery();
            list = postFilter(rSet);
        } catch (Exception e) {
            throw e;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return list;
    }
}