<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>
<% 

// fetch the data of html form
String question = request.getParameter("questionHeading");
String option1 = request.getParameter("option1");
String option2 = request.getParameter("option2");
String option3 = request.getParameter("option3");
String option4 = request.getParameter("option4");
String rightAnswer = request.getParameter("rightAnswer");
String language = request.getParameter("language");
int r = 0 ;

PreparedStatement pst ;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

pst = con.prepareStatement("insert into question(Heading,option1,option2,option3,option4,RightAnswer,Language) values(?,?,?,?,?,?,?);");
pst.setString(1, question);
pst.setString(2, option1);
pst.setString(3, option2);
pst.setString(4, option3 );
pst.setString(5, option4 );
pst.setString(6, rightAnswer );
pst.setString(7, language );
r = pst.executeUpdate();




if(r != 0){
	//out.println("<a href='login.html'>Go to login</a>");
%>
<jsp:include page="admin_area.jsp"></jsp:include>
<% 
}
%>