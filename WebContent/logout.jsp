<%@ page errorPage="error_page.jsp" %>
<% 

	session.setAttribute("loginStatus", "no");

	response.sendRedirect("index.jsp");

%>