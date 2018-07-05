package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.HireMapper;
import dao.mapper.ScrapMapper;
import logic.Hire;
import logic.Scrap;
import logic.User;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	SqlSessionTemplate SqlSession;
	private final String NS = "dao.mapper.HireMapper.";
	
	@Override
	public int count(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate) {
		Map<String, String> map = new HashMap<String,String>();
		map.put("searchRegion", searchRegion);
		map.put("searchEdu", searchEdu);
		map.put("searchCarr", searchCarr);
		map.put("searchCareer", searchCareer);
		map.put("searchCareerDate", searchCareerDate);
		Integer ret = SqlSession.selectOne(NS+"count",map);
		
		return ret;
	}

	@Override
	public List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate, Integer pageNum, int limit) {
		Map<String, Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("searchRegion", searchRegion);
		map.put("searchEdu", searchEdu);
		map.put("searchCarr", searchCarr);
		map.put("searchCareer", searchCareer);
		map.put("searchCareerDate", searchCareerDate);
		map.put("startrow", startrow);
		map.put("limit", limit);
		
		return SqlSession.selectList(NS+"hirelist", map);
	}

	@Override
	public int maxNum() {
		
		int maxnum = SqlSession.getMapper(HireMapper.class).maxNum();
		
		return maxnum;
	}

	@Override
	public void hireWrite(Hire hire) {
		SqlSession.getMapper(HireMapper.class).insert(hire);
	}

	@Override
	public Hire getHire(Integer hireno) {
	Map<String,Integer> map = new HashMap<String,Integer>();
	map.put("hireno", hireno);
	map.put("startrow", 0);
	map.put("limit", 1);	
		return SqlSession.selectOne(NS+"hirelist", map);
	}

	@Override
	public void readCntplus(Integer hireno) {
		Map<String,Integer> param = new HashMap<String,Integer>();
		param.put("hireno", hireno);
		SqlSession.getMapper(HireMapper.class).readCntplus(hireno);
	}

	@Override
	public int scrapMaxnum() {
		
		int maxnum = SqlSession.getMapper(ScrapMapper.class).scrapMaxnum();
		
		return maxnum;
	}

	@Override
	public void boardScrap(Scrap scrap) {
		SqlSession.getMapper(ScrapMapper.class).insert(scrap);
	}

	@Override
	public String selectScrap(Integer hireno, String memberid) {
		Map<Object, Object> map = new HashMap<Object,Object>();
		map.put("hireno", hireno);
		map.put("memberid", memberid);
		
		String ret = SqlSession.getMapper(ScrapMapper.class).selectScrap(map);
		
		return ret;
	}

	@Override
	public void deleteScrap(Integer hireno, String memberid) {
		Map<Object, Object> map = new HashMap<Object,Object>();
		map.put("hireno", hireno);
		map.put("memberid", memberid);
		SqlSession.getMapper(ScrapMapper.class).deleteScrap(map);
	}

	@Override
	public int hireScrapcount(Integer hireno) {
		int hireScrapcount = SqlSession.getMapper(ScrapMapper.class).hireScrapcount(hireno);
		
		return hireScrapcount;
		
	}

	@Override
	public void updateScrapNum(Integer hireno) {
	
		SqlSession.getMapper(HireMapper.class).updateScrapNum(hireno);
		
	}

	@Override
	public void scrapNumMinus(Integer hireno) {
		SqlSession.getMapper(HireMapper.class).scrapNumMinus(hireno);
		
	}

	@Override
	public int popBoardcount() {
		Integer popBoardcount = SqlSession.selectOne(NS+"popBoardcount");
		return popBoardcount;
	}

	@Override
	public List<Hire> popHirelist(int popLimit) {
	
		Map<String, Integer> map = new HashMap<String,Integer>();
		map.put("popLimit", popLimit);
		return SqlSession.selectList(NS+"popHirelist",map);
	}

	@Override
	public List<Hire> getHirelist() {
		Map<String,Object> map = new HashMap<String,Object>();
		return SqlSession.selectList(NS+"hirelist",map);
	}

	@Override
	public void updateHide(int hireno) {
	
		SqlSession.getMapper(HireMapper.class).updateHide(hireno);
	}
















}
