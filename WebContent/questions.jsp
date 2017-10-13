<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>

<% 
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Expires","0");
response.setDateHeader("Expires",-1);
String clock ; %>

<!DOCTYPE html>
<html>
<head>
<script>
window.history.forward();
</script>
<script type="text/javascript">

function goToError(){
	window.location=document.getElementById('goerror').href;
}

</script>
<title>Exam Time!!</title>
<script>
<%
clock = "31";
%>
var timeout = <%=clock%>;
function timer()
{
if( --timeout > 0 )
{
document.getElementById('clock').innerText  = 'Time Left : ' + timeout + ' Seconds';
window.setTimeout( "timer()", 1000 );
}
else
{
document.getElementById('clock').innerText  = "Time over";
document.getElementById('nextButton').click();
}
}
</script>

<style>

body{
margin : 0;
background-image: url(questions_background.png) ;
background-repeat: no-repeat;
}

body{
margin : 0;
background-color: #fff ;
}

ul {
    list-style-type: none;
    overflow: hidden;
    background-color: transparent;
}

li {
	display : block ;
    float: center;
}

.box{
	background-color : #fff ;
	text-align: center ;
	margin-left : auto ;
	margin-right : auto ;
	margin-top : 75px ;
	width : 1250px ;
}

#parent_div_1, #parent_div_2{
	padding-top : 50px ;
    width: 600px;
    height:300px ;
    background-color: #fff ;
    margin-right:5px;
    margin-bottom : 10px ;
    float:left;
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
}

.buttonCustom {border-radius: 10px;}

</style>
	
</head>

<body> 

<a href="student_area.jsp" style="color:white;position:absolute;top:3%;right:7.5%;" >Leave Test !! Go to Home </a>


<%

	int current = 0 ;
	
	ResultSet rsQuestions ;
	Connection con = null ;
	

	String email = request.getParameter("email");
	String language = request.getParameter("language");
	
	if(language != null){
	if(language.equals("c")){
		session.setAttribute("languageType", "C");
	}else if(language.equals("java")){
		session.setAttribute("languageType", "Java");
	}else{
		session.setAttribute("languageType", "PHP");
	}
	}

%>

  <div class="box" >
  
<form NAME="form1" ACTION="questions.jsp" METHOD="get"><%
if (request.getParameter("hidden") != null) {
current = Integer.parseInt(request.getParameter("hidden"));
String hello = (String) (session.getAttribute(session.getAttribute("languageType")+"DetailScore")) ;
if((current-1) == (hello.length() - hello.replace("|", "").length()) ){
session.setAttribute((session.getAttribute("languageType")+"DetailScore") , ((String) (session.getAttribute(session.getAttribute("languageType")+"DetailScore"))) + "|" + request.getParameter("choice") ) ;	
}
}
if(request.getParameter("choice") != null && request.getParameter("choice").equals(request.getParameter("rightAnswer"))){
	session.setAttribute((session.getAttribute("languageType")+"Score") , (((Integer) (session.getAttribute(session.getAttribute("languageType")+"Score"))) + 5 ) );             
}


Class.forName("com.mysql.jdbc.Driver") ;
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

PreparedStatement pstQuestions = null ;

pstQuestions = con.prepareStatement("select * from question where Language=? ;");
pstQuestions.setString(1 , (String) session.getAttribute("languageType"));
rsQuestions = pstQuestions.executeQuery();

for (int i = 0; i < current; i++) {
	rsQuestions.next();
}
if (!rsQuestions.next()) {
out.println("<h2>Thank You For Giving The Exam</h2>");
out.println("<h3>"+ (session.getAttribute("languageType")+"Score") + " : " + (Integer) (session.getAttribute(session.getAttribute("languageType")+"Score")) + "/" + current*5 +"</h3>");
con.prepareStatement("update student set "+(session.getAttribute("languageType")+"Score")+"="+(Integer) (session.getAttribute(session.getAttribute("languageType")+"Score"))+" where Email='"+(String)session.getAttribute("email")+"' ; ").executeUpdate();
// out.println("<h2>" + (String) (session.getAttribute(session.getAttribute("languageType")+"DetailScore")) + "</h2>");
con.prepareStatement("update student set "+(session.getAttribute("languageType")+"DetailScore")+"='"+(String) (session.getAttribute(session.getAttribute("languageType")+"DetailScore"))+"' where Email='"+(String)session.getAttribute("email")+"' ; ").executeUpdate();
int score = (Integer) session.getAttribute(session.getAttribute("languageType")+"Score") ;
int total = current * 5 ;
con.prepareStatement("update student set "+session.getAttribute("languageType")+"Total="+((current)*5)+" , "+session.getAttribute("languageType")+"Grade="+ (int)(((double)score/(double)total) * 100)+" where Email='"+(String)session.getAttribute("email")+"' ;  ").executeUpdate();                                              
session.setAttribute("languageType" , "");
out.println("<a href='student_area.jsp' > Go Hack to Home </a>");
%><%
} else {
	// out.println("<h2>" + (String) (session.getAttribute(session.getAttribute("languageType")+"DetailScore")) + "</h2>");
	// out.println(current);
%>

<div id="parent_div_1">
  <ul>
  <li style="float : center"><h1>Question #<%= current+1 %></h1></li><br>
  <li style="float : center"><%= rsQuestions.getString("Heading") %></li>
  </ul>
  </div>
  
  <div id="parent_div_2">
  <ul>
   <li><input type="radio" name="choice" value="<%= rsQuestions.getString("option1") %>" ><%= rsQuestions.getString("option1") %></input></li><br>
   <li><input type="radio" name="choice" value="<%= rsQuestions.getString("option2") %>" ><%= rsQuestions.getString("option2") %></input></li><br>
   <li><input type="radio" name="choice" value="<%= rsQuestions.getString("option3") %>" ><%= rsQuestions.getString("option3") %></input></li><br>
   <li><input type="radio" name="choice" value="<%= rsQuestions.getString("option4") %>" ><%= rsQuestions.getString("option4") %></input></li><br>
   <li><button id="nextButton" class="button buttonCustom" >Next</button></li>
   <li><h4 style="font-weight:normal" id="clock"></h4></li>
 </ul>
 </div>
 
<INPUT TYPE="hidden" style="display:none" NAME="hidden" VALUE="<%=current + 1%>">
<INPUT TYPE="hidden" style="display:none" NAME="rightAnswer" VALUE="<%= rsQuestions.getString("RightAnswer") %>">


<%
}

%>
</form>
<script>
timer();
</script>
 </div>

</body>


</html>


  
  
  
  
  
  
  