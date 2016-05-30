package co.in.popcon.hibernate;
// Generated May 29, 2016 6:12:54 PM by Hibernate Tools 4.3.1



/**
 * ProductByColour generated by hbm2java
 */
public class ProductByColour  implements java.io.Serializable {


     private Integer id;
     private int productDetailId;
     private String title;
     private String colourName;
     private String hexCode;

    public ProductByColour() {
    }

    public ProductByColour(int productDetailId, String title, String colourName, String hexCode) {
       this.productDetailId = productDetailId;
       this.title = title;
       this.colourName = colourName;
       this.hexCode = hexCode;
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
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    public String getColourName() {
        return this.colourName;
    }
    
    public void setColourName(String colourName) {
        this.colourName = colourName;
    }
    public String getHexCode() {
        return this.hexCode;
    }
    
    public void setHexCode(String hexCode) {
        this.hexCode = hexCode;
    }




}

