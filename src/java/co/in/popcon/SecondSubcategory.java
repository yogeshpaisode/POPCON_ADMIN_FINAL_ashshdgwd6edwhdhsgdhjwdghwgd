package co.in.popcon;
// Generated May 29, 2016 4:19:38 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * SecondSubcategory generated by hbm2java
 */
public class SecondSubcategory  implements java.io.Serializable {


     private int id;
     private FirstSubcategory firstSubcategory;
     private String name;
     private Set<ProductDetail> productDetails = new HashSet<ProductDetail>(0);

    public SecondSubcategory() {
    }

	
    public SecondSubcategory(int id, FirstSubcategory firstSubcategory, String name) {
        this.id = id;
        this.firstSubcategory = firstSubcategory;
        this.name = name;
    }
    public SecondSubcategory(int id, FirstSubcategory firstSubcategory, String name, Set<ProductDetail> productDetails) {
       this.id = id;
       this.firstSubcategory = firstSubcategory;
       this.name = name;
       this.productDetails = productDetails;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
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
    public Set<ProductDetail> getProductDetails() {
        return this.productDetails;
    }
    
    public void setProductDetails(Set<ProductDetail> productDetails) {
        this.productDetails = productDetails;
    }




}


