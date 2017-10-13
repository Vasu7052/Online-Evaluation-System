<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>

<% 

if(session.getAttribute("loginStatus") == null || !session.getAttribute("loginStatus").equals("yes") || !session.getAttribute("loginUser").equals("admin")){
	response.sendRedirect("error_page.jsp?message=You Are Not Logged In");
}

int count = 1 ;
PreparedStatement pstGetQuestions , pstAddQuestions , pstDeleteQuestion ;
ResultSet rsQuestions , rsAddQuestions , rsDeleteQuestion ; ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

pstGetQuestions = con.prepareStatement("select * from question ;");


%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Area</title>
<script>
window.history.forward();
</script>

<style>

body{
margin : 0;
background-color: #fff ;
}

table {
	table-layout : fixed ;
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: center;
    padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}

th {
    background-color: #4CAF50;
    color: white;
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

.top{
width : 100% ;
height : 250px ;
background-image : url(header-image.jpg);
}

input[type=text],input[type=email],input[type=password],input[type=number], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.questions{
	text-align : center ;
	width: 80& ;
	height: auto ;
	background-color: white ;
	margin-left: 20px ;
	margin-right: 20px ;
	margin-top: 20px ;
	padding : 20px ;
}

.search{
	text-align : center ;
	width: 400px ;
	height: auto ;
	background-color: white ;
	margin-left: auto ;
	margin-right: auto ;
	margin-top: 20px ;
	padding : 20px ;
}

.box{
	
	width: 80& ;
	height: auto ;
	background-color: #fff ;
	margin-left: 20px ;
	margin-right: 20px ;
	margin-top: 20px ;
	padding : 20px ;
}

.introduction{

	text-align : center ;
	width: auto ;
	height: auto ;
	background-color: white ;
	margin-left: auto ;
	margin-right: auto ;
	margin-top: 20px ;
	padding : 20px ;
	
}



</style>
	
</head>

<body> 


<div class="top"></div>
<ul>
<li><a href="logout.jsp">Logout</a></li>
<li><a href="javascript:myFunction4()">Search Company</a></li>
<li><a href="javascript:myFunction3()">Search Student</a></li>
<li><a href="javascript:myFunction2()">Delete Questions</a></li>
<li><a href="javascript:myFunction1()">Add Questions</a></li>
<li><a href="admin_area.jsp">Home</a></li>
<li style="float : left"><a href="">Welcome <%= session.getAttribute("name") %></a></li>
</ul>

<% if(request.getParameter("email") == null && request.getParameter("language") == null && request.getParameter("companyName") == null && request.getParameter("studentType") == null && request.getParameter("companyType") == null){ %>

<div class="introduction" id="intro" style="display: block">
<h1 style="font-size: 500% ; color: #D14536 ">Admin Dashboard</h1>
<h2>It's Now The time To Be Responsible!!</h4>
<h4 style="font-weight: 0">Navigate Through Panel To Manage The Things</h4>
</div>
<% } %>
<% 
PreparedStatement pstSearch ;
String email = request.getParameter("email");
String language = request.getParameter("language");
String companyName = request.getParameter("companyName");

if(companyName == null && request.getParameter("studentType") != null){

if(email != null){
	pstSearch = con.prepareStatement("select * from student where Email=? ;");
	pstSearch.setString(1,email);
}else if(language != null){
	pstSearch = con.prepareStatement("select * from student where "+language+"Score"+" IS NOT NULL ;");
}else{
	pstSearch = con.prepareStatement("select * from student ;");
}

ResultSet rs = pstSearch.executeQuery();

if(!rs.next()){
//	%>  <h1 style="margin-left : 35%">No Students Found :(</h1>  <%
}else{
	rs.beforeFirst();
%>

<script type="text/javascript">
	function showArticle() {
		var x = document.getElementById('search_results');
			if (x.style.display === 'none') {
		    x.style.display = 'block';
		    
		} else {
		    x.style.display = 'none';
		}
			document.getElementById('intro').style.display = 'none';		
		}
	</script>

<div class="box" id="search_results" >
<table>
<tr>
<th>Name</th>
<th>Gender</th>
<th>Mobile</th>
<th>City</th>
<th>Qualification</th>
<th>Year</th>
</tr>

<% while(rs.next()){ %>

<tr>
<td><%= rs.getString("Name") %></td>
<td><%= rs.getString("Gender") %></td>
<td><%= rs.getString("Mobile") %></td>
<td><%= rs.getString("City") %></td>
<td><%= rs.getString("Qualification") %></td>
<td><%= rs.getString("Year") %></td>
</tr>


<% }%>


</table>
</div>
<% }
}else if(companyName != null){ 
pstSearch = con.prepareStatement("select * from company where Name=? ;");	
pstSearch.setString(1, companyName);
ResultSet rs = pstSearch.executeQuery();

if(!rs.next()){
//	%>  <h1 style="margin-left : 35%">No Company Found :(</h1>  <%
}else{
	rs.beforeFirst();
%>

<script type="text/javascript">
	function showArticle() {
		var x = document.getElementById('search_results');
			if (x.style.display === 'none') {
		    x.style.display = 'block';
		} else {
		    x.style.display = 'none';
		}
		document.getElementById('intro').style.display = 'none';
		}
	</script>

<div class="box" id="search_results">
<table>
<tr>
<th>Name</th>
<th>Address</th>
<th>Company Type</th>
</tr>

<% while(rs.next()){ %>

<tr>
<td><%= rs.getString("Name") %></td>
<td><%= rs.getString("Address") %></td>
<td><%= rs.getString("Type") %></td>
</tr>


<% }%>


</table>
</div>
<% }
}else if(request.getParameter("companyType") != null){ 
pstSearch = con.prepareStatement("select * from company where Type=? ;");	
pstSearch.setString(1, request.getParameter("companyType"));
ResultSet rs = pstSearch.executeQuery();

if(!rs.next()){
//	%>  <h1 style="margin-left : 35%">No Company Found :(</h1>  <%
}else{
	rs.beforeFirst();
%>

<script type="text/javascript">
	function showArticle() {
		var x = document.getElementById('search_results');
			if (x.style.display === 'none') {
		    x.style.display = 'block';
		} else {
		    x.style.display = 'none';
		}
		document.getElementById('intro').style.display = 'none';
		}
	</script>

<div class="box" id="search_results">
<table>
<tr>
<th>Name</th>
<th>Address</th>
<th>Company Type</th>
</tr>

<% while(rs.next()){ %>

<tr>
<td><%= rs.getString("Name") %></td>
<td><%= rs.getString("Address") %></td>
<td><%= rs.getString("Type") %></td>
</tr>


<% }%>


</table>
</div>
<% }
}%>


<div id="radio" class="questions" style="display: none" >
<input type="radio" name="language" id="languageRadio" onclick="handleRadioClick(this);" value="c" checked> C
  <input type="radio" name="language" id="languageRadio"  onclick="handleRadioClick(this);" value="java"> Java
  <input type="radio" name="language" id="languageRadio"  onclick="handleRadioClick(this);" value="php"> PHP  

<div id="cquestions" style="display: block"  >
<h2> Questions : </h2>
<form action="deletequestion.jsp" name="myform" method="post"> 
<%
count = 1 ;
rsQuestions = pstGetQuestions.executeQuery();
while(rsQuestions.next()){
	if(rsQuestions.getString("Language") != null && rsQuestions.getString("Language").toLowerCase().equals("c")){
%>
<span><b>Question # <%= count %> </b> </span>
<p><input type="checkbox" name="ques<%= count %>" value="<%= rsQuestions.getString("Heading") %>"><%= rsQuestions.getString("Heading") %> </p>
<br>
<% 
	count++ ;
	}
}
%>
<input type="text" name="languageInput" value="C" style=" display: none " ></input>
<button name="btnSubmit" class="button buttonCustom" type="submit">Delete</button>
</form>
</div>

<div id="javaquestions" style="display: none"  >
<h2> Questions : </h2>
<form action="deletequestion.jsp" name="myform" method="post"> 
<%
count = 1 ;
rsQuestions = pstGetQuestions.executeQuery();
while(rsQuestions.next()){
	if(rsQuestions.getString("Language") != null && rsQuestions.getString("Language").toLowerCase().equals("java")){
%>
<span><b>Question # <%= count %> </b> </span>
<p><input type="checkbox" name="ques<%= count %>" value="<%= rsQuestions.getString("Heading") %>"><%= rsQuestions.getString("Heading") %> </p>
<br>
<% 
	count++ ;
	}
}
%>
<input type="text" name="languageInput" value="Java" style=" display: none " ></input>
<button name="btnSubmit" class="button buttonCustom" type="submit">Delete</button>
</form>
</div>

<div id="phpquestions" style="display: none"  >
<h2> Questions : </h2>
<form action="deletequestion.jsp" name="myform" method="post"> 
<%
count = 1 ;
rsQuestions = pstGetQuestions.executeQuery();
while(rsQuestions.next()){
	if(rsQuestions.getString("Language") != null && rsQuestions.getString("Language").toLowerCase().equals("php")){
%>
<span><b>Question # <%= count %> </b> </span>
<p><input type="checkbox" name="ques<%= count %>" value="<%= rsQuestions.getString("Heading") %>"><%= rsQuestions.getString("Heading") %> </p>
<br>
<% 
	count++ ;
	}
}
%>
<input type="text" name="languageInput" value="PHP" style=" display: none " ></input>
<button name="btnSubmit" class="button buttonCustom" type="submit">Delete</button>
</form>
</div>

</div>

<div class="questions" id="addquestions" style="display: none">
  <form action="addquestion.jsp" method="post">
  
    <input type="text" id="questionHeading" name="questionHeading" placeholder="Your Question.." autocomplete="off" required>
    <input type="text" id="option1" name="option1" placeholder="Your First Option.." autocomplete="off" required>
    <input type="text" id="option2" name="option2" placeholder="Your Second Option.." autocomplete="off" required>
    <input type="text" id="option3" name="option3" placeholder="Your Third Option.." autocomplete="off" required>
    <input type="text" id="option4" name="option4" placeholder="Your Fourth Option.." autocomplete="off" required>
    <input type="text" id="rightAnswer" name="rightAnswer" placeholder="Your Correct Answer.." autocomplete="off" required>
    <select class="selction" name="language" required>
  <option>Select Language</option>
  <option>C</option>
  <option>Java</option>
  <option>PHP</option>
  </select>
  
    <button name="btnSubmit" class="button buttonCustom" type="submit">ADD</button>
  </form>
</div>

<div class="search" id="searchStudent" style="display: none">

	<form action="admin_area.jsp" method="post">
	<input type="email" id="email" name="email" placeholder="Search By Email">
	<input type="hidden" style="display: none" name="studentType" value="student" ></input>
	<button name="btnSubmit" class="button buttonCustom" type="submit">Search</button>
	</form>
	<h3>OR</h3>
	<form action="admin_area.jsp" method="post">
	<select class="selction" name="language">
  <option>Search By Topic</option>
  <option>C</option>
  <option>Java</option>
  <option>PHP</option>
  </select>
  <input type="hidden" style="display: none" name="studentType" value="student" ></input>
	<button name="btnSubmit" class="button buttonCustom" type="submit">Search</button>
	</form>
	<h3>OR</h3>
	<form action="admin_area.jsp" method="post">
	<input type="hidden" style="display: none" name="studentType" value="student" ></input>
	<button name="btnSubmit" class="button buttonCustom" type="submit">Search All Students</button>
	</form>
</div>

<div class="search" id="searchCompany" style="display: none">

	<form action="admin_area.jsp" method="post">
	<input type="text" id="companyName" name="companyName" placeholder="Search By Company Name">
	<button name="btnSubmit" onclick="window.location.href='admin_area.jsp';" class="button buttonCustom" type="submit">Search</button>
	</form>
	<h3>OR</h3>
	<form action="admin_area.jsp" method="post">
	<select class="selction" name="companyType">
  	<option>Select Type</option>
  	<option>Product Based</option>
 	<option>Service Based</option>
  	</select>
	<button name="btnSubmit" class="button buttonCustom" type="submit">Search By Type</button>
	</form>
	
</div>

<br><br><br>

<script type="text/javascript">

var a = document.getElementById('radio');
var b = document.getElementById('addquestions');
var c = document.getElementById('searchStudent');
var d = document.getElementById('searchCompany');
var e = document.getElementById('search_results');
var f = document.getElementById('intro');

function myFunction1() {
	
	if (b.style.display = 'none') {
        b.style.display = 'block';
    } else {
        b.style.display = 'none';
    }
	
	a.style.display = 'none';
	c.style.display = 'none';
	d.style.display = 'none';
	if (e != null ) {
	e.style.display = 'none';
	}
	f.style.display = 'none';
   	
}

function myFunction2() {
   
   	if (a.style.display = 'none') {
        a.style.display = 'block';
    } else {
        a.style.display = 'none';
    }
   	
   	b.style.display = 'none';
	c.style.display = 'none';
	d.style.display = 'none';
	if (e != null) {
	e.style.display = 'none';
	}
	f.style.display = 'none';
    
}

function myFunction3() {
	
   	if (c.style.display = 'none') {
        c.style.display = 'block';
    } else {
        c.style.display = 'none';
    }
    
    
   	a.style.display = 'none';
	b.style.display = 'none';
	d.style.display = 'none';
	if (e != null) {
	e.style.display = 'none';
	}
	f.style.display = 'none'; 
    
}

function myFunction4() {
   
   	if (d.style.display = 'none') {
        d.style.display = 'block';
    } else {
        d.style.display = 'none';
    }
    
   	a.style.display = 'none';
	b.style.display = 'none';
	c.style.display = 'none';
	if (e != null) {
	e.style.display = 'none';
	}
	f.style.display = 'none';
    
}

function handleRadioClick(myRadio) {
    if(myRadio.value == 'c'){
    	document.getElementById('cquestions').style.display = 'block' ;
    	document.getElementById('javaquestions').style.display = 'none' ;
    	document.getElementById('phpquestions').style.display = 'none' ;
    }else if(myRadio.value == 'java'){
    	document.getElementById('cquestions').style.display = 'none' ;
    	document.getElementById('javaquestions').style.display = 'block' ;
    	document.getElementById('phpquestions').style.display = 'none' ;
    }else if(myRadio.value == 'php'){
    	document.getElementById('cquestions').style.display = 'none' ;
    	document.getElementById('javaquestions').style.display = 'none' ;
    	document.getElementById('phpquestions').style.display = 'block' ;
    }
}


</script>

</body>
</html>




