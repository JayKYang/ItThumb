package logic;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class Community implements Serializable{
	private int communityno;
	private String memberid;
	@NotEmpty(message="제목을 입력해주세요")
	private String subject;
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	private Date regdate;
	private int communitykind;
	private int readcnt;
	private List<MultipartFile> fileList;
	private String files;
	public int getCommunityno() {
		return communityno;
	}
	public void setCommunityno(int communityno) {
		this.communityno = communityno;
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
	public int getCommunitykind() {
		return communitykind;
	}
	public void setCommunitykind(int communitykind) {
		this.communitykind = communitykind;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public List<MultipartFile> getFileList() {
		return fileList;
	}
	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	@Override
	public String toString() {
		return "Community [communityno=" + communityno + ", memberid=" + memberid + ", subject=" + subject
				+ ", content=" + content + ", regdate=" + regdate + ", communitykind=" + communitykind + ", readcnt="
				+ readcnt + ", fileList=" + fileList + ", files=" + files + "]";
	}
}
