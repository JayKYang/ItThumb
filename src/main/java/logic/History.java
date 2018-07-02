package logic;

import java.util.Date;

public class History {
	private int historyno;
	private String memberid;
	private String content;
	private int skillful;
	private Date getdate;
	private Date enddate;
	private int kindno;
	
	public int getSkillful() {
		return skillful;
	}
	public void setSkillful(int skillful) {
		this.skillful = skillful;
	}
	public int getHistoryno() {
		return historyno;
	}
	public void setHistoryno(int historyno) {
		this.historyno = historyno;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getGetdate() {
		return getdate;
	}
	public void setGetdate(Date getdate) {
		this.getdate = getdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public int getKindno() {
		return kindno;
	}
	public void setKindno(int kindno) {
		this.kindno = kindno;
	}
	@Override
	public String toString() {
		return "History [historyno=" + historyno + ", memberid=" + memberid + ", content=" + content + ", skillful="
				+ skillful + ", getdate=" + getdate + ", enddate=" + enddate + ", kindno=" + kindno + "]";
	}
}
