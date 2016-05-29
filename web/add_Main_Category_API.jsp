<%@ include file="/import/sessionFactory.jsp"%>
<%    
    try {
        String name = request.getParameter("name").toString();
        if (flag) {
            if (method.equals("post")) {
                MainCategory mainCategory = new MainCategory(name);
                hib_session.save(mainCategory);
                transaction.commit();
            }//End of 'post'
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
