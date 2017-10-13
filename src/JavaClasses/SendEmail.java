package JavaClasses;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class SendEmail { 
	
final String senderEmailID = "evaluationsystemonline@gmail.com";
final String senderPassword = "Online@evaluation";
final String emailSMTPserver = "smtp.gmail.com";
final String emailServerPort = "465";
String receiverEmailID = null;
static String emailSubject = "Test Mail";
static String emailBody = ":)";


public String sendEmail(String receiverEmailID,String Subject,String Body){
	
this.receiverEmailID=receiverEmailID; 
this.emailSubject=Subject;
this.emailBody=Body;

Properties props = new Properties();
props.put("mail.smtp.user",senderEmailID);
props.put("mail.smtp.host", emailSMTPserver);
props.put("mail.smtp.port", emailServerPort);
props.put("mail.smtp.starttls.enable", "true");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.socketFactory.port", emailServerPort);
props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
props.put("mail.smtp.socketFactory.fallback", "false");
SecurityManager security = System.getSecurityManager();
try{ 
Authenticator auth = new SMTPAuthenticator();
Session session = Session.getInstance(props, auth);
MimeMessage msg = new MimeMessage(session);
msg.setText(emailBody);
msg.setSubject(emailSubject);
msg.setFrom(new InternetAddress(senderEmailID));
msg.addRecipient(Message.RecipientType.TO,
new InternetAddress(receiverEmailID));
Transport.send(msg);
return "Message Send Successfully" ;
} catch (Exception mex){
mex.printStackTrace();
return "" ;
} 
}

public class SMTPAuthenticator extends javax.mail.Authenticator
{
public PasswordAuthentication getPasswordAuthentication()
{
return new PasswordAuthentication(senderEmailID, senderPassword);
}
} 

}

// kamalrajpal41@gmail.com