package bean;

public class TestBean {

    private String studentNo;
    private String subjectCd;
    private String schoolCd;
    private int no;
    private int point;
    private String classNum;

    // 追加
    private String studentName;
    private int entYear;

    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(
            String studentNo
    ) {
        this.studentNo =
            studentNo;
    }

    public String getSubjectCd() {
        return subjectCd;
    }

    public void setSubjectCd(
            String subjectCd
    ) {
        this.subjectCd =
            subjectCd;
    }

    public String getSchoolCd() {
        return schoolCd;
    }

    public void setSchoolCd(
            String schoolCd
    ) {
        this.schoolCd =
            schoolCd;
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

    public void setPoint(
            int point
    ) {
        this.point = point;
    }

    public String getClassNum() {
        return classNum;
    }

    public void setClassNum(
            String classNum
    ) {
        this.classNum =
            classNum;
    }

    // =====追加=====

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(
            String studentName
    ) {
        this.studentName =
            studentName;
    }

    public int getEntYear() {
        return entYear;
    }

    public void setEntYear(
            int entYear
    ) {
        this.entYear =
            entYear;
    }
}