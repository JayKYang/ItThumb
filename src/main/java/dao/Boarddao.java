package dao;

import java.util.List;

import logic.Hire;

public interface Boarddao {

	int count(String searchRegion, String searchEdu, String searchCarr);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit);

}
