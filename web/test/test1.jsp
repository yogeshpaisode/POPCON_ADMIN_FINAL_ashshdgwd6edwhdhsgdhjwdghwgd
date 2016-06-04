<%@page import="flexjson.JSONSerializer"%>
<%@page import="java.util.List"%>
<%@page import="co.in.popcon.hibernate.SecondSubcategory"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.cfg.AnnotationConfiguration"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    SessionFactory sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
    Session s = sessionFactory.openSession();
    Criteria cr = s.createCriteria(SecondSubcategory.class);
    List results = cr.list();
    JSONSerializer serializer = new JSONSerializer();
    out.println(serializer.exclude("*.class").serialize(results));
    sessionFactory.close();
%>