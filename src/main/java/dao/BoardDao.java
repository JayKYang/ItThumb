package dao;

import java.util.List;

import logic.Hire;

public interface BoardDao {

	int count(String searchRegion, String searchEdu, String searchCarr);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit);

	int maxNum();

	void hireWrite(Hire hire);

}
