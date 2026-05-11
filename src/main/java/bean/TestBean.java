package bean;

import java.io.Serializable;

public class TestBean implements Serializable {
    private StudentBean student;
    private String classNum;
    private SubjectBean subject;
    private SchoolBean school;
    private int no;
    private int point;
    
    public StudentBean getStudent() {
    	return student;
    }
    public void setCd(String cd) {
    	this.student = student;
    }
    public String getClassNum() {
    	return classNum;
    }
    public void setClassNum(String classNum) {
    	this.classNum = classNum;
    }
    public SubjectBean getSubject() {
    	return subject;
    }
    public void setSubject(SubjectBean subject) {
    	this.subject = subject;
    }
    public SchoolBean getSchool() {
    	return school;
    }
    public void setSchool(SchoolBean school) {
    	this.school = school;
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
}