package bean;

import java.io.Serializable;

public class SubjectBean implements Serializable {
    private String cd;
    private String name;
    private SchoolBean school;
    
    public String getCd() {
    	return cd; 
    }
    public void setCd(String cd) {
    	this.cd = cd;
    }
    
    public String getName() {
    	return name;
    }
    public void setName(String name) {
    	this.name = name;
    }
    
    public SchoolBean getSchool() {
    	return school;
    }
    public void setSchool(SchoolBean school) {
    	this.school = school;
    }
    
    
    
}