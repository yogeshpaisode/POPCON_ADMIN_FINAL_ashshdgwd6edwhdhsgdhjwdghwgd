<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.cfg.AnnotationConfiguration"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="co.in.popcon.hibernate.*"%>
<%
    response.setHeader("Access-Control-Allow-Origin", "*");
    boolean flag=false;
    String error="";
    SessionFactory sessionFactory=null;
    Session hib_session=null;
    Transaction transaction=null;
    String method=request.getMethod().toLowerCase();
    try {
        sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
        hib_session=sessionFactory.openSession();
        transaction=hib_session.beginTransaction();
        flag=true;
        out.print("Success..");
    } catch (Exception e) {
        error=e.toString();
    }
    
%>
