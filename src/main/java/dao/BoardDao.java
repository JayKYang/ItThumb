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

	int scrapMaxnum();

	void boardScrap(Scrap scrap);

	String selectScrap(Integer hireno, String memberid);

	void deleteScrap(Integer hireno, String memberid);

	int hireScrapcount(Integer hireno);

	void updateScrapNum(Integer hireno);

	void scrapNumMinus(Integer hireno);

	int popBoardcount();

	List<Hire> popHirelist(int popLimit);

	List<Hire> getHirelist();

	void updateHide(int hireno);











}
