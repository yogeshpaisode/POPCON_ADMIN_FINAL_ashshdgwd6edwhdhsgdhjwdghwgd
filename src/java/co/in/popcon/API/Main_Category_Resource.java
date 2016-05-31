/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import co.in.popcon.hibernate.*;
import co.in.popcon.service.Hibernate;
import co.in.popcon.service.Serialization;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.*;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import org.codehaus.jackson.map.ObjectMapper;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * REST Web Service
 *
 * @author yogesh
 */
@Path("main_Category_")
public class Main_Category_Resource extends Hibernate {

    @Context
    private UriInfo context;
    Serialization serialization = new Serialization();
    ObjectMapper mapper = new ObjectMapper();

    /**
     * Creates a new instance of Main_Category_Resource
     */
    public Main_Category_Resource() {
        super();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getJson() {
        Criteria cr = session.createCriteria(MainCategory.class);
        List list = cr.list();
        closeHibernateConnection();
        return serialization.getListSerialization(list);
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public MainCategory postJson(String name) {
        MainCategory mainCategory = null;
        try {
            mainCategory = mapper.readValue(name, MainCategory.class);
            session.save(mainCategory);
            transaction.commit();
            closeHibernateConnection();
        } catch (IOException ex) {
            Logger.getLogger(Main_Category_Resource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mainCategory;
    }

    @PUT
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public MainCategory putJson(String param) {
        MainCategory mainCategory = null;
        try {
            JSONObject json = new JSONObject(param); // json
            int id = json.getInt("id");
            String name = json.getString("name");
            Criteria cr = session.createCriteria(MainCategory.class);
            cr.add(Restrictions.eq("id", id));
            List results = cr.list();
            mainCategory = (MainCategory) results.get(0);
            mainCategory.setName(name);
            session.save(mainCategory);
            transaction.commit();
            closeHibernateConnection();
        } catch (Exception ex) {
            Logger.getLogger(Main_Category_Resource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mainCategory;
    }

    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public MainCategory deleteJson(@PathParam("id") int id) {
        MainCategory mainCategory = null;
        try {
            Criteria cr = session.createCriteria(MainCategory.class);
            cr.add(Restrictions.eq("id", id));
            mainCategory = (MainCategory) cr.list().get(0);
            session.delete(mainCategory);
            transaction.commit();
            closeHibernateConnection();
        } catch (Exception ex) {
            System.out.println("\n\n\n\n" + ex + "\n\n\n\n\n\n");
        }
        return mainCategory;
    }
}
