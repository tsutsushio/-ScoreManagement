package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SeatBean;

public class SeatDAO extends DAO {

    public List<SeatBean> filter(String classNum, String subjectCd, int testNo) throws Exception {
        List<SeatBean> list = new ArrayList<>();
        String sql =
        	    "SELECT S.*, ST.NAME " +
        	    "FROM SEAT S " +
        	    "JOIN STUDENT ST " +
        	    "ON S.STUDENT_NO = ST.NO " +
        	    "WHERE S.CLASS_NUM = ? " +
        	    "AND S.SUBJECT_CD = ? " +
        	    "AND S.TEST_NO = ? " +
        	    "ORDER BY S.ROW_NO, S.COL_NO";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, classNum);
            st.setString(2, subjectCd);
            st.setInt(3, testNo);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                	SeatBean seat = new SeatBean();

                	seat.setStudentNo(rs.getString("STUDENT_NO"));
                	seat.setStudentName(rs.getString("NAME"));   // ★追加
                	seat.setClassNum(rs.getString("CLASS_NUM"));
                	seat.setSubjectCd(rs.getString("SUBJECT_CD"));
                	seat.setTestNo(rs.getInt("TEST_NO"));
                	seat.setRowNo(rs.getInt("ROW_NO"));
                	seat.setColNo(rs.getInt("COL_NO"));

                	list.add(seat);
                }
            }
        }
        return list;
    }

    public void delete(String classNum, String subjectCd, int testNo) throws Exception {
        String sql = "DELETE FROM SEAT WHERE CLASS_NUM = ? AND SUBJECT_CD = ? AND TEST_NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, classNum);
            st.setString(2, subjectCd);
            st.setInt(3, testNo);
            st.executeUpdate();
        }
    }

    // ★ 推奨：安全に一括登録を行う save メソッド
    public boolean save(List<SeatBean> list) throws Exception {
        if (list == null || list.isEmpty()) {
            return false;
        }

        String deleteSql = "DELETE FROM SEAT WHERE CLASS_NUM = ? AND SUBJECT_CD = ? AND TEST_NO = ?";
        String insertSql = "INSERT INTO SEAT (STUDENT_NO, CLASS_NUM, SUBJECT_CD, TEST_NO, ROW_NO, COL_NO) VALUES (?, ?, ?, ?, ?, ?)";

        // 1つのConnectionを生成
        try (Connection con = getConnection()) {
            // オートコミットをオフ（トランザクション開始）
            con.setAutoCommit(false);

            try {
                // 1. 先に同じ条件の席を削除
                try (PreparedStatement deleteSt = con.prepareStatement(deleteSql)) {
                    deleteSt.setString(1, list.get(0).getClassNum());
                    deleteSt.setString(2, list.get(0).getSubjectCd());
                    deleteSt.setInt(3, list.get(0).getTestNo());
                    deleteSt.executeUpdate();
                }

                // 2. まとめてインサート（バッチ処理）
                try (PreparedStatement insertSt = con.prepareStatement(insertSql)) {
                    for (SeatBean seat : list) {
                        insertSt.setString(1, seat.getStudentNo());
                        insertSt.setString(2, seat.getClassNum());
                        insertSt.setString(3, seat.getSubjectCd());
                        insertSt.setInt(4, seat.getTestNo());
                        insertSt.setInt(5, seat.getRowNo());
                        insertSt.setInt(6, seat.getColNo());
                        insertSt.addBatch(); // バッチに追加
                    }
                    insertSt.executeBatch(); // まとめて実行
                }

                // すべて成功したら確定
                con.commit();
                return true;

            } catch (Exception e) {
                // 途中でエラーが起きたら完全に元の状態に戻す
                con.rollback();
                throw e;
            }
        }
    }
    
}
