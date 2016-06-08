/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import co.in.popcon.Beans.Second_Sub_Category_POST_;
import co.in.popcon.hibernate.*;
import co.in.popcon.service.Hibernate;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.*;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * REST Web Service
 *
 * @author yogesh
 */
@Path("Second_Sub_Category_")
public class Second_Sub_Category_ extends Hibernate{

    @Context
    private UriInfo context;
  
    /**
     * Creates a new instance of Second_Sub_Category_
     */
    public Second_Sub_Category_() {
       
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Second_Sub_Category_POST_ postJson(String param) throws JSONException {
        Second_Sub_Category_POST_ bin=new Second_Sub_Category_POST_();
        JSONObject json = new JSONObject(param); // json
        int firstSubcategoryId = Integer.parseInt(json.getString("firstSubcategoryId"));
        String name = json.getString("second_Sub_Category_Name");
        
        Criteria cr = session.createCriteria(FirstSubcategory.class);
        cr.add(Restrictions.eq("firstSubcategoryId", firstSubcategoryId));
        FirstSubcategory firstSubcategory = (FirstSubcategory) cr.list().get(0);
        MainCategory mainCategory=firstSubcategory.getMainCategory();
        SecondSubcategory secondSubcategory=new SecondSubcategory(firstSubcategory, name);
        session.save(secondSubcategory);        
        bin.setFirstSubcategoryId(firstSubcategory.getFirstSubcategoryId()+"");
        bin.setMainCategoryId(mainCategory.getMainCategoryId()+"");
        bin.setSecond_Sub_Category_Id(secondSubcategory.getSecondSubcategoryId()+"");
        bin.setSecond_Sub_Category_Name(secondSubcategory.getName());
        
        transaction.commit();
        closeHibernateConnection();
        
        return bin;
    }
}
