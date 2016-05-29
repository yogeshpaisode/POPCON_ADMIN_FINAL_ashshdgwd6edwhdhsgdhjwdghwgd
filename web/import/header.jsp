<%@page import="org.hibernate.cfg.AnnotationConfiguration"%>
<%@page import="org.hibernate.SessionFactory"%>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>


<%
    try {
        SessionFactory sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
        out.print("Success..");
    } catch (Exception e) {
        out.print("Error :" + e.toString());
    }
    
%>
