<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>

<% 

if(session.getAttribute("loginStatus") == null || !session.getAttribute("loginStatus").equals("yes") || !session.getAttribute("loginUser").equals("company")){
	response.sendRedirect("error_page.jsp?message=You Are Not Logged In");
}

String qualification , topic , from_grade , to_grade , year , gender ;

qualification = request.getParameter("qualification");
topic = request.getParameter("topic");
from_grade = request.getParameter("fromGrade");
to_grade = request.getParameter("toGrade");
year = request.getParameter("year");
gender = request.getParameter("gender");

int check = 0 ;
PreparedStatement pstStudents = null ;
ResultSet rsStudents = null ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

if(qualification != null && topic != null && from_grade != null && to_grade != null && gender != null){
	
	if(!qualification.equals("Select Qualification") && !topic.equals("Select Topic") &&!year.equals("Select Year")){
	
	if(gender.equals("NP")){
		pstStudents = con.prepareStatement("select * from student where Qualification=? AND Year=? AND "+topic+"Score IS NOT NULL AND "+topic+"Grade BETWEEN "+from_grade+" AND  "+to_grade+"   ;");
		pstStudents.setString( 1 , qualification );
		pstStudents.setString( 2 , year );
		rsStudents = pstStudents.executeQuery();
	}else{
		pstStudents = con.prepareStatement("select * from student where Qualification=? AND Gender=? AND Year=? AND "+topic+"Score IS NOT NULL AND "+topic+"Grade BETWEEN "+from_grade+" AND  "+to_grade+"   ;");
		pstStudents.setString( 1 , qualification );
		pstStudents.setString( 2 , gender );
		pstStudents.setString( 3 , year );
		rsStudents = pstStudents.executeQuery();
		}
	
	%>
	<script type="text/javascript">
	function showArticle() {
		var x = document.getElementById('errorArticle');
			if (x.style.display === 'none') {
		    x.style.display = 'block';
		} else {
		    x.style.display = 'none';
		}
			document.getElementById('intro').style.display = 'none';	
		}
	</script>
	<%
	
	}
}else if(request.getParameter("btnSubmitAll") != null){
	pstStudents = con.prepareStatement("select * from student  ;");
	rsStudents = pstStudents.executeQuery();
	
	%>
	<script type="text/javascript">
	function showArticle() {
		var x = document.getElementById('errorArticle');
			if (x.style.display === 'none') {
		    x.style.display = 'block';
		} else {
		    x.style.display = 'none';
		}
			document.getElementById('intro').style.display = 'none';	
		}
	</script>
	<%
}

%>

<!DOCTYPE html>
<html>
<head>
<title>Company Area</title>
<script>
window.history.forward();
</script>
<style>

body{
margin : 0;
background-color: #eee ;
}

.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width : 45% ;
}

.buttonCustom {border-radius: 10px;}

ul {
    list-style-type: none;
    margin-top : -4% ;
    overflow: hidden;
    background-color: transparent;
}

li {
    float: right;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 16px;
    text-decoration: none;
}

li a:hover {
    background-color: #111111;
}

form {
    display: inline;
}

.top{
width : 100% ;
height : 250px ;
background-image : url(company-header.png);
}

input[type=number], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

#from{
width : 30% ;
}

#to{
width : 30% ;
}

.search{
	display: inline-block;
	float: left;
	height : 350px ;
    max-width: 400px;
    margin: 0;
    padding: 1em;
    background-color: white ;
	padding : 20px ;
}

article {
	width: auto;
	height : 350px ;
	margin-right: 10px;
    margin-left: 445px;
    padding: 1em;
    overflow: hidden;
    background-color: white ;
	padding : 20px ;
}

table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}

th {
    background-color: #4CAF50;
    color: white;
}

.introduction{

	text-align : center ;
	width: auto ;
	height: auto ;
	background-color: white ;
	margin-left: auto ;
	margin-right: auto ;
	margin-top: 20px ;
	padding-top: 0px ;
	padding-bottom: 20px ;
	padding-left: 20px ;
	padding-right: 20px ;
	
}

</style>
	
</head>

<body onload="javascript:showArticle()"> 


<div class="top"></div>
<ul>
<li><a href="logout.jsp">Logout</a></li>
<li><a href="company_area.jsp">Home</a></li>
<li style="float : left"><a href=""><%= session.getAttribute("companyName") %></a></li>
</ul>



<div class="search" id="searchStudents" style="display: block">

	<form action="company_area.jsp" method="post">
	<select class="selction" name="qualification">
  	<option>Select Qualification</option>
  	<option>BTech</option>
  	<option>MCA</option>
  	<option>BCA</option>
  	<option>Others</option>
  	</select>
  
	<select class="selction" name="topic">
  	<option>Select Topic</option>
  	<option>C</option>
  	<option>Java</option>
  	<option>PHP</option>
  	</select>
  	
  	Grade From <input type="number" id="from" placeholder="From" value="60" name="fromGrade" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="2" required ></input>&nbsp;&nbsp;
  	Grade To <input type="number" id="to" placeholder="To" value="100" name="toGrade" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="3" required ></input>
  	
  	<select class="selction" name="year">
  	<option>Select Year</option>
  	<option>2014-2015</option>
  	<option>2015-2016</option>
  	<option>2016-2017</option>
  	<option>Pursuing</option>
  	</select>
  	<br>
  	<p></p>
  	<input type="radio" name="gender" 	id="languageRadio"  value="male" > Male
  	<input type="radio" name="gender" 	id="languageRadio"  value="female"> Female
  	<input type="radio" name="gender" 	id="languageRadio"  value="NP" checked > NP 
  	<p></p>
	<button name="btnSubmit"  class="button buttonCustom"  type="submit">Search Students</button>
	</form>
	<p style="display: inline-block;">OR</p>
	<form action="company_area.jsp" method="get">
	<button name="btnSubmitAll" value="allStudents" type="submit"  class="button buttonCustom"  >Search All Students</button>
	</form>
	
</div>

<% if(qualification == null && topic == null && from_grade == null && to_grade == null && gender == null && request.getParameter("btnSubmitAll") == null ){ %>

<article id="articleIntro">
<div class="introduction" id="intro" style="display: block ; height: 350px ;">
<h1 style="font-size: 500% ; color: #000080 ">Company Dashboard</h1>
<h2 style="margin-top: -30px">Show this world the power of opportunity !!</h4>
<h4 style="font-weight: 0"> Start By Searching Some Students !! </h4>
</div>
</article>
<% } %>

<%if(rsStudents != null && rsStudents.next()){
		rsStudents.beforeFirst();
	
	
%>


<article>

<table>
  <tr>
    <th>Name</th>
    <th>Email</th>
    <th>Mobile</th>
    <th>Gender</th>
  </tr>
  
  
  <% while(rsStudents.next()){ 
 
  		check++ ;
  %>
  
  <tr>
    <td><%= rsStudents.getString("Name") %></td>
    <td><%= rsStudents.getString("Email") %></td>
    <td><%= rsStudents.getString("Mobile") %></td>
    <td><%= rsStudents.getString("Gender") %></td>
  </tr>
  
  
  <% } 

 }%>
  
</table>
</article>

<%
if(check == 0){
%>

<article id="errorArticle" style="display:none">
<h3>No Students Found :( </h3>
</article>
<% } %>


<br><br><br>



</body>
</html>




