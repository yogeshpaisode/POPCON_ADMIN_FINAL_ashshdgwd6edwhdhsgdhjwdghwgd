/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.API;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author yogesh
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(co.in.popcon.API.Add_Product_.class);
        resources.add(co.in.popcon.API.First_Sub_Category_.class);
        resources.add(co.in.popcon.API.Main_Category_Resource.class);
        resources.add(co.in.popcon.API.Second_Sub_Category_.class);
    }
    
}
