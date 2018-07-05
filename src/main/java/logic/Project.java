package logic;

import org.springframework.web.multipart.MultipartFile;

public class Project {
	private int projectno;
	private String memberid;
	private String subject;
	private MultipartFile imagefile;
	private String imagefileUrl;
	private String term;
	private String content;
	private String role;
	private String link;
	private String skills;
	public String getImagefileUrl() {
		return imagefileUrl;
	}
	public void setImagefileUrl(String imagefileUrl) {
		this.imagefileUrl = imagefileUrl;
	}
	public int getProjectno() {
		return projectno;
	}
	public void setProjectno(int projectno) {
		this.projectno = projectno;
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
	public MultipartFile getImagefile() {
		return imagefile;
	}
	public void setImagefile(MultipartFile imagefile) {
		this.imagefile = imagefile;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	@Override
	public String toString() {
		return "Project [projectno=" + projectno + ", memberid=" + memberid + ", subject=" + subject + ", imagefile="
				+ imagefile + ", imagefileUrl=" + imagefileUrl + ", term=" + term + ", content=" + content + ", role="
				+ role + ", link=" + link + ", skills=" + skills + "]";
	}
	
}
