package dao;

import java.util.List;

import logic.Hire;
import logic.Scrap;
import logic.User;

public interface BoardDao {

	int count(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate, Integer pageNum, int limit);

	int maxNum();

	void hireWrite(Hire hire);

	Hire getHire(Integer hireno);

	void readCntplus(Integer hireno);

	void updateScrapNum(Integer hireno);

	void scrapNumMinus(Integer hireno);

	int popBoardcount();

	List<Hire> popHirelist(int popLimit);

	List<Hire> getHirelist();

	void updateHide(int hireno);

	void deleteHire(int hireno);

	int hirecount(String searchType, String searchContent, Integer hide);

	List<Hire> getMypageHireList(String searchType, String searchContent, Integer pageNum, Integer hide, int limit);

}
