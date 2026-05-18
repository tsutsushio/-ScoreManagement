package bean;

import java.io.Serializable;
<<<<<<< HEAD

public class TestBean implements Serializable {
=======
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

public class TestBean implements Serializable {

    private StudentBean student;
    private String classNum;
    private SubjectBean subject;
    private SchoolBean school;
    private int no;
    private int point;
<<<<<<< HEAD
    private String classNum;
    
    // 画面表示用などの追加フィールド
    private String studentName;
    private int entYear;
=======

    public StudentBean getStudent() { return student; }
    public void setStudent(StudentBean student) { this.student = student; }
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

<<<<<<< HEAD
    // =========================================
    // ゲッター・セッター
    // =========================================

    public String getStudentNo() {
        return studentNo;
    }
=======
    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

<<<<<<< HEAD
    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }
=======
    public SubjectBean getSubject() { return subject; }
    public void setSubject(SubjectBean subject) { this.subject = subject; }
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

    public SchoolBean getSchool() { return school; }
    public void setSchool(SchoolBean school) { this.school = school; }

<<<<<<< HEAD
    public void setSubjectCd(String subjectCd) {
        this.subjectCd = subjectCd;
    }
=======
    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git

<<<<<<< HEAD
    public String getSchoolCd() {
        return schoolCd;
    }

    public void setSchoolCd(String schoolCd) {
        this.schoolCd = schoolCd;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public String getClassNum() {
        return classNum;
    }

    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public int getEntYear() {
        return entYear;
    }

    public void setEntYear(int entYear) {
        this.entYear = entYear;
    }
=======
    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
>>>>>>> branch 'main' of https://github.com/tsutsushio/-ScoreManagement.git
}