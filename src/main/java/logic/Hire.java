package logic;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Future;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class Hire implements Serializable{
	private int hireno;
	@NotEmpty(message="지원자격을 입력해주세요.")
	private String qualification;
	@NotEmpty(message="고용상태를 입력해주세요.")
	private String hirestatus;
	@NotEmpty(message="연봉을 선택해주세요")
	private String salary;
	@NotEmpty(message="근무일을 입력해주세요")
	private String workday;
	private String memberid;
	private int hide;
	@Future(message="미래날짜를 적어주세요")
	private Date deadline;
	private int readcnt;
	@NotEmpty(message="제목을 입력해주세요")
	private String subject;
	private MultipartFile image;
	@NotEmpty(message="공고신청 내용을 입력해주세요")
	private String content;
	@NotEmpty(message="근무지역을 선택해주세요")
	private String region;
	private String imageUrl;
	private String company;
	@NotEmpty(message="나머지 근무지역을 입력해주세요.")
	private String regionetc;
	private Date regdate;
	@NotEmpty(message="경력을 선택해 주세요.")
	private String career;
	private String careerdate;
	@NotEmpty(message="구를 선택해주세요.")
	private String regiongu;
	private User user;
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
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
	public String getSalary() {
		return salary;
	}
	public void setSalary(String salary) {
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
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getRegionetc() {
		return regionetc;
	}
	public void setRegionetc(String regionetc) {
		this.regionetc = regionetc;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getCareerdate() {
		return careerdate;
	}
	public void setCareerdate(String careerdate) {
		this.careerdate = careerdate;
	}
	public String getRegiongu() {
		return regiongu;
	}
	public void setRegiongu(String regiongu) {
		this.regiongu = regiongu;
	}
	@Override
	public String toString() {
		return "Hire [hireno=" + hireno + ", qualification=" + qualification + ", hirestatus=" + hirestatus
				+ ", salary=" + salary + ", workday=" + workday + ", memberid=" + memberid + ", hide=" + hide
				+ ", deadline=" + deadline + ", readcnt=" + readcnt + ", subject=" + subject + ", image=" + image
				+ ", content=" + content + ", region=" + region + ", imageUrl=" + imageUrl + ", company=" + company
				+ ", regionetc=" + regionetc + ", regdate=" + regdate + ", career=" + career + ", careerdate="
				+ careerdate + ", regiongu=" + regiongu + ", user=" + user + "]";
	}

}
