package bean;

import java.io.Serializable;

public class TestBean implements Serializable {

    // クラス図準拠の基本フィールド
    private StudentBean student;

    private String classNum;
    private String subjectCd;
    private String schoolCd;
    private int no;
    private int point;
    
    // 画面表示用などの追加フィールド
    private String studentName;
    private int entYear;

    // 🌟画面表示用の集計データ（追加フィールド）
    private int rank;           // 順位
    private int maxPoint;       // 最高点
    private double averagePoint;// 平均点

    // --- 基本のゲッター・セッター ---
    public StudentBean getStudent() { return student; }
    public void setStudent(StudentBean student) { this.student = student; }

    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }

    public String getSubjectCd() { return subjectCd; }
    public void setSubjectCd(String subjectCd) { this.subjectCd = subjectCd;}

    public String getSchoolCd() { return schoolCd; }
    public void setSchoolCd(String schoolCd) { this.schoolCd = schoolCd; }

    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }

    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }


    public int getRank() { return rank; }
    public void setRank(int rank) { this.rank = rank; }

    public int getMaxPoint() { return maxPoint; }
    public void setMaxPoint(int maxPoint) { this.maxPoint = maxPoint; }

    public double getAveragePoint() { return averagePoint; }
    public void setAveragePoint(double averagePoint) { this.averagePoint = averagePoint; }
}