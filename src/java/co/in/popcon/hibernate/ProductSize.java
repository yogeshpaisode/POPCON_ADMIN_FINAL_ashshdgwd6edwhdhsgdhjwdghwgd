package co.in.popcon.hibernate;
// Generated May 29, 2016 6:12:54 PM by Hibernate Tools 4.3.1



/**
 * ProductSize generated by hbm2java
 */
public class ProductSize  implements java.io.Serializable {


     private Integer id;
     private int productDetailId;
     private String sizeName;

    public ProductSize() {
    }

    public ProductSize(int productDetailId, String sizeName) {
       this.productDetailId = productDetailId;
       this.sizeName = sizeName;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public int getProductDetailId() {
        return this.productDetailId;
    }
    
    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }
    public String getSizeName() {
        return this.sizeName;
    }
    
    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }




}

