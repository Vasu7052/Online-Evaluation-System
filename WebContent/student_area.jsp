<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>
<% 

if(session.getAttribute("loginStatus") == null || !session.getAttribute("loginStatus").equals("yes") || !session.getAttribute("loginUser").equals("student")){
	response.sendRedirect("error_page.jsp?message=You Are Not Logged In");
}

session.setAttribute("PHPScore" , 0);
session.setAttribute("CScore" , 0);
session.setAttribute("JavaScore" , 0);
session.setAttribute("JavaDetailScore" , "");
session.setAttribute("CDetailScore" , "");
session.setAttribute("PHPDetailScore" , "");
session.setAttribute("languageDetail", "Java"); 

String userName = "" , userMobile = "" , userCity = "" , userQualification = "" , userYear = "" ;    

int count = 1 ;
PreparedStatement pstGetJava , pstGetC , pstGetPhp ;
ResultSet rsGetJava, rsGetC , rsGetPhp ;

String[] strReport = new String[10];

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

pstGetJava = con.prepareStatement("select * from question where Language='Java' ;");
rsGetJava = pstGetJava.executeQuery();

pstGetC = con.prepareStatement("select * from question where Language='C' ;");
rsGetC = pstGetJava.executeQuery();

pstGetPhp = con.prepareStatement("select * from question where Language='PHP' ;");
rsGetPhp = pstGetJava.executeQuery();

%>


<!DOCTYPE html>
<html>
<head>
<script>
window.history.forward();
</script>

<title>Student Area</title>

<style>

body{
background-color : #fff ;
margin : 0;
}

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
background-image : url(student-header.jpg);
background-repeat: no-repeat;
background-size: cover;
}

div.gallery {
    padding : 15px ;
    margin: 10px;
    border: 2px solid #fff ;
    border-radius: 15px ;
    float: left;
    width: 180px;
}

div.gallery:hover {
    border: 2px solid #666;
    border-radius: 15px ;
}

div.gallery img {
    width: 100%;
    height: 100%;
}

div.desc {
    padding: 15px;
    text-align: center;
}

.images{
text-align : center ;
	margin-left: 25% ;
}

