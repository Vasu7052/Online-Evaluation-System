<%@ page import="java.sql.*" %>
<%@ page import = "JavaClasses.SendEmail" %>
<%@ page errorPage="error_page.jsp" %>
<% 
String email = "" , newPassword ;
int r = 0 ;
ResultSet rs ;

Class.forName("com.mysql.jdbc.Driver") ;
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

if(request.getParameter("forgotPassword") != null ){
	email = request.getParameter("email") ;
	newPassword = request.getParameter("forgotPassword") ;
	r = con.prepareStatement("update student set Password='"+newPassword+"' where Email='"+email+"'").executeUpdate();
	if(r != 0){
		%><h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000">Password Changed Successfully !!</h5>
		<jsp:include page="index.html"></jsp:include>
		<%
	}
}else{
	if(request.getParameter("randomStudentId") != null ){
	email = request.getParameter("email") ;
	rs = con.prepareStatement("select * from student where Email='"+email+"' AND RandomStudentId="+request.getParameter("randomStudentId")+" ; ").executeQuery();
	if(rs != null){

		%>

		<!DOCTYPE HTML>
		<html>
		<head>
		<title>Reset Password</title>

		<style>


		 body{
		   font-size: 100%;
		   background:#4CAF50; 
		   font-family: sans-serif;
		}
		a {
		  text-decoration: none;
		}
		a:hover {
		  transition: 0.5s all;
		  -webkit-transition: 0.5s all;
		  -moz-transition: 0.5s all;
		  -o-transition: 0.5s all;
		}

		.element h2 {
		    font-size: 2.5em;
		    color: #fff;
		    text-align: center;
		    margin-top:2em;
		    font-weight: 700;
		}
		.element-main {
		    width:27%;
		    background: #fff;
		    margin:4em auto 0em;
		    border-radius: 5px;
		    padding:3em 2em;
		}
		.element-main h1 {
		    text-align: center;
		    font-size: 2.3em;
		    color:#4CAF50;
		    font-weight: 700;
		}
		.element-main p {
		    font-size: 1em;
		    color: #696969;
		    line-height: 1.5em;
		    margin: 1.5em 0em;
		    text-align:center;
		}
		.element-main input[type="password"] {
		    font-size: 1em;
		    color: #A29E9E;
		    padding: 1em 0.5em;
		    display: block;
		    width: 95%;
		    outline: none;
		    margin-bottom: 1em;
		    text-align:center;
		    border: 1px solid #B9B9B9;
		}
		.element-main input[type="submit"] {
		    font-size: 1em;
		    color: #fff;
		    background:#4CAF50;
		    width: 50%;
		    padding: 0.8em 0em;
		    outline: none;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    border-bottom: 3px solid #045B99;
		    display: block;
		    margin: 1.5em auto 0;
		}
		.element-main input[type="submit"]:hover{
		    background:#1D1C1C;
		    border-bottom: 3px solid #2F2F2F;  
		    transition: 0.5s all;
		  -webkit-transition: 0.5s all;
		  -moz-transition: 0.5s all;
		  -o-transition: 0.5s all;
		}


		@media(max-width:1440px){
			
		}
		@media(max-width:1366px){
			
		}
		@media(max-width:1280px){
		.element h2 {
		    margin-top: 1em;	
		}
		.element-main {
		    width: 30%;
		}
		}
		@media(max-width:1024px){
		.element-main {
		    width: 37%;	
		}
		}
		@media(max-width:768px){
		.element-main {
		    width: 49%;
		}	
		.element h2 {
		    font-size: 2em;
		}
		.element-main {
		    width: 60%;
		}
		.element-main h1 {
		    font-size: 2em;
		}
		}
		@media(max-width:320px){
		.element h2 {
		    font-size: 1.5em;
		}
		.element-main h1 {
		    font-size: 1.5em;
		}
		.element-main {
		    width: 80%;
		    margin: 2em auto 0em;
		    padding: 1.5em 1.5em;
		}
		.element-main p {
		    font-size: 0.9em;	
		}
		.element-main input[type="submit"] {
		    font-size:0.9em;
		    width: 75%;
		}
		.element-main input[type="text"] {
		    font-size: 0.9em;
		    padding: 0.8em 0.5em;
		}
		}


		</style>

		</head>
		<body>

		<div class="element">
			<h2>Change Password Here</h2>
			<div class="element-main">
				<h1>Change Password</h1>
				<p> Type your new password below !! </p>
				<form action="change_password.jsp" method="post">
					<input type="password" name="forgotPassword" placeholder="Enter your new Password" required>
					<input type="hidden" style="display:none" name="email" value="<%=email%>">
					<input type="submit" value="Change my Password">
				</form>
			</div>
		</div>
		</body>
		</html>


	
	
<% 	} } } %>

