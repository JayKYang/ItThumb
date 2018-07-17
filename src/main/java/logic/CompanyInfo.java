package logic;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class CompanyInfo implements Serializable{
	private int infono;
	private String memberid;
	@NotEmpty(message="경영자 이름을 입력해주세요")
	private String ceoname;
	@NotNull(message="사원수를 입력해주세요.")
	@Min(value=1, message="사원수는 1이상 입력해주세요.")
	private Integer worker;
	@Min(value=10000, message="매출액금액은 10000원 부터 입력하실수 있습니다.")
	@NotNull(message="매출액을 입력해주세요")
	private Integer sales;	//매출액
	@Min(value=10000, message="영업이익금액은 10000원 부터 입력하실수 있습니다.")
	@NotNull(message="영업이익을 입력해주세요")
	private Integer profit;	 //영업이익
	@Min(value=10000, message="자본금금액은 10000원 부터 입력하실수 있습니다.")
	@NotNull(message="자본금액을 입력해주세요")
	private Integer capital; //자본금
	private String insurance; //보험
	private String salsystem; //급여제도
	private String benefit;	  //수당제도
	private String mood;	  //회사분위기
	private String anniversary;	// 명절,기념일
	private String health;	//건강
	private String office;	//사무실환경
	private String clothes;	//의복관련
	private String meal;	//식사관련
	private String supplies;	//지급품
	private String care;		//육아,휴가
	private String supportfund;	//지원금
	private String education;	//교육
	private String companyevent;	//회사행사
	private String traffic;		//교통비
	private String society;		//동호회
	public int getInfono() {
		return infono;
	}
	public void setInfono(int infono) {
		this.infono = infono;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getCeoname() {
		return ceoname;
	}
	public void setCeoname(String ceoname) {
		this.ceoname = ceoname;
	}
	public Integer getWorker() {
		return worker;
	}
	public void setWorker(Integer worker) {
		this.worker = worker;
	}
	public Integer getSales() {
		return sales;
	}
	public void setSales(Integer sales) {
		this.sales = sales;
	}
	public Integer getProfit() {
		return profit;
	}
	public void setProfit(Integer profit) {
		this.profit = profit;
	}
	public Integer getCapital() {
		return capital;
	}
	public void setCapital(Integer capital) {
		this.capital = capital;
	}
	public String getInsurance() {
		return insurance;
	}
	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}
	public String getSalsystem() {
		return salsystem;
	}
	public void setSalsystem(String salsystem) {
		this.salsystem = salsystem;
	}
	public String getBenefit() {
		return benefit;
	}
	public void setBenefit(String benefit) {
		this.benefit = benefit;
	}
	public String getMood() {
		return mood;
	}
	public void setMood(String mood) {
		this.mood = mood;
	}
	public String getAnniversary() {
		return anniversary;
	}
	public void setAnniversary(String anniversary) {
		this.anniversary = anniversary;
	}
	public String getHealth() {
		return health;
	}
	public void setHealth(String health) {
		this.health = health;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	public String getClothes() {
		return clothes;
	}
	public void setClothes(String clothes) {
		this.clothes = clothes;
	}
	public String getMeal() {
		return meal;
	}
	public void setMeal(String meal) {
		this.meal = meal;
	}
	public String getSupplies() {
		return supplies;
	}
	public void setSupplies(String supplies) {
		this.supplies = supplies;
	}
	public String getCare() {
		return care;
	}
	public void setCare(String care) {
		this.care = care;
	}
	public String getSupportfund() {
		return supportfund;
	}
	public void setSupportfund(String supportfund) {
		this.supportfund = supportfund;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getCompanyevent() {
		return companyevent;
	}
	public void setCompanyevent(String companyevent) {
		this.companyevent = companyevent;
	}
	public String getTraffic() {
		return traffic;
	}
	public void setTraffic(String traffic) {
		this.traffic = traffic;
	}
	public String getSociety() {
		return society;
	}
	public void setSociety(String society) {
		this.society = society;
	}
	@Override
	public String toString() {
		return "CompanyInfo [infono=" + infono + ", memberid=" + memberid + ", ceoname=" + ceoname + ", worker="
				+ worker + ", sales=" + sales + ", profit=" + profit + ", capital=" + capital + ", insurance="
				+ insurance + ", salsystem=" + salsystem + ", benefit=" + benefit + ", mood=" + mood + ", anniversary="
				+ anniversary + ", health=" + health + ", office=" + office + ", clothes=" + clothes + ", meal=" + meal
				+ ", supplies=" + supplies + ", care=" + care + ", supportfund=" + supportfund + ", education="
				+ education + ", companyevent=" + companyevent + ", traffic=" + traffic + ", society=" + society + "]";
	}
	
		
}
