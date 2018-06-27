package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Hire {
	private int hireno;
	@NotEmpty(message="지원조건을 입력해주세요.")
	private String qualification;
	@NotEmpty(message="고용상태를 입력해주세요.")
	private String hirestatus;
	private int salary;
	@NotEmpty(message="근무일을 입력해주세요")
	private String workday;
	private String memberid;
	private int hide;
	@NotEmpty(message="공고기간을 입력해주세요")
	private Date deadline;
	private int readcnt;
	@NotEmpty(message="제목을 입력해주세요")
	private String subject;
	private String image;
	@NotEmpty(message="공고신청 내용을 입력해주세요")
	private String content;
	
	
	//getter,setter, toString
	public int getHireno() {
		return hireno;
	}
	public void setHireno(int hireno) {
		this.hireno = hireno;
	}
	public String getQualification() {
		return qualification;
	}
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	public String getHirestatus() {
		return hirestatus;
	}
	public void setHirestatus(String hirestatus) {
		this.hirestatus = hirestatus;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public String getWorkday() {
		return workday;
	}
	public void setWorkday(String workday) {
		this.workday = workday;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public int getHide() {
		return hide;
	}
	public void setHide(int hide) {
		this.hide = hide;
	}
	public Date getDeadline() {
		return deadline;
	}
	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Hire [hireno=" + hireno + ", qualification=" + qualification + ", hirestatus=" + hirestatus
				+ ", salary=" + salary + ", workday=" + workday + ", memberid=" + memberid + ", hide=" + hide
				+ ", deadline=" + deadline + ", readcnt=" + readcnt + ", subject=" + subject + ", image=" + image
				+ ", content=" + content + "]";
	}
	
	
}
