package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;

public class ClassNumDAO extends DAO {

    public List<String> filter(
            SchoolBean school)
            throws Exception {

        List<String> list =
            new ArrayList<>();

        String sql =
            "SELECT DISTINCT CLASS_NUM " +
            "FROM STUDENT " +
            "WHERE SCHOOL_CD = ? " +
            "ORDER BY CLASS_NUM";

        try (
            Connection con =
                getConnection();

            PreparedStatement st =
                con.prepareStatement(sql)
        ) {

            st.setString(
                1,
                school.getCd()
            );

            try (
                ResultSet rs =
                    st.executeQuery()
            ) {

                while (rs.next()) {

                    list.add(
                        rs.getString(
                            "CLASS_NUM"
                        )
                    );
                }
            }
        }

        return list;
    }
}