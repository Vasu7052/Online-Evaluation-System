package JavaClasses;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendAttachment{
	
	
 public String send(String to , String filename , String language , String score) {

  final String user="evaluationsystemonline@gmail.com";
  final String password="Online@evaluation";
  final String emailSMTPserver = "smtp.gmail.com";
  final String emailServerPort = "465";
 
  Properties props = new Properties();
  props.put("mail.smtp.user",user);
  props.put("mail.smtp.host", emailSMTPserver);
  props.put("mail.smtp.port", emailServerPort);
  props.put("mail.smtp.starttls.enable", "true");
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.socketFactory.port", emailServerPort);
  props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
  props.put("mail.smtp.socketFactory.fallback", "false");

  Session session = Session.getDefaultInstance(props,
   new javax.mail.Authenticator() {
   protected PasswordAuthentication getPasswordAuthentication() {
   return new PasswordAuthentication(user,password);
   }
  });
   
  try{
    MimeMessage message = new MimeMessage(session);
    message.setFrom(new InternetAddress(user));
    message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
    message.setSubject("Exam Report");
    
    BodyPart messageBodyPart1 = new MimeBodyPart();
    messageBodyPart1.setText("This is Your "+ language +" Report !! \nYour " + language + " Score is : " + score + "\nThank You \nPerformance Evaluation Team");
    
    MimeBodyPart messageBodyPart2 = new MimeBodyPart();

    DataSource source = new FileDataSource(filename);
    messageBodyPart2.setDataHandler(new DataHandler(source));
    messageBodyPart2.setFileName(filename.substring(filename.indexOf("/") + 1));
   
   
    Multipart multipart = new MimeMultipart();
    multipart.addBodyPart(messageBodyPart1);
    multipart.addBodyPart(messageBodyPart2);

    message.setContent(multipart );
   
    Transport.send(message);
 
   return "Message Sent" ;
   }catch (MessagingException ex) {ex.printStackTrace();
   return "" ;}
 }
}