package logic;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.URL;
import org.springframework.web.multipart.MultipartFile;

public class User implements Serializable{
	@NotEmpty(message="아이디를 입력해주세요")
	@Email(message="메일 형식이 아닙니다.")
	private String memberid;
	@Size(min=4, message="비밀번호는 4글자이상 입니다.")
	private String password;
	@Size(min=2, message="이름은 2글자이상 입니다.")
	private String name;
	private Date regdate;
	@Size(min=8, message="핸드폰 번호를 확인해주세요")
	private String tel;
	private int membergrade;
	private int recognizecode;
	private MultipartFile image;
	private String imageUrl;
	@Past(message="과거 날짜만 가능합니다.")
	private Date birth;
	private String industy;
	@URL(message="URL형식이 아닙니다.")
	private String site;
	private String slogun;
	private String introduce;
	private Date modifydate;
	private String address;
	private String companyserial;
	private int locking;
	private int createpf;
	private List<History> historyList;
	private int state;
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public List<History> getHistoryList() {
		return historyList;
	}
	public void setHistoryList(List<History> historyList) {
		this.historyList = historyList;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getMembergrade() {
		return membergrade;
	}
	public void setMembergrade(int membergrade) {
		this.membergrade = membergrade;
	}
	public int getRecognizecode() {
		return recognizecode;
	}
	public void setRecognizecode(int recognizecode) {
		this.recognizecode = recognizecode;
	}
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getIndusty() {
		return industy;
	}
	public void setIndusty(String industy) {
		this.industy = industy;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public String getSlogun() {
		return slogun;
	}
	public void setSlogun(String slogun) {
		this.slogun = slogun;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public Date getModifydate() {
		return modifydate;
	}
	public void setModifydate(Date modifydate) {
		this.modifydate = modifydate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCompanyserial() {
		return companyserial;
	}
	public void setCompanyserial(String companyserial) {
		this.companyserial = companyserial;
	}
	public int getLocking() {
		return locking;
	}
	public void setLocking(int locking) {
		this.locking = locking;
	}
	public int getCreatepf() {
		return createpf;
	}
	public void setCreatepf(int createpf) {
		this.createpf = createpf;
	}
	@Override
	public String toString() {
		return "User [memberid=" + memberid + ", password=" + password + ", name=" + name + ", regdate=" + regdate
				+ ", tel=" + tel + ", membergrade=" + membergrade + ", recognizecode=" + recognizecode + ", image="
				+ image + ", imageUrl=" + imageUrl + ", birth=" + birth + ", industy=" + industy + ", site=" + site
				+ ", slogun=" + slogun + ", introduce=" + introduce + ", modifydate=" + modifydate + ", address="
				+ address + ", companyserial=" + companyserial + ", locking=" + locking + ", createpf=" + createpf
				+ ", historyList=" + historyList + ", state=" + state + "]";
	}
	
}
