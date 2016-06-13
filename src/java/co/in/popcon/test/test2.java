/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.test;

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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author yogeshpaisode
 */
public class test2 {
    public static void main(String[] args) throws JSONException {
        SessionFactory sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        
        String data="{\"color\":[{\"images\":[{\"name\":\"Screen Shot 2016-06-12 at 11.16.10 AM.png\",\"uploadStatus\":\"Uploaded Successfully...1\",\"path\":\"http://upchar.esy.es/img/Screen Shot 2016-06-12 at 11.16.10 AM.png\"}],\"color\":\"sads\",\"hex\":\"ada\",\"title\":\"sd\"},{\"images\":[{\"name\":\"Screen Shot 2016-06-12 at 11.16.22 AM.png\",\"uploadStatus\":\"Uploaded Successfully...0\",\"path\":\"http://upchar.esy.es/img/Screen Shot 2016-06-12 at 11.16.22 AM.png\"}],\"color\":\"asdas\",\"hex\":\"das\",\"title\":\"dsad\"}],\"sizeList\":[{\"type\":\"Small\",\"stock\":[{\"color\":\"sads\",\"stock\":32},{\"color\":\"asdas\",\"stock\":45}],\"isSelected\":true},{\"type\":\"Medium\",\"stock\":[{\"color\":\"sads\",\"stock\":43},{\"color\":\"asdas\",\"stock\":45}],\"isSelected\":true},{\"type\":\"Large\",\"stock\":[{\"color\":\"sads\",\"stock\":21},{\"color\":\"asdas\",\"stock\":23}],\"isSelected\":true}],\"firstSubcategoryId\":\"43\",\"mainCategoryId\":\"22\",\"secondSubcategoryId\":\"15\",\"searchTag\":\"asdsa\",\"productDetail\":\"asdas\",\"materialDetail\":\"asdasdas\",\"care\":\"dsad\",\"sellingPrice\":32,\"off\":34,\"displayPrice\":32}";
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

    }
}