table {
    border-collapse: collapse;
    width: 100%;
    table-layout: fixed; 
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

.table-box{

	text-align : center ;
	width: 80& ;
	height: auto ;
	background-color: white ;
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

.Absolute-Center {
  text-align : center ;	
  background : #F6F6F6 ;
  margin: auto;
  position: absolute;
  top: 0; left: 0; bottom: 0; right: 0;
  height : 500px ;
  width : 700px ;
  display: block;
}

input[type=text],input[type=email],input[type=password],input[type=number], select {
    width: 300px ;
    padding: 12px 20px;
    margin: 8px 8px;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.button {
    background-color: #4CAF50; 
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width: 300px ;
}

.buttonCustom {
border-radius: 10px;
}

.button-cancel {
    background-color: #ff0000 ; 
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width: 300px ;
}

.buttonCustom {
border-radius: 10px;
}

.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
}

img.avatar {
    width: 30%;
    border-radius: 50%;
}


</style>
</head>
<body>

<div class="top"></div>
<ul>
<li><a href="logout.jsp">Logout</a></li>
<li><a href="javascript:myFunction3();" >Update Profile</a></li>
<li><a href="javascript:myFunction1();">Give Exam</a></li>
<li><a href="javascript:showReport()">See Reports</a></li>
<li><a href="student_area.jsp">Home</a></li>
<li style="float : left"><a href="">Welcome <%= session.getAttribute("name") %></a></li>
</ul>


<div class="introduction" id="intro" style="display: block">
<h1 style="font-size: 500% ; color: #30E6F1">Student Dashboard</h1>
<h2>Because ! The best way to predict your future is to create it</h4>
<h4 style="font-weight: 0">Navigate Through Panel To Explore Yourself</h4>
</div>



<div class="images" id="images" style="display : none ">
<div class="gallery">
  <a href="questions.jsp?language=c&email=<%= session.getAttribute("email") %>">
    <img src="c-logo.png" alt="Trolltunga Norway" width="500" height="500">
  </a>
  <div class="desc">C Exam</div>
</div>

<div class="gallery">
  <a href="questions.jsp?language=java&email=<%= session.getAttribute("email") %>"">
    <img src="java-logo.png" alt="Forest" width="500" height="500">
  </a>
  <div class="desc">Java Exam</div>
</div>

<div class="gallery">
  <a href="questions.jsp?language=php&email=<%= session.getAttribute("email") %>"">
    <img src="php-logo.png" alt="Northern Lights" width="600" height="400">
  </a>
  <div class="desc">PHP Exam</div>
</div>
</div>


<%

	String yourAnswer = "" , rightStatus = "" ;
	String JavaScore = null , CScore =null , PHPScore = null , JavaGrade = null , CGrade = null , PHPGrade = null , reportFullStringJava ="" , reportFullStringC = "" , reportFullStringPHP = "";
	String[] splitJava = null , splitC = null , splitPHP = null ; 
	String[] rightAnswerJava = new String[10] , rightAnswerC = new String[10] , rightAnswerPHP = new String[10] ; 
	int rightAnswerCount = 0 ;
	PreparedStatement pstReport;
	ResultSet rsReport ;

	String email = (String) session.getAttribute("email");
	
	pstReport = con.prepareStatement("select * from student where Email=? ;");
	pstReport.setString(1,email);
	
	rsReport = pstReport.executeQuery();
	
	ResultSet rsRightAnswerJava = con.prepareStatement("select RightAnswer from question where Language='Java' ;").executeQuery();
	ResultSet rsRightAnswerC = con.prepareStatement("select RightAnswer from question where Language='C' ;").executeQuery();
	ResultSet rsRightAnswerPHP = con.prepareStatement("select RightAnswer from question where Language='PHP' ;").executeQuery();
		
	while(rsRightAnswerJava.next()){
		rightAnswerJava[rightAnswerCount] = rsRightAnswerJava.getString("RightAnswer");
		rightAnswerCount++;
	}rightAnswerCount = 0;
	while(rsRightAnswerC.next()){
		rightAnswerC[rightAnswerCount] = rsRightAnswerC.getString("RightAnswer");
		rightAnswerCount++;
	}rightAnswerCount = 0 ;
	while(rsRightAnswerPHP.next()){
		rightAnswerPHP[rightAnswerCount] = rsRightAnswerPHP.getString("RightAnswer");
		rightAnswerCount++;
	}
%>

  <% while(rsReport.next()){ 
	  
	  userName = rsReport.getString("Name");
	  userMobile = rsReport.getString("Mobile");
	  userCity = rsReport.getString("City");
	  userQualification = rsReport.getString("Qualification");
	  userYear = rsReport.getString("Year");
	  
	  if(rsReport.getString("JavaScore") == null ){
		  JavaScore = "N/A" ;
	  }else{
		  if(rsReport.getString("JavaDetailScore") != null){
		  reportFullStringJava = rsReport.getString("JavaDetailScore").substring(1);
		  }
		  JavaScore = rsReport.getString("JavaScore") + "/" + rsReport.getString("JavaTotal") ;
		  JavaGrade = String.valueOf(rsReport.getInt("JavaGrade")) ;
		  splitJava = reportFullStringJava.split("\\|");
	  }
	  
	  if(rsReport.getString("CScore") == null ){
		  CScore = "N/A" ;
	  }else{
		  if(rsReport.getString("CDetailScore") != null){
		  reportFullStringC = rsReport.getString("CDetailScore").substring(rsReport.getString("CDetailScore").indexOf("|") + 1);
		  }
		  CScore = rsReport.getString("CScore") + "/" + rsReport.getString("CTotal") ;
		  CGrade = String.valueOf(rsReport.getInt("CGrade")) ;
		  splitC = reportFullStringC.split("\\|");
	  }
	  
	  if(rsReport.getString("PHPScore") == null ){
		  PHPScore = "N/A" ;
	  }else{
		  if(rsReport.getString("PHPDetailScore") != null){
		  reportFullStringPHP = rsReport.getString("PHPDetailScore").substring(rsReport.getString("PHPDetailScore").indexOf("|") + 1);
		  }
		  PHPScore = rsReport.getString("PHPScore") + "/" + rsReport.getString("PHPTotal") ;
		  PHPGrade = String.valueOf(rsReport.getInt("PHPGrade")) ;
		  splitPHP = reportFullStringPHP.split("\\|");
	  }
  }
  
  
  %>

<div class="table-box" id="reportTable" style="display: none" >
<input type="radio" name="language" id="languageRadio" onclick="handleRadioClick(this);" value="Java" checked> Java
  <input type="radio" name="language" id="languageRadio"  onclick="handleRadioClick(this);" value="C"> C
  <input type="radio" name="language" id="languageRadio"  onclick="handleRadioClick(this);" value="PHP"> PHP  
  <p></p>
  <div id="JavaDetail">
  
  <%
  if(splitJava != null){
  %><table>
  <tr>
  	<th>Question No.</th>
    <th>Your Answer</th>
    <th>Right Answer</th>
    <th>Status</th>
  </tr><%
  for(int i=0 ; i < splitJava.length ; i++){ 
  
	  if(splitJava[i].equals("null")){
		  yourAnswer = "N/A" ;
		  rightStatus = "Not Attempted" ;
	  }else{
		  yourAnswer = splitJava[i] ;
		  if(splitJava[i].trim().equals(rightAnswerJava[i])){
			  rightStatus = "Correct" ;
		  }else{
			  rightStatus = "Incorrect" ;
		  }
	  } 
  
  %>
  <tr>
  	<td><%= i+1 %></td>
    <td><%= yourAnswer %></td>
    <td><%= rightAnswerJava[i] %></td>
  	<td><%= rightStatus %></td>
  	
  	<% } %>

</table><h3 style="float:center"><%= "Your Total Score : " + JavaScore %></h3>
<h4 style="float:center ; margin-top: -5px ;"><%= "Your Grade : " + JavaGrade + "%" %></h4> 
	<a id="java" href="download_file.jsp?sendLanguage=Java" style=" color: #228B22 ; margin-right:10px ;" >Download this Report</a>
	<a href="email_report.jsp?sendLanguage=Java" style="color: #228B22 " >Email this Report to Myself</a><%  
  } else {out.println("<h3>No Test Given of this Language</h3>");}%>
</div>

  <div id="CDetail" style="Display:none" >
  
  <%
  if(splitC != null){
  %><table>
  <tr>
  	<th>Question No.</th>
    <th>Your Answer</th>
    <th>Right Answer</th>
    <th>Status</th>
  </tr><%
  
  for(int i=0 ; i < splitC.length ; i++){ 
	  
	  if(splitC[i].equals("null")){
		  yourAnswer = "N/A" ;
		  rightStatus = "Not Attempted" ;
	  }else{
		  yourAnswer = splitC[i] ;
		  if(splitC[i].trim().equals(rightAnswerC[i])){
			  rightStatus = "Correct" ;
		  }else{
			  rightStatus = "Incorrect" ;
		  }
	  } 
  
  %>
  <tr>
  	<td><%= i+1 %></td>
    <td><%= yourAnswer %></td>
    <td><%= rightAnswerC[i] %></td>
  	<td><%= rightStatus %></td>
  	
  	<% } %>
  	
</table><h3 style="float:center"><%= "Your Total Score : " + CScore %></h3> 
<h4 style="float:center ; margin-top: -5px ;"><%= "Your Grade : " + CGrade + "%" %></h4>  
	<a id="java" href="download_file.jsp?sendLanguage=C" style=" color: #228B22 ; margin-right:10px ;" >Download this Report</a>
	<a href="email_report.jsp?sendLanguage=C" style="color: #228B22 " >Email this Report to Myself</a><%  
  } else {out.println("<h3>No Test Given of this Language</h3>");}%>


</div>

  <div id="PHPDetail" style="Display:none" >
  
  <%
  if(splitPHP != null){
  %><table>
  <tr>
  	<th>Question No.</th>
    <th>Your Answer</th>
    <th>Right Answer</th>
    <th>Status</th>
  </tr><%
  
 for(int i=0 ; i < splitPHP.length ; i++){ 
	  
	  if(splitPHP[i].equals("null")){
		  yourAnswer = "N/A" ;
		  rightStatus = "Not Attempted" ;
	  }else{
		  yourAnswer = splitPHP[i] ;
		  if(splitPHP[i].trim().equals(rightAnswerPHP[i])){
			  rightStatus = "Correct" ;
		  }else{
			  rightStatus = "Incorrect" ;
		  }
	  } 
  
  %>
  <tr>
  	<td><%= i+1 %></td>
    <td><%= yourAnswer %></td>
    <td><%= rightAnswerPHP[i] %></td>
  	<td><%= rightStatus %></td>
  	
  	<% } %>
</table><h3 style="float:center"><%= "Your Total Score : " + PHPScore %></h3>
<h4 style="float:center ; margin-top: -5px ;"><%= "Your Grade : " + PHPGrade + "%" %></h4> 
<a id="java" href="download_file.jsp?sendLanguage=PHP" style=" color: #228B22 ; margin-right:10px ;" >Download this Report</a>
<a id="java" href="email_report.jsp?sendLanguage=PHP" style="color: #228B22 " >Email this Report to Myself</a><%
  } else {out.println("<h3>No Test Given of this Language</h3>");}%> 

</div>

</div>

<div class="Absolute-Center" id="profile" style="display : none ">

<form action="update_profile.jsp" method="post">

   <div class="imgcontainer">
    <img src="profile_placeholder.png" alt="Avatar" class="avatar" >
  </div>

  <input type="text" name="name" id="name" placeholder="Name" value="<%= userName %>" required/>
  <input type="email" name="email" id="name" placeholder="Email" value="<%= email %>" disabled />
  <input type="number" name="mobile" id="name" placeholder="Mobile" value="<%= userMobile %>" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="10" required/>
  <input type="text" name="city" id="name" placeholder="City" value="<%= userCity %>" required/>
  
  <select class="selction" name="qualification" id="qualification" >
  <option>Select Qualification</option>
  <option value="BTech" >BTech</option>
  <option value="MCA" >MCA</option>
  <option value="BCA" >BCA</option>
  <option value="Others" >Others</option>
  </select>
  <select class="selction" name="year" id="year" > 
  <option>Select Year</option>
  <option value="2014-2015" >2014-2015</option>
  <option value="2015-2016" >2015-2016</option>
  <option value="2016-2017" >2016-2017</option>
  <option value="Pursuing" >Pursuing</option>
  </select>
  <br>
  <button name="btnSubmit" class="button buttonCustom" type="submit">Update Profile</button>
  <button type="button" class="button-cancel buttonCustom" onclick="javascript:myFunction3();">Cancel</button>
  </form>
  
  
</div>

</body>

<script type="text/javascript" >
	function myFunction1() {
	document.getElementById('reportTable').style.display = 'none';
    var x = document.getElementById('images');
    if (x.style.display === 'none') {
        x.style.display = 'block';
    } else {
        x.style.display = 'none';
    }
    
    document.getElementById('intro').style.display = 'none';
    document.getElementById('profile').style.display = 'none';
    
	}
	
	function showReport(){
		document.getElementById('images').style.display = 'none';
		var x = document.getElementById('reportTable');
		if (x.style.display === 'none') {
	        x.style.display = 'block';
	    } else {
	        x.style.display = 'none';
	    }
		
		document.getElementById('intro').style.display = 'none';
		document.getElementById('profile').style.display = 'none';
		
	}
	
	function myFunction3(){
	    var x = document.getElementById('profile');
	    if (x.style.display === 'none') {
	        x.style.display = 'block';
	    } else {
	        x.style.display = 'none';
	    }
	    
	    document.getElementById('reportTable').style.display = 'none';
	    document.getElementById('images').style.display = 'none';
	    
	}
	
	function handleRadioClick(myRadio) {
	    if(myRadio.value == 'C'){
	    	document.getElementById('CDetail').style.display = 'block' ;
	    	document.getElementById('JavaDetail').style.display = 'none' ;
	    	document.getElementById('PHPDetail').style.display = 'none' ;
	    }else if(myRadio.value == 'Java'){
	    	document.getElementById('CDetail').style.display = 'none' ;
	    	document.getElementById('JavaDetail').style.display = 'block' ;
	    	document.getElementById('PHPDetail').style.display = 'none' ;
	    }else if(myRadio.value == 'PHP'){
	    	document.getElementById('CDetail').style.display = 'none' ;
	    	document.getElementById('JavaDetail').style.display = 'none' ;
	    	document.getElementById('PHPDetail').style.display = 'block' ;
	    }
	}
	
	document.getElementById('qualification').value = '<%= userQualification %>' ;
	document.getElementById('year').value = '<%= userYear %>' ;
		
</script>

</html>









