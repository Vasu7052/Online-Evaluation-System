<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>

<%

String name , mobile , city , qualification , year ;

PreparedStatement pstUpdate = null ;
int r = 0 ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

if(request.getParameter("name") != null && request.getParameter("mobile") != null && request.getParameter("city") != null && request.getParameter("qualification") != null && request.getParameter("year") != null){
	
	name = request.getParameter("name") ;
	mobile = request.getParameter("mobile") ;
	city = request.getParameter("city") ;
	qualification = request.getParameter("qualification") ;
	year = request.getParameter("year") ;
	
	pstUpdate = con.prepareStatement("update student set Name=? , Mobile=? , City=? , Qualification=? , Year=? where Email=?");
	pstUpdate.setString(1, name);
	pstUpdate.setString(2, mobile);
	pstUpdate.setString(3, city);
	pstUpdate.setString(4, qualification);
	pstUpdate.setString(5, year);
	pstUpdate.setString(6, (String)session.getAttribute("email"));
	
	r = pstUpdate.executeUpdate();
	
	if(r != 0){
		%> <jsp:include page="student_area.jsp"></jsp:include>
	    <h3 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid"> Profile Updated :) </h3> <%
	}else{
		response.sendRedirect("error_page.jsp");
	}
	
}else{
	response.sendRedirect("error_page.jsp");
}





%>