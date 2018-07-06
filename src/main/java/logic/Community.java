package logic;

import java.util.Date;

public class Community {
	private int communityno;
	private String memberid;
	private String subject;
	private String content;
	private Date regdate;
	private int communitykind;
	public int getCommunityno() {
		return communityno;
	}
	public void setCommunityno(int communityno) {
		this.communityno = communityno;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getCommunitykind() {
		return communitykind;
	}
	public void setCommunitykind(int communitykind) {
		this.communitykind = communitykind;
	}
	@Override
	public String toString() {
		return "Community [communityno=" + communityno + ", memberid=" + memberid + ", subject=" + subject
				+ ", content=" + content + ", regdate=" + regdate + ", communitykind=" + communitykind + "]";
	}
	
}
