package JavaClasses;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;

public class DownloadFile {
	
	public void download(String fileAddress , HttpServletResponse response) throws ServletException, IOException {
		 BufferedInputStream buf=null;
		  ServletOutputStream myOut=null;

		try{

			myOut = response.getOutputStream( );
		    File myfile = new File(fileAddress);
		    
		    //set response headers
		    response.setContentType("text/plain");
		    
		    response.addHeader(
		       "Content-Disposition","attachment; filename="+fileAddress.substring(fileAddress.lastIndexOf("/") + 1) );

		    response.setContentLength( (int) myfile.length( ) );
		    
		    FileInputStream input = new FileInputStream(myfile);
		    buf = new BufferedInputStream(input);
		    int readBytes = 0;

		    while((readBytes = buf.read( )) != -1)
		      myOut.write(readBytes);

		} catch (IOException ioe){
		    
		       throw new ServletException(ioe.getMessage( ));
		        
		} 
		        
		        if (myOut != null) 
		        {myOut.close( );}
		        
		         if (buf != null) 
		         {buf.close( );}
		        


	}

}
