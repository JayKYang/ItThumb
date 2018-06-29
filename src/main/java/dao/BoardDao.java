package dao;

import java.util.List;

import logic.Hire;
import logic.Scrap;

public interface BoardDao {

	int count(String searchRegion, String searchEdu, String searchCarr);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit);

	int maxNum();

	void hireWrite(Hire hire);

	Hire getHire(Integer hireno);

	void readCntplus(Integer hireno);

	int scrapMaxnum();

	void boardScrap(Scrap scrap);

}
