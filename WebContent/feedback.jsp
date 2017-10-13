<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>
<% 

if(request.getParameter("name") != null && request.getParameter("email") != null && request.getParameter("subject") != null && request.getParameter("message") != null ){

String name = request.getParameter("name");
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String message = request.getParameter("message");


int r = 0 ;

PreparedStatement pst ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

	pst = con.prepareStatement("insert into feedback(Name,Email,Subject,Message) values(?,?,?,?);");
	pst.setString(1, name);
	pst.setString(2, email);
	pst.setString(3, subject);
	pst.setString(4, message);
	r = pst.executeUpdate();



if(r != 0){
%>
<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Feedback Sent</h5>
<jsp:include page="index.html"></jsp:include>

<% 
}else{
%>
<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Feedback not Sent ! Kindly Try Again Later</h5>
<jsp:include page="index.html"></jsp:include>
<% } }else{
	
	response.sendRedirect("error_page.jsp");
	
}%>














