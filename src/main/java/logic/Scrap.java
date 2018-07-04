package logic;

public class Scrap {
	private int scrap;
	private String memberid;
	private int hireno;
	private int studyno;
	private String scrapmember;
	public int getScrap() {
		return scrap;
	}
	public void setScrap(int scrap) {
		this.scrap = scrap;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public int getHireno() {
		return hireno;
	}
	public void setHireno(int hireno) {
		this.hireno = hireno;
	}
	public int getStudyno() {
		return studyno;
	}
	public void setStudyno(int studyno) {
		this.studyno = studyno;
	}
	public String getScrapmember() {
		return scrapmember;
	}
	public void setScrapmember(String scrapmember) {
		this.scrapmember = scrapmember;
	}
	@Override
	public String toString() {
		return "Scrap [scrap=" + scrap + ", memberid=" + memberid + ", hireno=" + hireno + ", studyno=" + studyno
				+ ", scrapmember=" + scrapmember + "]";
	}
	
	
}
