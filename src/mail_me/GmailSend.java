package mail_me;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class GmailSend {

	private static class SMTPAuthenticator extends Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			//Gmail 아이디, 비밀번호
			return new PasswordAuthentication("sujikim1123", "!tjd19wls03");
		}
	}
	
	public static boolean send(String title, String content, String toEmail) {
		boolean flag = false;
		
		Properties p = new Properties();
		p.put("mail.smtp.user", "sujikim11123@gmail.com"); // 본인 gmail
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		
		p.put("mail.smtp.debut", "true");
		p.put("mail.smtp.socketFactory.port", "465"	);
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smpt.socketFactory.fallback", "false");
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true);
			
			MimeMessage msg = new MimeMessage(session);
			String message = content;
			msg.setSubject(title);
			
			Address fromAddr = new InternetAddress("sujikim1123@gmail.com");
			msg.setFrom(fromAddr);
			
			Address toAddr= new InternetAddress(toEmail);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(message, "text/plain; charset=KSC5601");
			
			Transport.send(msg);
			flag = true;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
//	public static void main(String[] args) {
//		send("제목", "내용", "seongjinkim1123@gmail.com");
//		System.out.println("성공 !!!!!");
//	}

	
	//from : netflix720222@gmail.com
	// to : 
}
