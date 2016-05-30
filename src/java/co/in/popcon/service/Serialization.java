/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.service;

import co.in.popcon.API.Main_Category_Resource;
import co.in.popcon.hibernate.MainCategory;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author yogesh
 */
public class Serialization {

    ObjectMapper mapper = new ObjectMapper();

    public String getObjectSerialization(Object o) {
        String str = "";
        List l = new ArrayList();
        l.add(o);
        try {
            str = mapper.writeValueAsString(l);
        } catch (IOException ex) {
            Logger.getLogger(Main_Category_Resource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return str;
    }

    public String getListSerialization(List list) {
        String str = "";
        try {
            str = mapper.writeValueAsString(list);
        } catch (IOException ex) {
            Logger.getLogger(Main_Category_Resource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return str;
    }

}
