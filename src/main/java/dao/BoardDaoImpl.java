package dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import logic.Hire;

@Repository
public class BoardDaoImpl implements Boarddao{

	@Override
	public int count(String searchRegion, String searchEdu, String searchCarr) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

}
