package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ScrapMapper;
import dao.mapper.StudyMapper;
import logic.Hire;
import logic.Scrap;
import logic.User;

@Repository
public class ScrapDaoImpl implements ScrapDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.ScrapMapper.";
	@Override
	public Scrap scrapComfirm(int studyno, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("studyno", studyno);
		param.put("memberid", memberid);
		return sqlSession.selectOne(NS+"scrapComfirmSelect", param);
	}
	@Override
	public int scrapMaxNum() {
		return sqlSession.getMapper(ScrapMapper.class).scrapMaxNum();
	}
	@Override
	public void studyScrapInsert(Scrap insertScrap) {
		sqlSession.getMapper(ScrapMapper.class).studyScrapInsert(insertScrap);
	}
	@Override
	public void studyScrapDelete(int scrap) {
		sqlSession.getMapper(ScrapMapper.class).studyScrapDelete(scrap);
		
	}
	@Override
	public void scrapAllDelete(Integer studyno) {
		sqlSession.getMapper(ScrapMapper.class).scrapAllDelete(studyno);
	}
	@Override
	public Scrap hireScrapSelect(int hireno, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("hireno", hireno);
		param.put("memberid", memberid);
		
		return sqlSession.selectOne(NS+"hireScrapSelect", param);
	}
	@Override
	public void hireInsertScrap(Scrap insertScrap) {
		
		sqlSession.getMapper(ScrapMapper.class).hireInsertScrap(insertScrap);
	}
	@Override
	public void hireDeleteScrap(int scrap) {
		sqlSession.getMapper(ScrapMapper.class).hireDeleteScrap(scrap);
		
	}
	@Override
	public List<Scrap> scrapHirelist(String memberid,Integer pageNum,int limit) {
		int startrow = (pageNum -1) * limit;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("memberid", memberid);
		map.put("startrow", startrow);
		map.put("limit", limit);
		return sqlSession.selectList(NS+"scrapHirelist",map);
	}
	@Override
	public int scrapHireCount(String memberid,String searchType,String searchContent) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("memberid", memberid);
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		int ret = sqlSession.selectOne(NS+"scrapHireCount",map);
		return ret;
	}
		
	@Override	
	public Scrap portfolioScrapConfirm(String loginid, String scrapid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("loginid", loginid);
		param.put("scrapid", scrapid);
		
		return sqlSession.selectOne(NS+"portfolioScrapConfirm", param);
	}
	@Override
	public List<Hire> getScrapList(String memberid, String searchType, String searchContent, Integer pageNum,
			int limit) {
		Map<String, Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("memberid", memberid);
		map.put("limit", limit);
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		map.put("startrow", startrow);
		
		return sqlSession.selectList(NS+"getScrapList",map);
	}
	
	@Override
	public int getScrapmembercount(String searchType, String searchContent, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("memberid", memberid);
		
		return sqlSession.selectOne(NS+"getScrapmembercount", param);
	}
	@Override
	public List<User> getScrapmemberlist(String searchType, String searchContent, Integer pageNum, int limit,
			String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		param.put("memberid", memberid);
		return sqlSession.selectList(NS+"getScrapmemberlist", param);
	}
}
