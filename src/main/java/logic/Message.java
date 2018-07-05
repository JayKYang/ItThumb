package logic;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Message implements Serializable{
	private int messageno;
	private String sender;
	@NotEmpty(message="아이디를 입력해주세요")
	private String receiver;
	@NotEmpty(message="제목을 입력해주세요")
	private String subject;
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	private Date senddate;
	private int senddelete;
	private int receivedelete;
	private int confirm;
	public int getMessageno() {
		return messageno;
	}
	public void setMessageno(int messageno) {
		this.messageno = messageno;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSenddate() {
		return senddate;
	}
	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}
	public int getSenddelete() {
		return senddelete;
	}
	public void setSenddelete(int senddelete) {
		this.senddelete = senddelete;
	}
	public int getReceivedelete() {
		return receivedelete;
	}
	public void setReceivedelete(int receivedelete) {
		this.receivedelete = receivedelete;
	}
	public int getConfirm() {
		return confirm;
	}
	public void setConfirm(int confirm) {
		this.confirm = confirm;
	}
	@Override
	public String toString() {
		return "Message [messageno=" + messageno + ", sender=" + sender + ", receiver=" + receiver + ", subject="
				+ subject + ", content=" + content + ", senddate=" + senddate + ", senddelete=" + senddelete
				+ ", receivedelete=" + receivedelete + ", confirm=" + confirm + "]";
	}
	
	
}
