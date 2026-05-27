package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.StudentBean;
import bean.SubjectBean;
import bean.TestBean;

public class TestDAO extends DAO {

    // =========================================================
    // ベースSQL・共通処理
    // =========================================================

    private String baseSql =
            "SELECT * FROM TEST ";

    private List<TestBean> postFilter(
            ResultSet rSet,
            SchoolBean school
    ) throws Exception {

        List<TestBean> list =
                new ArrayList<>();

        while (rSet.next()) {

            TestBean test =
                    new TestBean();

            test.setNo(
                rSet.getInt("NO")
            );

            test.setPoint(
                rSet.getInt("POINT")
            );

            test.setClassNum(
                rSet.getString(
                    "CLASS_NUM"
                )
            );

            test.setSchool(
                school
            );

            StudentBean student =
                    new StudentBean();

            student.setNo(
                rSet.getString(
                    "STUDENT_NO"
                )
            );

            test.setStudent(
                student
            );

            SubjectBean subject =
                    new SubjectBean();

            subject.setCd(
                rSet.getString(
                    "SUBJECT_CD"
                )
            );

            test.setSubject(
                subject
            );

            list.add(test);
        }

        return list;
    }

    // =========================================================
    // 1件取得
    // =========================================================

    public TestBean get(
            StudentBean student,
            SubjectBean subject,
            SchoolBean school,
            int no
    ) throws Exception {

        TestBean test = null;

        String sql =
            baseSql
            + "WHERE STUDENT_NO = ? "
            + "AND SUBJECT_CD = ? "
            + "AND SCHOOL_CD = ? "
            + "AND NO = ?";

        try (
            Connection con =
                getConnection();

            PreparedStatement st =
                con.prepareStatement(
                    sql
                )
        ) {

            st.setString(
                1,
                student.getNo()
            );

            st.setString(
                2,
                subject.getCd()
            );

            st.setString(
                3,
                school.getCd()
            );

            st.setInt(
                4,
                no
            );

            try (
                ResultSet rs =
                    st.executeQuery()
            ) {

                List<TestBean> list =
                        postFilter(
                            rs,
                            school
                        );

                if (
                    !list.isEmpty()
                ) {

                    test =
                        list.get(0);
                }
            }
        }

        return test;
    }

    // =========================================================
    // 条件検索
    // =========================================================

    public List<TestBean> filter(
            int entYear,
            String classNum,
            SubjectBean subject,
            int num,
            SchoolBean school
    ) throws Exception {

        List<TestBean> list =
                new ArrayList<>();

        String sql =
            baseSql
            + "WHERE SCHOOL_CD = ?";

        if (
            subject != null
            && subject.getCd() != null
        ) {

            sql +=
                " AND SUBJECT_CD = ?";
        }

        if (num > 0) {

            sql +=
                " AND NO = ?";
        }

        try (
            Connection con =
                getConnection();

            PreparedStatement st =
                con.prepareStatement(
                    sql
                )
        ) {

            int idx = 1;

            st.setString(
                idx++,
                school.getCd()
            );

            if (
                subject != null
                && subject.getCd() != null
            ) {

                st.setString(
                    idx++,
                    subject.getCd()
                );
            }

            if (num > 0) {

                st.setInt(
                    idx++,
                    num
                );
            }

            try (
                ResultSet rs =
                    st.executeQuery()
            ) {

                list =
                    postFilter(
                        rs,
                        school
                    );
            }
        }

        return list;
    }

    // =========================================================
    // 科目検索
    // =========================================================

    public List<TestBean> searchBySubject(
            int entYear,
            String classNum,
            String subjectCd,
            SchoolBean school
    ) throws Exception {

        List<TestBean> list =
                new ArrayList<>();

        String sql =
            "SELECT * FROM TEST "
          + "WHERE SCHOOL_CD = ? "
          + "AND CLASS_NUM = ? "
          + "AND SUBJECT_CD = ?";

        try (
            Connection con =
                getConnection();

            PreparedStatement st =
                con.prepareStatement(
                    sql
                )
        ) {

            st.setString(
                1,
                school.getCd()
            );

            st.setString(
                2,
                classNum
            );

            st.setString(
                3,
                subjectCd
            );

            try (
                ResultSet rs =
                    st.executeQuery()
            ) {

                list =
                    postFilter(
                        rs,
                        school
                    );
            }
        }

        return list;
    }

    // =========================================================
    // 最新成績取得
    // =========================================================

