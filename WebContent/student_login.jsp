<%@ page import="java.sql.*" %>
<%@ page errorPage = "error_page.jsp" %>
<% 



PreparedStatement pst ;
String email = request.getParameter("email");
String password = request.getParameter("password");

session.setAttribute("email", email);
session.setAttribute("userType", "Student");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

pst = con.prepareStatement("select * from student where Email=? AND Password=?");


pst.setString(1, email);
pst.setString(2, password);
ResultSet rs = pst.executeQuery();

if(rs.next()){
	session.setAttribute("name", rs.getString("Name"));
	session.setAttribute("email", rs.getString("Email"));
	session.setAttribute("loginStatus", "yes");
	session.setAttribute("loginUser" , "student" );
	response.sendRedirect("student_area.jsp");
}else{
	%>
	<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Invalid Username or Password ! Please Try Again</h5>
	<jsp:include page="index.html"></jsp:include>
	<% 
}
%>