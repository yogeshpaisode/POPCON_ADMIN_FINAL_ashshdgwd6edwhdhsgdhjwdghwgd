/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import co.in.popcon.Beans.Product_Color_ID_Track;
import co.in.popcon.Beans.Product_POST;
import co.in.popcon.hibernate.FirstSubcategory;
import co.in.popcon.hibernate.MainCategory;
import co.in.popcon.hibernate.ProductByColor;
import co.in.popcon.hibernate.ProductByColorImages;
import co.in.popcon.hibernate.ProductDetail;
import co.in.popcon.hibernate.ProductSize;
import co.in.popcon.hibernate.SecondSubcategory;
import co.in.popcon.hibernate.SizeStockByColor;
import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * REST Web Service
 *
 * @author yogeshpaisode
 */
@Path("add_Product")
public class Add_Product_ extends co.in.popcon.service.Hibernate {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of Add_Product_
     */
    public Add_Product_() {
    }

    /**
     * Retrieves representation of an instance of co.in.popcon.API.Add_Product_
     *
     * @return an instance of java.lang.String
     */
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Product_POST postJson(String data) throws JSONException {
        JSONObject jSONObject = new JSONObject(data);
        List colorList = new ArrayList();
        Product_POST product_POST=new Product_POST();
        
        String searchTag = jSONObject.get("searchTag").toString();
        String productDetail = jSONObject.get("productDetail").toString();
        String materialDetail = jSONObject.get("materialDetail").toString();
        String care = jSONObject.get("care").toString();
        int sellingPrice = jSONObject.getInt("sellingPrice");
        int off = jSONObject.getInt("off");
        int displayPrice = jSONObject.getInt("displayPrice");

        int mainCategoryId = Integer.parseInt(jSONObject.getString("mainCategoryId"));
        int firstSubcategoryId = Integer.parseInt(jSONObject.getString("firstSubcategoryId"));
        int secondSubcategoryId = Integer.parseInt(jSONObject.getString("secondSubcategoryId"));

        JSONArray colorArray = jSONObject.getJSONArray("color");
        JSONArray sizeArray = jSONObject.getJSONArray("sizeList");

        Criteria cr = session.createCriteria(MainCategory.class);
        cr.add(Restrictions.eq("mainCategoryId", mainCategoryId));
        MainCategory mainCategory = (MainCategory) cr.list().get(0);

        cr = session.createCriteria(FirstSubcategory.class);
        cr.add(Restrictions.eq("firstSubcategoryId", firstSubcategoryId));
        FirstSubcategory firstSubcategory = (FirstSubcategory) cr.list().get(0);

        cr = session.createCriteria(SecondSubcategory.class);
        cr.add(Restrictions.eq("secondSubcategoryId", secondSubcategoryId));
        SecondSubcategory secondSubcategory = (SecondSubcategory) cr.list().get(0);

        //Add Product
        ProductDetail productObj = new ProductDetail(firstSubcategory, mainCategory, secondSubcategory, searchTag, productDetail, materialDetail, care, sellingPrice, displayPrice);
        session.save(productObj);
        product_POST.setProductDetailId(productObj.getProductDetailId());
        //Add Color's
        for (int i = 0; i < colorArray.length(); i++) {
            JSONObject colorObj = colorArray.getJSONObject(i);
            String color = colorObj.getString("color");
            String hex = colorObj.getString("hex");
            String title = colorObj.getString("title");
            ProductByColor byColor = new ProductByColor(productObj, color, title, hex);
            session.save(byColor);

            colorList.add(new Product_Color_ID_Track(color, byColor));

            //Add Color Images
            JSONArray imageAry = colorObj.getJSONArray("images");

            for (int j = 0; j < imageAry.length(); j++) {
                JSONObject imgObj = imageAry.getJSONObject(j);
                String name = imgObj.getString("name");
                ProductByColorImages byColorImages = new ProductByColorImages(byColor, name);
                session.save(byColorImages);
            }

        }

        for (int i = 0; i < sizeArray.length(); i++) {
            JSONObject sizeObj = sizeArray.getJSONObject(i);
            if (sizeObj.getBoolean("isSelected")) {
                String type = sizeObj.getString("type");
                ProductSize productSize = new ProductSize(productObj, type);
                session.save(productSize);
                JSONArray stockAry = sizeObj.getJSONArray("stock");

                for (int j = 0; j < stockAry.length(); j++) {
                    JSONObject stockObj = stockAry.getJSONObject(j);
                    String stockForColor = stockObj.getString("color");
                    int stock = stockObj.getInt("stock");
                    for (Object o : colorList) {
                        Product_Color_ID_Track track = (Product_Color_ID_Track) o;
                        if (track.getName().equals(stockForColor)) {
                            ProductByColor byColor = track.getByColor();
                            SizeStockByColor sizeStockByColor = new SizeStockByColor(productSize, byColor, stock);
                            session.save(sizeStockByColor);
                        }
                    }
                }

            }
        }

        transaction.commit();
        System.out.println(productObj.getProductDetailId());

        session.close();
        sessionFactory.close();

        return product_POST;
    }

}
