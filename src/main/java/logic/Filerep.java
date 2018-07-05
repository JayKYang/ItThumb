package logic;

public class Filerep {
	private int fileno;
	private int communityno;
	private String fname;
	public int getFileno() {
		return fileno;
	}
	public void setFileno(int fileno) {
		this.fileno = fileno;
	}
	public int getCommunityno() {
		return communityno;
	}
	public void setCommunityno(int communityno) {
		this.communityno = communityno;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	@Override
	public String toString() {
		return "Filerep [fileno=" + fileno + ", communityno=" + communityno + ", fname=" + fname + "]";
	}
	
}
