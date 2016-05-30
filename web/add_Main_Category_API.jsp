<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@ include file="/import/sessionFactory.jsp"%>
<%    try {
        ObjectMapper mapper = new ObjectMapper();
        if (flag) {
            if (method.equals("post")) {
                String name = request.getParameter("name").toString();
                MainCategory mainCategory = new MainCategory(name);
                hib_session.save(mainCategory);
                transaction.commit();
                out.print("{\"id\":\"" + mainCategory.getId() + "\"}");
            }//End of 'post'
            else if (method.equals("get")) {
                Criteria cr = hib_session.createCriteria(MainCategory.class);
                out.print(mapper.writeValueAsString(cr.list()));
            }//End of get
            else if (method.equals("put")) {
                out.print("{\"Success\":\"Put Accepted\"}");
            }
        } else {
            //response.sendError(403);
            out.print("{\"Error Message \":\"" + error + "\"}");
        }
    } catch (Exception e) {
        //response.sendError(403);
        out.print("{\"Error Message \":\"" + e.toString() + "\"}");
    }
%>
<%@ include file="/import/footer.jsp"%>
