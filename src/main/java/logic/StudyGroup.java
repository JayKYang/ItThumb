package logic;

public class StudyGroup {
	private int groupno;
	private int studyno;
	private String leadermember;
	private String regmember;
	private int state;
	public int getGroupno() {
		return groupno;
	}
	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}
	public int getStudyno() {
		return studyno;
	}
	public void setStudyno(int studyno) {
		this.studyno = studyno;
	}
	public String getLeadermember() {
		return leadermember;
	}
	public void setLeadermember(String leadermember) {
		this.leadermember = leadermember;
	}
	public String getRegmember() {
		return regmember;
	}
	public void setRegmember(String regmember) {
		this.regmember = regmember;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "StudyGroup [groupno=" + groupno + ", studyno=" + studyno + ", leadermember=" + leadermember
				+ ", regmember=" + regmember + ", state=" + state + "]";
	}
	
}
