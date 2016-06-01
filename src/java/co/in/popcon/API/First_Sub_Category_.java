/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import co.in.popcon.hibernate.FirstSubcategory;
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
/**
 * REST Web Service
 *
 * @author yogesh
 */
@Path("First_Sub_Category_")
public class First_Sub_Category_ extends Hibernate{

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of First_Sub_Category_
     */
    public First_Sub_Category_() {
        super();
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public FirstSubcategory getJson(String param) {
        FirstSubcategory firstSubcategory = null;
        try {
            JSONObject json = new JSONObject(param); // json
            int id = Integer.parseInt(json.getString("main_Category_id"));
            String name = json.getString("first_Sub_Category_Name");
            firstSubcategory = new FirstSubcategory(id, name);
            session.save(firstSubcategory);
            transaction.commit();
            closeHibernateConnection();
        } catch (JSONException ex) {
            Logger.getLogger(First_Sub_Category_.class.getName()).log(Level.SEVERE, null, ex);
        }
        return firstSubcategory;
    }

}
