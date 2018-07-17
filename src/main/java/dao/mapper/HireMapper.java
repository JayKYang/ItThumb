package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.CompanyInfo;
import logic.Companyhistory;
import logic.Hire;

public interface HireMapper {
	@Select("select ifnull(max(hireno),0) from hireboard")
	int maxNum();
	
	@Insert("insert into hireboard (hireno, qualification,hirestatus,salary,workday,memberid,hide,deadline,readcnt,subject,image,content,region,regionetc,company,regdate,career,careerdate,scrapnum,regiongu) "
					+"values (#{hireno},#{qualification},#{hirestatus},#{salary},#{workday},#{memberid},0,#{deadline},0,#{subject},#{imageUrl},#{content},#{region},#{regionetc},#{company},now(),#{career},#{careerdate},0,#{regiongu})")
	void insert(Hire hire);
	
	@Update("update hireboard set readcnt = readcnt +1 where hireno = #{value}")
	void readCntplus(Integer hireno);

	@Update("update hireboard set scrapnum = scrapnum+1 where hireno = #{value}")
	void hireUpdateScrapNum(int hireno);

	@Update("update hireboard set scrapnum = scrapnum-1 where hireno =#{value} ")
	void scrapNumMinus(Integer hireno);

	@Update("update hireboard set hide = hide+1 where hireno = #{value}")
	void updateHide(int hireno);

	@Delete("delete from hireboard where hireno = #{value}")
	void deleteHire(int hireno);

	@Update("update hireboard set subject=#{subject}, content=#{content},qualification=#{qualification},region=#{region},regionetc=#{regionetc},regiongu=#{regiongu},career=#{career},careerdate=#{careerdate},regdate=now(),deadline=#{deadline},image=#{imageUrl},salary=#{salary},workday=#{workday},hirestatus=#{hirestatus} where hireno = #{hireno} ")
	void hireUpdate(Hire hire);

	@Select("select * from hireboard where hireno=#{hireno}")
	Hire selectHire(int hireno);

	@Select("select ifnull(max(infono),0) from companyinfo")
	int CompanyInfoMaxNum();

	@Insert("insert into companyinfo (infono, memberid,ceoname,worker,sales,profit,capital,insurance,salsystem,benefit,mood,anniversary,health,office,clothes,meal,supplies,care,supportfund,education,companyevent,traffic,society) values(#{infono},#{memberid},#{ceoname},#{worker},#{sales},#{profit},#{capital},#{insurance},#{salsystem},#{benefit},#{mood},#{anniversary},#{health},#{office},#{clothes},#{meal},#{supplies},#{care},#{supportfund},#{education},#{companyevent},#{traffic},#{society})")
	void CompanyInfoInsert(CompanyInfo companyInfo);

	@Select("select ifnull(max(historyno),0) from companyhistory")
	int CompanyHistoryMaxNum();

	@Insert("insert into companyhistory (historyno,memberid,historydate,content) values(#{historyno},#{memberid},#{historydate},#{content})")
	void insertCompanyHistory(Companyhistory ch);
	
	@Update("update companyinfo set ceoname=#{ceoname}, worker=#{worker},sales=#{sales},profit=#{profit},capital=#{capital},insurance=#{insurance},salsystem=#{salsystem},benefit=#{benefit},mood=#{mood},anniversary=#{anniversary},health=#{health},office=#{office},clothes=#{clothes},meal=#{meal},supplies=#{supplies},care=#{care},supportfund=#{supportfund},education=#{education},companyevent=#{companyevent},traffic=#{traffic},society=#{society} where infono = #{infono}")
	void companyInfoUpdate(CompanyInfo companyinfo);
}
