<%@ page import="java.sql.*" %>
<%@ page errorPage = "error_page.jsp" %>

<!DOCTYPE html>
<html>
<head>

<title>Search Results</title>

<style>

body{
margin : 0;
background-color: #eee ;
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

.box{
	
	width: 80& ;
	height: auto ;
	background-color: #eee ;
	margin-left: 20px ;
	margin-right: 20px ;
	margin-top: 20px ;
	padding : 20px ;
}

</style>
	
</head>

<body> 

<%

	
	PreparedStatement pstSearch ;

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

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
<div class="box">
<table>
  <tr>
    <th>Name</th>
    <th>Mobile</th>
    <th>City</th>
    <th>Qualification</th>
    <th>Year</th>
  </tr>
  
  <% while(rs.next()){ %>
  
  <tr>
    <td><%= rs.getString("Name") %></td>
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
<div class="box">
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
<div class="box">
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

</body>
</html>
  
  
  
  
  
  
  
  
  