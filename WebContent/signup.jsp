<%@ page import="java.sql.*" %>
<%@ page import = "JavaClasses.SendEmail" %>
<%@ page errorPage = "error_page.jsp" %>
<% 


if(request.getParameter("qualification").equals("Select Qualification")){
%><h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Please Select Your Qualification</h5>
<jsp:include page="index.html"></jsp:include><%
}else if(request.getParameter("year").equals("Select Year")){
	%><h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Please Select Your Year</h5>
	<jsp:include page="index.html"></jsp:include><%
}else{

SendEmail se = new SendEmail();
String sendStatus = "" ;

String companyName = request.getParameter("companyName");
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");
String gender = request.getParameter("gender");
String mobile = request.getParameter("mobile");
String city = request.getParameter("city");
String qualification = request.getParameter("qualification");
String year = request.getParameter("year");


String address = request.getParameter("address");
String companyType = request.getParameter("companyType");

int r = 0 ;

PreparedStatement pst ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

try{
if(companyName == null){
	pst = con.prepareStatement("insert into student(Name,Email,Password,Mobile,City,Qualification,Year,Gender) values(?,?,?,?,?,?,?,?);");
	pst.setString(1, name);
	pst.setString(2, email);
	pst.setString(3, password);
	pst.setString(4, mobile );
	pst.setString(5, city );
	pst.setString(6, qualification );
	pst.setString(7, year );
	pst.setString(8, gender );
	r = pst.executeUpdate();
}else{
	pst = con.prepareStatement("insert into company(Name,Password,Address,Type) values(?,?,?,?);");
	pst.setString(1, companyName);
	pst.setString(2, password);
	pst.setString(3, address);
	pst.setString(4, companyType);
	r = pst.executeUpdate();
}
}catch(SQLException  e){
	if(e.getMessage().startsWith("Duplicate")){
%>	<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Email id already Exist !</h5>
	<jsp:include page="index.html"></jsp:include>
<% }}


if(r != 0){
	se.sendEmail(email, "Sign up Successfull", "You have Recently Registred your account in our Web Application .\nThanking You !! \nOnline Evaluation Team");
%>
<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Signup Successfull | Kindly Login !</h5>
<jsp:include page="index.html"></jsp:include>

<% 
}
}
%>