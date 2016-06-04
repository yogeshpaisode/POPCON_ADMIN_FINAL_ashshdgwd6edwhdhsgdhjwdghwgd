/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.test;

import co.in.popcon.hibernate.SecondSubcategory;
import co.in.popcon.service.Serialization;
import flexjson.JSONSerializer;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

/**
 *
 * @author yogeshpaisode
 */
public class test {
    public static void main(String[] args) {
        SessionFactory sessionFactory=new AnnotationConfiguration().configure().buildSessionFactory();
        Session session=sessionFactory.openSession();
       
        Criteria cr = session.createCriteria(SecondSubcategory.class);
        List list = cr.list();
        JSONSerializer serializer = new JSONSerializer();
        sessionFactory.close();
        System.out.println(serializer.exclude("*.class").serialize(list));
    }
}
