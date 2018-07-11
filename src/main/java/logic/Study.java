package logic;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Study implements Serializable{
	private int studyno;
	private String memberid;
	@NotEmpty(message="지역을 선택해주세요")
	private String region;
	@NotEmpty(message="제목을 입력해주세요")
	private String studyname;
	private Date regdate;
	private String nowmember;
	@NotEmpty(message="최대 인원을 선택해주세요")
	private String limitmember;
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	@NotEmpty(message="요일을 선택해주세요")
	private String weekday;
	@NotEmpty(message="시작시간을 선택해주세요")
	private String starttime;
	@NotEmpty(message="끝나는 시간을 선택해주세요")
	private String endtime;
	private String membername;
	private int state;
	public int getStudyno() {
		return studyno;
	}
	public void setStudyno(int studyno) {
		this.studyno = studyno;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getStudyname() {
		return studyname;
	}
	public void setStudyname(String studyname) {
		this.studyname = studyname;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getNowmember() {
		return nowmember;
	}
	public void setNowmember(String nowmember) {
		this.nowmember = nowmember;
	}
	public String getLimitmember() {
		return limitmember;
	}
	public void setLimitmember(String limitmember) {
		this.limitmember = limitmember;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWeekday() {
		return weekday;
	}
	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getMembername() {
		return membername;
	}
	public void setMembername(String membername) {
		this.membername = membername;
	}
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "Study [studyno=" + studyno + ", memberid=" + memberid + ", region=" + region + ", studyname="
				+ studyname + ", regdate=" + regdate + ", nowmember=" + nowmember + ", limitmember=" + limitmember
				+ ", content=" + content + ", weekday=" + weekday + ", starttime=" + starttime + ", endtime=" + endtime
				+ ", membername=" + membername + ", state=" + state + "]";
	}
	
	
}
