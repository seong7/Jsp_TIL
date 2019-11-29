package mail;

public class MailSend {
	
	//정상적인 id와 email를 입력 받으면 메일을 보내고 true 리턴
	public boolean sendPwd(String id, String email) {
		boolean flag = false;
		MemberMgr mgr = new MemberMgr();
		String pwd = mgr.findPwd(id, email);
		if(pwd!=null&&!pwd.equals("")) {
			String content = "id : " + id  + " / pwd : " + pwd;
			GmailSend.send("000.com에서 id와 pwd를 전송합니다.", content, email);
			flag = true;
		}
		return flag;
	}
}
