<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>
<%@ page import = "JavaClasses.SendEmail" %>
<%@ page errorPage="error_page.jsp" %>
<% 

SendEmail se = new SendEmail();
String sendStatus = "" ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

int r ;
String email ;
int randomStudentId = 0 ;
Random rd = new Random();
if(request.getParameter("forgotEmail") != null ){
	email = request.getParameter("forgotEmail") ;
	
	 do{
		randomStudentId = rd.nextInt(1000000);
	   }while(randomStudentId<100000); 
	
	r = con.prepareStatement("update student set RandomStudentId="+randomStudentId+" where Email='"+email+"' ; ").executeUpdate();
	if(r != 0){
	sendStatus = se.sendEmail(email, "Change Of Password" , "Hey There !! Follow this link to change your password \n " + "http://localhost:8080/WebAppOnlineEvaluation/change_password.jsp?email="+email+"&randomStudentId="+randomStudentId+""  );                     
	if(sendStatus.equals("Message Send Successfully")){
		%>	<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Change Password Link Sent to your email id !!</h5>
		<jsp:include page="index.html"></jsp:include>
		<%
	}else{
		%>	<h5 style="color: white ; position: absolute; top : 4% ; left : 5% ; display: block ; z-index: 5000" id="invalid">Can't Send Email! Check Your Internet Connection !</h5>
		<jsp:include page="index.html"></jsp:include>
		<%
	}
	
	}else{
		response.sendRedirect("error_page.jsp?message=Wrong Email ID");
	}
}


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
    text-align: center; 
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
.element-main input[type="text"] {
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


</style>

</head>
<body>

<div class="element">
	<h2>Reset Password Here</h2>
	<div class="element-main">
		<h1>Forgot Password</h1>
		<p> Only for Students </p>
		<form action="forgot_password.jsp" method="post">
			<input type="text" name="forgotEmail" placeholder="Enter your Email" required>
			<input type="submit" value="Reset my Password">
			</form>
			<br>
		<a href="index.html" style="color: black ">Go Back to Home</a>
	</div>
</div>
</body>
</html>


