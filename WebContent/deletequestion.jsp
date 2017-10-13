<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>

<% 

String languageType = request.getParameter("languageInput");
int count = 1 ;
int r = 0 ;
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

PreparedStatement pst = con.prepareStatement("select * from question where Language=? ;");
pst.setString(1,languageType  );

ResultSet rs = pst.executeQuery();

if(request.getParameter("btnSubmit")!=null) 
{
    while(rs.next()){
    	
    	if(request.getParameter("ques"+count) != null ){
    		
    		PreparedStatement pstUpdate = con.prepareStatement("delete from question where Heading=? ;");
    		pstUpdate.setString(1, request.getParameter("ques"+count) );
    		r = pstUpdate.executeUpdate();
    	}
    	count++ ;
    }
    
    if(r != 0){
    	response.sendRedirect("admin_area.jsp");
    	return;
    }else{
    	
    }
}

%>