package dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.HireMapper;
import dao.mapper.ScrapMapper;
import logic.CompanyInfo;
import logic.Companyhistory;
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
	public Hire getHire(Integer hireno,String searchType, String searchContent) {
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("hireno", hireno);
	map.put("startrow", 0);
	map.put("limit", 1);
	map.put("searchType", searchType);
	map.put("searchContent", searchContent);
	
		return SqlSession.selectOne(NS+"hirelist", map);
	}

	@Override
	public void readCntplus(Integer hireno) {
		Map<String,Integer> param = new HashMap<String,Integer>();
		param.put("hireno", hireno);
		SqlSession.getMapper(HireMapper.class).readCntplus(hireno);
	}

	@Override
	public void hireUpdateScrapNum(int hireno) {
	
		SqlSession.getMapper(HireMapper.class).hireUpdateScrapNum(hireno);
		
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

	@Override
	public int hirecount(String searchType, String searchContent, Integer hide) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		map.put("hide", hide);
		return SqlSession.selectOne(NS+"hirecount",map);
	}
	@Override
	public void deleteHire(int hireno) {
		SqlSession.getMapper(HireMapper.class).deleteHire(hireno);
		
	}

	@Override
	public int suphirelistcount(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate) {
		Map<String, String> map = new HashMap<String,String>();
		map.put("searchRegion", searchRegion);
		map.put("searchEdu", searchEdu);
		map.put("searchCarr", searchCarr);
		map.put("searchCareer", searchCareer);
		map.put("searchCareerDate", searchCareerDate);
		
		int ret = SqlSession.selectOne(NS+"suphirelistcount", map);
		
		return ret;
	}

	@Override
	public List<Hire> getMypageHireList(String searchType, String searchContent, Integer pageNum, Integer hide,
			int limit) {
		Map<String, Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		map.put("hide", hide);
		map.put("startrow", startrow);
		map.put("limit", limit);
		return SqlSession.selectList(NS+"getMypageHireList",map);
	}

	@Override
	public List<Hire> getMyHireList(String searchType, String searchContent, Integer pageNum, int limit,
			String memberid) {
			int startrow=(pageNum-1)*limit;
		Map<String, Object> map = new HashMap<String,Object>();
			map.put("searchType", searchType);
			map.put("searchContent", searchContent);
			map.put("memberid", memberid);
			map.put("limit", limit);
			map.put("startrow", startrow);
		
			return SqlSession.selectList(NS+"getMyHireList",map);
	}
	
	@Override
	public int getMyhirecount(String memberid, String searchType, String searchContent, Integer hide) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("hide", hide);
		map.put("memberid", memberid);
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		
		int ret = SqlSession.selectOne(NS+"getMyhirecount",map);
		
		return ret;
	}

	@Override
	public void hireUpdate(Hire hire) {
		
		
		SqlSession.getMapper(HireMapper.class).hireUpdate(hire);
		
	}

	@Override
	public int hireboardcount(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchRegion", searchRegion);
		map.put("searchEdu", searchEdu);
		map.put("searchCarr", searchCarr);
		map.put("searchCareer", searchCareer);
		map.put("searchCareerDate", searchCareerDate);
		
		int ret = SqlSession.selectOne(NS+"hireboardcount",map);
		
		return ret;
	}

	@Override
	public List<Hire> calhirelist(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("searchRegion", searchRegion);
		map.put("searchEdu", searchEdu);
		map.put("searchCarr", searchCarr);
		map.put("searchCareer", searchCareer);
		map.put("searchCareerDate", searchCareerDate);
		return SqlSession.selectList(NS+"calhirelist", map);
	}

	@Override
	public Hire selectHire(int hireno) {
		return SqlSession.getMapper(HireMapper.class).selectHire(hireno);
	}

	@Override
	public int companyInfoMaxNum() {
		
		int maxnum = SqlSession.getMapper(HireMapper.class).CompanyInfoMaxNum();
		
		return maxnum;
	}
	
	
	@Override
	public void companyDetailwrite(CompanyInfo companyinfo) {
		SqlSession.getMapper(HireMapper.class).CompanyInfoInsert(companyinfo);
	}

	@Override
	public int companyHistoryMaxNum() {
		
		int maxNum = SqlSession.getMapper(HireMapper.class).CompanyHistoryMaxNum();
		
		return maxNum;
	}

	@Override
	public void insertCompanyHistory(Companyhistory ch) {
	
		

		
		SqlSession.getMapper(HireMapper.class).insertCompanyHistory(ch);
		
	}

	@Override
	public CompanyInfo getCompanyInfo(String memberid) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("memberid", memberid);
		return SqlSession.selectOne(NS+"getCompanyInfo", map);
	}

	@Override
	public List<Companyhistory> getCompanyHistorylist(String memberid) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("memberid", memberid);
		
		return SqlSession.selectList(NS+"getCompanyHistorylist", map);
	}

	@Override
	public void companyInfoUpdate(CompanyInfo companyinfo) {
		
		SqlSession.getMapper(HireMapper.class).companyInfoUpdate(companyinfo);
		
	}

	@Override
	public void comInfoDelete(String memberid) {
		SqlSession.getMapper(HireMapper.class).comInfoDelete(memberid);
	}

	@Override
	public int getCompanyHistorylistCount(String memberid) {
		
		int ret = SqlSession.getMapper(HireMapper.class).getCompanyHistorylistCount(memberid);
		
		return ret;
	}

	@Override
	public int getCompanyHistorylistMaxNum(String memberid) {
		int maxNum = SqlSession.getMapper(HireMapper.class).getCompanyHistorylistMaxNum(memberid);
		return maxNum;
	}

	@Override
	public int companyInfocount(String memberid) {
		
		int infomax = SqlSession.getMapper(HireMapper.class).companyInfocount(memberid);
		
		return infomax;
	}

	@Override
	public void deleteCompanyhistory(int historyno) {
	
		SqlSession.getMapper(HireMapper.class).deleteCompanyhistory(historyno);
	}


}
