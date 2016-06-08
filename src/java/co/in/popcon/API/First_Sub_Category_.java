/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import co.in.popcon.hibernate.FirstSubcategory;
import co.in.popcon.hibernate.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.*;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import org.json.JSONException;
import org.json.JSONObject;

import co.in.popcon.service.Hibernate;
import co.in.popcon.service.Serialization;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import co.in.popcon.Beans.*;
/**
 * REST Web Service
 *
 * @author yogesh
 */
@Path("First_Sub_Category_")
public class First_Sub_Category_ extends Hibernate {

    @Context
    private UriInfo context;
    Serialization serialization = new Serialization();

    /**
     * Creates a new instance of First_Sub_Category_
     */
    public First_Sub_Category_() {
        super();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getData() {
        List list = new ArrayList();
        Criteria cr = session.createCriteria(FirstSubcategory.class);
        for (Object o : cr.list()) {
            First_Sub_Category_GET_ bin = new First_Sub_Category_GET_();
            FirstSubcategory f = (FirstSubcategory) o;
            bin.setFirstSubcategoryId(f.getFirstSubcategoryId() + "");
            bin.setName(f.getName());
            bin.setMainCategoryId(f.getMainCategory().getMainCategoryId() + "");
            list.add(bin);
        }
        JSONSerializer serializer = new JSONSerializer();
        closeHibernateConnection();
        return serializer.exclude("*.class").serialize(list);
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public First_Sub_Category_POST_ postJson(String param) {
        FirstSubcategory firstSubcategory = null;
        First_Sub_Category_POST_ bin=new First_Sub_Category_POST_();
        try {
            JSONObject json = new JSONObject(param); // json
            int mainCategoryId = Integer.parseInt(json.getString("mainCategoryId"));
            String name = json.getString("first_Sub_Category_Name");
            Criteria cr = session.createCriteria(MainCategory.class);
            cr.add(Restrictions.eq("mainCategoryId", mainCategoryId));
            MainCategory mainCategory = (MainCategory) cr.list().get(0);
            firstSubcategory = new FirstSubcategory(mainCategory, name);
            session.save(firstSubcategory);
            transaction.commit();
            bin.setFirstSubcategoryId(firstSubcategory.getFirstSubcategoryId());
            bin.setName(firstSubcategory.getName());
            bin.setMainCategoryId(mainCategoryId + "");
            closeHibernateConnection();
        } catch (JSONException ex) {
            Logger.getLogger(First_Sub_Category_.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bin;
    }

    @PUT
    @Path("/{firstSubcategoryId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public void putData(@PathParam("firstSubcategoryId") int id, String param) {
        FirstSubcategory firstSubcategory = null;
        try {
            JSONObject json = new JSONObject(param); // json
            int mainCategoryId = Integer.parseInt(json.getString("mainCategoryId"));
            String name = json.getString("name");
            Criteria cr = session.createCriteria(FirstSubcategory.class);
            cr.add(Restrictions.eq("firstSubcategoryId", id));
            firstSubcategory = (FirstSubcategory) cr.list().get(0);
            firstSubcategory.setName(name);

            cr = session.createCriteria(MainCategory.class);
            cr.add(Restrictions.eq("mainCategoryId", mainCategoryId));
            MainCategory mainCategory = (MainCategory) cr.list().get(0);
            firstSubcategory.setMainCategory(mainCategory);

            session.save(firstSubcategory);
            transaction.commit();
            closeHibernateConnection();
        } catch (JSONException ex) {
            Logger.getLogger(First_Sub_Category_.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @DELETE
    @Path("/{firstSubcategoryId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public void deleteData(@PathParam("firstSubcategoryId") int id) {
        FirstSubcategory firstSubcategory = null;
        try {
            Criteria cr = session.createCriteria(FirstSubcategory.class);
            cr.add(Restrictions.eq("id", id));
            firstSubcategory = (FirstSubcategory) cr.list().get(0);
            session.delete(firstSubcategory);
            transaction.commit();
            closeHibernateConnection();
        } catch (Exception ex) {
            System.out.println("\n\n\n\n" + ex + "\n\n\n\n\n\n");
        }
    }
}
