package bean;

import java.io.Serializable;

public class TestBean implements Serializable {

    // クラス図準拠の基本フィールド
    private StudentBean student;
    private String classNum;
    private SubjectBean subject;
    private SchoolBean school;
    private int no;
    private int point;

    // 🌟画面表示用の集計データ（追加フィールド）
    private int rank;           // 順位
    private int maxPoint;       // 最高点
    private double averagePoint;// 平均点
    private Integer point1;
    private Integer point2;

    // --- 基本のゲッター・セッター ---
    public StudentBean getStudent() { return student; }
    public void setStudent(StudentBean student) { this.student = student; }

    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }

    public SubjectBean getSubject() { return subject; }
    public void setSubject(SubjectBean subject) { this.subject = subject; }

    public SchoolBean getSchool() { return school; }
    public void setSchool(SchoolBean school) { this.school = school; }

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
    
    public Integer getPoint1() {
        return point1;
    }

    public void setPoint1(Integer point1) {
        this.point1 = point1;
    }

    public Integer getPoint2() {
        return point2;
    }

    public void setPoint2(Integer point2) {
        this.point2 = point2;
    }
}