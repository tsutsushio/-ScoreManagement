package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.SchoolBean;
import bean.SubjectBean;

public class SubjectDAO extends DAO {

    /**
     * 【追加】クラス図: get(cd: String, school: School): Subject
     * 学校と科目コードを指定して1件取得する
     */
    public SubjectBean get(String cd, SchoolBean school) throws Exception {
        SubjectBean subject = null;
        Connection con = getConnection();
        
        try {
            String sql = "SELECT CD, NAME FROM SUBJECT WHERE CD = ? AND SCHOOL_CD = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, cd);
            st.setString(2, school.getCd());
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                subject = new SubjectBean();
                subject.setCd(rs.getString("CD"));
                subject.setName(rs.getString("NAME"));
                subject.setSchoolCd(school.getCd()); 
            }

            rs.close();
            st.close();
        } finally {
            con.close();
        }
        return subject;
    }

    /**
     * 【追加】クラス図: filter(school: School): List<Subject>
     * 特定の学校に紐づく科目一覧を取得する (引数: SchoolBean)
     */
    public List<SubjectBean> filter(SchoolBean school) throws Exception {
        // 既存のString引数のfilterメソッドを呼び出して再利用
        return filter(school.getCd());
    }

    /**
     * 学校ごとの科目一覧取得 (引数: String)
     */
    public List<SubjectBean> filter(String schoolCd) throws Exception {
        List<SubjectBean> list = new ArrayList<>();
        Connection con = getConnection();

        try {
            String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT WHERE SCHOOL_CD = ? ORDER BY CD ASC";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, schoolCd);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                SubjectBean subject = new SubjectBean();
                subject.setSchoolCd(rs.getString("SCHOOL_CD"));
                subject.setCd(rs.getString("CD"));
                subject.setName(rs.getString("NAME"));
                list.add(subject);
            }
            rs.close();
            st.close();
        } finally {
            con.close();
        }

        return list;
    }

    /**
     * 【追加】クラス図: save(subject: Subject): boolean
     * 存在すれば更新、なければ登録を行う
     */
    public boolean save(SubjectBean subject) throws Exception {
        Connection con = getConnection();
        boolean exists = false;
        
        try {
            // DB接続して存在確認
            String checkSql = "SELECT COUNT(*) FROM SUBJECT WHERE CD = ? AND SCHOOL_CD = ?";
            PreparedStatement stCheck = con.prepareStatement(checkSql);
            stCheck.setString(1, subject.getCd());
            stCheck.setString(2, subject.getSchoolCd());
            ResultSet rs = stCheck.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                exists = true;
            }
            rs.close();
            stCheck.close();
        } finally {
            con.close();
        }

        // 存在する場合は既存のupdateメソッドを呼ぶ
        if (exists) {
            return update(subject);
        } else {
            // 新規登録
            Connection conInsert = getConnection();
            try {
                String sql = "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";
                PreparedStatement st = conInsert.prepareStatement(sql);
                st.setString(1, subject.getSchoolCd());
                st.setString(2, subject.getCd());
                st.setString(3, subject.getName());
                int count = st.executeUpdate();
                st.close();
                return count > 0;
            } finally {
                conInsert.close();
            }
        }
    }

    /**
     * 更新 (既存メソッドを綺麗に維持)
     */
    public boolean update(SubjectBean subject) throws Exception {
        Connection con = getConnection();
        try {
            String sql = "UPDATE SUBJECT SET NAME = ? WHERE SCHOOL_CD = ? AND CD = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, subject.getName());
            st.setString(2, subject.getSchoolCd());
            st.setString(3, subject.getCd());

            int count = st.executeUpdate();
            st.close();
            return count > 0;
        } finally {
            con.close();
        }
    }

    /**
     * 【追加】クラス図: delete(subject: Subject): boolean
     * データを削除する (引数: SubjectBean)
     */
    public boolean delete(SubjectBean subject) throws Exception {
        // 既存の引数2つのdeleteメソッドを呼び出し、TESTテーブルの整合性も守る
        return delete(subject.getCd(), subject.getSchoolCd());
    }

    /**
     * 削除 (既存のTESTテーブル連動削除ロジックをベースに維持)
     */
    public boolean delete(String cd, String schoolCd) throws Exception {
        Connection con = getConnection();

        try {
            // TESTテーブルの関連データを先に削除（整合性維持）
            String sql1 = "DELETE FROM TEST WHERE SCHOOL_CD = ? AND SUBJECT_CD = ?";
            PreparedStatement st1 = con.prepareStatement(sql1);
            st1.setString(1, schoolCd);
            st1.setString(2, cd);
            st1.executeUpdate();
            st1.close();

            // SUBJECTテーブルから科目を削除
            String sql2 = "DELETE FROM SUBJECT WHERE SCHOOL_CD = ? AND CD = ?";
            PreparedStatement st2 = con.prepareStatement(sql2);
            st2.setString(1, schoolCd);
            st2.setString(2, cd);
            int count = st2.executeUpdate();
            st2.close();

            return count > 0;
        } finally {
            con.close();
        }
    }
    
    public int insert(SubjectBean subject) throws Exception{
    	Connection con = getConnection();
    	String sql = "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";
    	PreparedStatement st = con.prepareStatement(sql);
    	st.setString(1, subject.getSchoolCd());
    	st.setString(2, subject.getCd());
    	st.setString(3, subject.getName());
    	
    	int count = st.executeUpdate();
    	
    	st.close();
    	con.close();
    	
    	return count;
    }
    public List<SubjectBean> list() throws Exception {
    	List<SubjectBean> list = new ArrayList<> ();
    	Connection con = getConnection();
    	String sql = "SELECT SCHOOL_CD, CD, NAME FROM SUBJECT ORDER BY CD";
    	PreparedStatement st = con.prepareStatement(sql);
    	ResultSet rs = st.executeQuery();
    	while (rs.next()) {
    		SubjectBean subject = new SubjectBean();
    		subject.setSchoolCd(rs.getString("SCHOOL_CD"));
    				subject.setCd(rs.getString("CD"));
    				subject.setName(rs.getString("NAME"));
    				list.add(subject);
    	}
    	rs.close();
    	st.close();
    	con.close();
    	
    	return list;
    	}
    }