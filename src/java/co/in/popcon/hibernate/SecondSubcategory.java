package co.in.popcon.hibernate;
// Generated Jun 3, 2016 7:34:59 PM by Hibernate Tools 4.3.1



/**
 * SecondSubcategory generated by hbm2java
 */
public class SecondSubcategory  implements java.io.Serializable {


     private Integer secondSubcategoryId;
     private FirstSubcategory firstSubcategory;
     private String name;

    public SecondSubcategory() {
    }

    public SecondSubcategory(FirstSubcategory firstSubcategory, String name) {
       this.firstSubcategory = firstSubcategory;
       this.name = name;
    }
   
    public Integer getSecondSubcategoryId() {
        return this.secondSubcategoryId;
    }
    
    public void setSecondSubcategoryId(Integer secondSubcategoryId) {
        this.secondSubcategoryId = secondSubcategoryId;
    }
    public FirstSubcategory getFirstSubcategory() {
        return this.firstSubcategory;
    }
    
    public void setFirstSubcategory(FirstSubcategory firstSubcategory) {
        this.firstSubcategory = firstSubcategory;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }




}


