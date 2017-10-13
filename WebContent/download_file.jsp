<%@page import="JavaClasses.DownloadFile"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="java.io.*" %>
<%@ page errorPage="error_page.jsp" %>
<% 

DownloadFile df = new DownloadFile();

String yourAnswer = "" , rightStatus = "" ;
String language = "" ;
if(request.getParameter("sendLanguage") != null){
	language = request.getParameter("sendLanguage");
}

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ExamSystem" , "vasu" , "root" );

String JavaScore = null , CScore =null , PHPScore = null , reportFullStringJava ="" , reportFullStringC = "" , reportFullStringPHP = "";
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

while(rsReport.next()){ 
  
  
  
  if(rsReport.getString("JavaScore") == null ){
	  JavaScore = "N/A" ;
  }else{
	  if(rsReport.getString("JavaDetailScore") != null){
	  reportFullStringJava = rsReport.getString("JavaDetailScore").substring(1);
	  }
	  JavaScore = rsReport.getString("JavaScore") + "/25" ;
	  splitJava = reportFullStringJava.split("\\|");
  }
  
  if(rsReport.getString("CScore") == null ){
	  CScore = "N/A" ;
  }else{
	  if(rsReport.getString("CDetailScore") != null){
	  reportFullStringC = rsReport.getString("CDetailScore").substring(rsReport.getString("CDetailScore").indexOf("|") + 1);
	  }
	  CScore = rsReport.getString("CScore") + "/25" ;
	  splitC = reportFullStringC.split("\\|");
  }
  
  if(rsReport.getString("PHPScore") == null ){
	  PHPScore = "N/A" ;
  }else{
	  if(rsReport.getString("PHPDetailScore") != null){
	  reportFullStringPHP = rsReport.getString("PHPDetailScore").substring(rsReport.getString("PHPDetailScore").indexOf("|") + 1);
	  }
	  PHPScore = rsReport.getString("PHPScore") + "/25" ;
	  splitPHP = reportFullStringPHP.split("\\|");
  }
}

	String time = new SimpleDateFormat("ddMMmmss").format(new Date());
	
	if(language.equals("Java")){
		try{
			
			   HSSFWorkbook wb = new HSSFWorkbook();
			   HSSFSheet sheet = wb.createSheet("new sheet");
			   HSSFRow rowStart = sheet.createRow((short)0);
				
			   rowStart.createCell((short)0).setCellValue("Question Number");
			   rowStart.createCell((short)1).setCellValue("Your Answer");
			   rowStart.createCell((short)2).setCellValue("Right Answer");
			   rowStart.createCell((short)3).setCellValue("Status");
			   
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
				   
			   HSSFRow row = sheet.createRow((short)i+1);
			   row.createCell((short)0).setCellValue(i+1);
			   row.createCell((short)1).setCellValue(yourAnswer);
			   row.createCell((short)2).setCellValue(rightAnswerJava[i]);
			   row.createCell((short)3).setCellValue(rightStatus);
			   }
			    FileOutputStream fileOut = new FileOutputStream("d:/java"+time+".xls");
			    wb.write(fileOut);
			    fileOut.close();
			    df.download("d:/java"+time+".xls", response);
			    new File("d:/java"+time+".xls").delete();
			    %> <jsp:include page="student_area.jsp"></jsp:include> <%
			        }catch ( Exception ex ){       
			        } 
	}else if(language.equals("C")){
		try{
			   HSSFWorkbook wb = new HSSFWorkbook();
			   HSSFSheet sheet = wb.createSheet("new sheet");
			   HSSFRow rowStart = sheet.createRow((short)0);
				
			   rowStart.createCell((short)0).setCellValue("Question Number");
			   rowStart.createCell((short)1).setCellValue("Your Answer");
			   rowStart.createCell((short)2).setCellValue("Right Answer");
			   rowStart.createCell((short)3).setCellValue("Status");
			   
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
				   
			   HSSFRow row = sheet.createRow((short)i+1);
			   row.createCell((short)0).setCellValue(i+1);
			   row.createCell((short)1).setCellValue(yourAnswer);
			   row.createCell((short)2).setCellValue(rightAnswerC[i]);
			   row.createCell((short)3).setCellValue(rightStatus); 
			   }
			    FileOutputStream fileOut = new FileOutputStream("d:/c"+time+".xls");
			    wb.write(fileOut);
			    fileOut.close();  
			    df.download("d:/c"+time+".xls", response);
			    new File("d:/c"+time+".xls").delete();
			    %> <jsp:include page="student_area.jsp"></jsp:include><%
			        }catch ( Exception ex ){       
			        } 
	}else if(language.equals("PHP")){
		try{
			   HSSFWorkbook wb = new HSSFWorkbook();
			   HSSFSheet sheet = wb.createSheet("new sheet");
			   HSSFRow rowStart = sheet.createRow((short)0);
				
			   rowStart.createCell((short)0).setCellValue("Question Number");
			   rowStart.createCell((short)1).setCellValue("Your Answer");
			   rowStart.createCell((short)2).setCellValue("Right Answer");
			   rowStart.createCell((short)3).setCellValue("Status");
			   
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
				   
			   HSSFRow row = sheet.createRow((short)i+1);
			   row.createCell((short)0).setCellValue(i+1);
			   row.createCell((short)1).setCellValue(yourAnswer);
			   row.createCell((short)2).setCellValue(rightAnswerPHP[i]);
			   row.createCell((short)3).setCellValue(rightStatus); 
			   }
			    FileOutputStream fileOut = new FileOutputStream("d:/PHP"+time+".xls");
			    wb.write(fileOut);
			    fileOut.close(); 
			    df.download("d:/PHP"+time+".xls", response);
			    new File("d:/PHP"+time+".xls").delete();
			    %> <jsp:include page="student_area.jsp"></jsp:include> <%
			        }catch ( Exception ex ){       
			        }
	}


%>