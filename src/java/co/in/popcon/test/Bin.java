/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.test;

/**
 *
 * @author yogeshpaisode
 */
public class Bin {
    private String name="";
    private String mainCategoryId="";
    private int firstSubcategoryId=0;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMainCategoryId() {
        return mainCategoryId;
    }

    public void setMainCategoryId(String mainCategoryId) {
        this.mainCategoryId = mainCategoryId;
    }

    public int getFirstSubcategoryId() {
        return firstSubcategoryId;
    }

    public void setFirstSubcategoryId(int firstSubcategoryId) {
        this.firstSubcategoryId = firstSubcategoryId;
    }
}
