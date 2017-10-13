<%@ page errorPage="error_page.jsp" %>
<%

	if(session.getAttribute("loginStatus") != null && session.getAttribute("loginStatus").equals("yes")){
		if(session.getAttribute("loginUser").equals("student")){
			response.sendRedirect("student_area.jsp");
		}else if(session.getAttribute("loginUser").equals("admin")){
			response.sendRedirect("admin_area.jsp");
		}else if(session.getAttribute("loginUser").equals("company")){
			response.sendRedirect("company_area.jsp");
		}
	}else{
		response.sendRedirect("index.html");
	}

%>