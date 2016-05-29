<%@ include file="/import/sessionFactory.jsp"%>
<%    try {

        if (flag) {

        } else {
            response.sendError(403);
            out.print("{\"Error Message \":\"" + error + "\"}");
        }
    } catch (Exception e) {
        response.sendError(403);
        out.print("{\"Error Message \":\"" + e.toString() + "\"}");
    }

%>
<%@ include file="/import/footer.jsp"%>
