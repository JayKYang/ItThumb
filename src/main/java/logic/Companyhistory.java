package logic;

import java.io.Serializable;

public class Companyhistory implements Serializable {
	private int historyno;
	private String memberid;
	private String historydate;
	private String content;
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
	public String getHistorydate() {
		return historydate;
	}
	public void setHistorydate(String historydate) {
		this.historydate = historydate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Companyhistory [historyno=" + historyno + ", memberid=" + memberid + ", historydate=" + historydate
				+ ", content=" + content + "]";
	}
	
	
	
	
}
