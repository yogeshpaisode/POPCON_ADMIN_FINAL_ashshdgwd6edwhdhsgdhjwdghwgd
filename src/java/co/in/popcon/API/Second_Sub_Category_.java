/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import co.in.popcon.hibernate.*;
import co.in.popcon.service.Hibernate;
import java.util.ArrayList;
import java.util.List;
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
import co.in.popcon.Beans.Second_Sub_Category_POST_GET;
import flexjson.JSONSerializer;

/**
 * REST Web Service
 *
 * @author yogesh
 */
@Path("Second_Sub_Category_")
public class Second_Sub_Category_ extends Hibernate {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of Second_Sub_Category_POST_GET
     */
    public Second_Sub_Category_() {

    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public String getJson() throws JSONException {
        List list = new ArrayList();
        Criteria cr = session.createCriteria(SecondSubcategory.class);
        for (Object o : cr.list()) {
            Second_Sub_Category_POST_GET ssc = new Second_Sub_Category_POST_GET();
            SecondSubcategory s = (SecondSubcategory) o;
            FirstSubcategory f = s.getFirstSubcategory();
            MainCategory m = f.getMainCategory();
            ssc.setMainCategoryId(m.getMainCategoryId() + "");
            ssc.setFirstSubcategoryId(f.getFirstSubcategoryId() + "");
            ssc.setSecondSubCategoryId(s.getSecondSubcategoryId() + "");
            ssc.setSecondSubCategoryName(s.getName());
            list.add(ssc);
        }
        JSONSerializer serializer = new JSONSerializer();
        closeHibernateConnection();
        return serializer.exclude("*.class").serialize(list);
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Second_Sub_Category_POST_GET postJson(String param) throws JSONException {
        Second_Sub_Category_POST_GET bin = new co.in.popcon.Beans.Second_Sub_Category_POST_GET();
        JSONObject json = new JSONObject(param); // json
        int firstSubcategoryId = Integer.parseInt(json.getString("firstSubcategoryId"));
        String name = json.getString("secondSubCategoryName");

        Criteria cr = session.createCriteria(FirstSubcategory.class);
        cr.add(Restrictions.eq("firstSubcategoryId", firstSubcategoryId));
        FirstSubcategory firstSubcategory = (FirstSubcategory) cr.list().get(0);
        MainCategory mainCategory = firstSubcategory.getMainCategory();
        SecondSubcategory secondSubcategory = new SecondSubcategory(firstSubcategory, name);
        session.save(secondSubcategory);
        bin.setFirstSubcategoryId(firstSubcategory.getFirstSubcategoryId() + "");
        bin.setMainCategoryId(mainCategory.getMainCategoryId() + "");
        bin.setSecondSubCategoryId(secondSubcategory.getSecondSubcategoryId() + "");
        bin.setSecondSubCategoryName(secondSubcategory.getName());

        transaction.commit();
        closeHibernateConnection();

        return bin;
    }

    @DELETE
    @Path("/{secondSubCategoryId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public void deleteData(@PathParam("secondSubCategoryId") int secondSubCategoryId) {
        Criteria cr = session.createCriteria(SecondSubcategory.class);
        cr.add(Restrictions.eq("secondSubcategoryId", secondSubCategoryId));
        SecondSubcategory s = (SecondSubcategory) cr.list().get(0);
        session.delete(s);
        transaction.commit();
        closeHibernateConnection();
    }
}