    public List<TestBean> getLatestScores(
            String studentNo
    ) throws Exception {

        List<TestBean> list =
                new ArrayList<>();

        String sql =
            "SELECT T.*, S.NAME AS SUBJECT_NAME "
          + "FROM TEST T "
          + "JOIN SUBJECT S "
          + "ON T.SUBJECT_CD = S.CD "
          + "AND T.SCHOOL_CD = S.SCHOOL_CD "
          + "WHERE T.STUDENT_NO = ? "
          + "AND T.NO = ("
          + "SELECT MAX(NO) "
          + "FROM TEST "
          + "WHERE STUDENT_NO = ?"
          + ")";

        try (
            Connection con =
                getConnection();

            PreparedStatement st =
                con.prepareStatement(
                    sql
                )
        ) {

            st.setString(
                1,
                studentNo
            );

            st.setString(
                2,
                studentNo
            );

            try (
                ResultSet rs =
                    st.executeQuery()
            ) {

                while (rs.next()) {

                    TestBean test =
                            new TestBean();

                    test.setNo(
                        rs.getInt("NO")
                    );

                    test.setPoint(
                        rs.getInt("POINT")
                    );

                    test.setClassNum(
                        rs.getString(
                            "CLASS_NUM"
                        )
                    );

                    SubjectBean subject =
                            new SubjectBean();

                    subject.setCd(
                        rs.getString(
                            "SUBJECT_CD"
                        )
                    );

                    subject.setName(
                        rs.getString(
                            "SUBJECT_NAME"
                        )
                    );

                    test.setSubject(
                        subject
                    );

                    list.add(test);
                }
            }
        }

        return list;
    }

    // =========================================================
    // 全成績取得
    // =========================================================

    public List<TestBean> getAllScores(
            String studentNo
    ) throws Exception {

        List<TestBean> list =
                new ArrayList<>();

        String sql =
            "SELECT T.*, S.NAME AS SUBJECT_NAME "
          + "FROM TEST T "
          + "JOIN SUBJECT S "
          + "ON T.SUBJECT_CD = S.CD "
          + "AND T.SCHOOL_CD = S.SCHOOL_CD "
          + "WHERE T.STUDENT_NO = ? "
          + "ORDER BY T.NO DESC";

        try (
            Connection con =
                getConnection();

            PreparedStatement st =
                con.prepareStatement(
                    sql
                )
        ) {

            st.setString(
                1,
                studentNo
            );

            try (
                ResultSet rs =
                    st.executeQuery()
            ) {

                while (rs.next()) {

                    TestBean test =
                            new TestBean();

                    test.setNo(
                        rs.getInt("NO")
                    );

                    test.setPoint(
                        rs.getInt("POINT")
                    );

                    test.setClassNum(
                        rs.getString(
                            "CLASS_NUM"
                        )
                    );

                    SubjectBean subject =
                            new SubjectBean();

                    subject.setCd(
                        rs.getString(
                            "SUBJECT_CD"
                        )
                    );

                    subject.setName(
                        rs.getString(
                            "SUBJECT_NAME"
                        )
                    );

                    test.setSubject(
                        subject
                    );

                    list.add(test);
                }
            }
        }

        return list;
    }

    // =========================================================
    // 保存
    // =========================================================

    public boolean save(
            List<TestBean> list
    ) throws Exception {

        boolean isSuccess =
                true;

        try (
            Connection con =
                getConnection()
        ) {

            con.setAutoCommit(
                false
            );

            try {

                for (
                    TestBean test
                    : list
                ) {

                    if (
                        !save(
                            test,
                            con
                        )
                    ) {

                        isSuccess =
                                false;

                        break;
                    }
                }

                if (isSuccess) {

                    con.commit();

                } else {

                    con.rollback();
                }

            } catch (Exception e) {

                con.rollback();

                throw e;
            }
        }

        return isSuccess;
    }

    private boolean save(
            TestBean test,
            Connection connection
    ) throws Exception {

        boolean isSuccess =
                false;

        TestBean existingTest =
                get(
                    test.getStudent(),
                    test.getSubject(),
                    test.getSchool(),
                    test.getNo()
                );

        String sql;

        if (
            existingTest == null
        ) {

            sql =
                "INSERT INTO TEST "
              + "(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) "
              + "VALUES (?, ?, ?, ?, ?, ?)";

        } else {

            sql =
                "UPDATE TEST "
              + "SET POINT = ?, CLASS_NUM = ? "
              + "WHERE STUDENT_NO = ? "
              + "AND SUBJECT_CD = ? "
              + "AND SCHOOL_CD = ? "
              + "AND NO = ?";
        }

        try (
            PreparedStatement st =
                connection.prepareStatement(
                    sql
                )
        ) {

            if (
                existingTest == null
            ) {

                st.setString(
                    1,
                    test.getStudent()
                        .getNo()
                );

                st.setString(
                    2,
                    test.getSubject()
                        .getCd()
                );

                st.setString(
                    3,
                    test.getSchool()
                        .getCd()
                );

                st.setInt(
                    4,
                    test.getNo()
                );

                st.setInt(
                    5,
                    test.getPoint()
                );

                st.setString(
                    6,
                    test.getClassNum()
                );

            } else {

                st.setInt(
                    1,
                    test.getPoint()
                );

                st.setString(
                    2,
                    test.getClassNum()
                );

                st.setString(
                    3,
                    test.getStudent()
                        .getNo()
                );

                st.setString(
                    4,
                    test.getSubject()
                        .getCd()
                );

                st.setString(
                    5,
                    test.getSchool()
                        .getCd()
                );

                st.setInt(
                    6,
                    test.getNo()
                );
            }

            if (
                st.executeUpdate() > 0
            ) {

                isSuccess =
                        true;
            }
        }

        return isSuccess;
    }
}