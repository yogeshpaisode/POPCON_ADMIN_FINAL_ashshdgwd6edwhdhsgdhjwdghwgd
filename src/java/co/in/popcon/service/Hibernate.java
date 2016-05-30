/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;

/**
 *
 * @author yogesh
 */
public class Hibernate {
    public SessionFactory sessionFactory=null;
    public Session session=null;
    public Transaction transaction=null;

    public Hibernate() {
        sessionFactory=new AnnotationConfiguration().configure().buildSessionFactory();
        session=sessionFactory.openSession();
        transaction=session.beginTransaction();
    }
    
    public void closeHibernateConnection(){
        session.close();
        sessionFactory.close();
    }
}
