package dao;

import java.util.List;

import logic.CompanyInfo;
import logic.Companyhistory;
import logic.Hire;
import logic.Scrap;
import logic.User;

public interface BoardDao {

	int count(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate, Integer pageNum, int limit);

	int maxNum();

	void hireWrite(Hire hire);

	Hire getHire(Integer hireno,String searchType, String searchContent);

	void readCntplus(Integer hireno);

	void scrapNumMinus(Integer hireno);

	int popBoardcount();

	List<Hire> popHirelist(int popLimit);

	List<Hire> getHirelist();

	void updateHide(int hireno);

	void deleteHire(int hireno);

	void hireUpdateScrapNum(int hireno);

	int suphirelistcount(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate);

	int hirecount(String searchType, String searchContent, Integer hide);

	List<Hire> getMypageHireList(String searchType, String searchContent, Integer pageNum, Integer hide, int limit);

	List<Hire> getMyHireList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int getMyhirecount(String memberid, String searchType, String searchContent);

	void hireUpdate(Hire hire);

	int hireboardcount(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate);

	List<Hire> calhirelist(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate);

	Hire selectHire(int hireno);

	void companyDetailwrite(CompanyInfo companyinfo);

	int companyInfoMaxNum();

	int companyHistoryMaxNum();

	void insertCompanyHistory(Companyhistory ch);

	CompanyInfo getCompanyInfo(String memberid);

	List<Companyhistory> getCompanyHistorylist(String memberid);

	void companyInfoUpdate(CompanyInfo companyinfo);

	void comInfoDelete(String memberid);

	int getCompanyHistorylistCount(String memberid);

	int getCompanyHistorylistMaxNum(String memberid);

	int companyInfocount(String memberid);

	void deleteCompanyhistory(int historyno);


}
