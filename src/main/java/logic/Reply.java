package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Reply {
	private int replyno;
	private String memberid;
	private String name;
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	private Date regdate;
	private int ref;
	private int reflevel;
	private int refstep;
	private int communityno;
	public int getReplyno() {
		return replyno;
	}
	public void setReplyno(int replyno) {
		this.replyno = replyno;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getReflevel() {
		return reflevel;
	}
	public void setReflevel(int reflevel) {
		this.reflevel = reflevel;
	}
	public int getRefstep() {
		return refstep;
	}
	public void setRefstep(int refstep) {
		this.refstep = refstep;
	}
	public int getCommunityno() {
		return communityno;
	}
	public void setCommunityno(int communityno) {
		this.communityno = communityno;
	}
	@Override
	public String toString() {
		return "Reply [replyno=" + replyno + ", memberid=" + memberid + ", name=" + name + ", content=" + content
				+ ", regdate=" + regdate + ", ref=" + ref + ", reflevel=" + reflevel + ", refstep=" + refstep
				+ ", communityno=" + communityno + "]";
	}
	
}
