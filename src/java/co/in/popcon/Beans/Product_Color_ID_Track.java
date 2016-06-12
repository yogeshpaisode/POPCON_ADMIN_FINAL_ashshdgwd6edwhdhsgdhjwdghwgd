/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.Beans;
import co.in.popcon.hibernate.ProductByColor;

/**
 *
 * @author yogeshpaisode
 */
public class Product_Color_ID_Track {
    private String name;
    private ProductByColor byColor;

    public Product_Color_ID_Track(String name, ProductByColor byColor) {
        this.name = name;
        this.byColor = byColor;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ProductByColor getByColor() {
        return byColor;
    }

    public void setByColor(ProductByColor byColor) {
        this.byColor = byColor;
    }
}
