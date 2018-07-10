package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CommunityMapper;
import logic.Community;

@Repository
public class CommunityDaoImpl implements CommunityDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.CommunityMapper.";
	@Override
	public int communitycount(String searchType, String searchContent, Integer communitykind, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("communitykind", communitykind);
		param.put("memberid", memberid);
		Integer count = sqlSession.selectOne(NS+"count", param); 
		return count;
	}
	@Override
	public List<Community> communityList(String searchType, String searchContent, Integer pageNum, int limit, Integer communitykind, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		param.put("communitykind", communitykind);
		param.put("memberid", memberid);
		return sqlSession.selectList(NS+"list", param);
	}
	@Override
	public int comMaxNum() {
		return sqlSession.getMapper(CommunityMapper.class).comMaxNum();
	}
	@Override
	public void comCreate(Community community) {
		sqlSession.getMapper(CommunityMapper.class).comCreate(community);
		
	}
	@Override
	public Community comSelect(Integer communityno) {
		return sqlSession.getMapper(CommunityMapper.class).comSelet(communityno);
	}
	@Override
	public void comReadCount(Integer communityno) {
		sqlSession.getMapper(CommunityMapper.class).comReadCount(communityno);
		
	}
	@Override
	public void communityDelete(Integer communityno) {
		sqlSession.getMapper(CommunityMapper.class).communityDelete(communityno);
		
	}
	@Override
	public void comUpdate(Community community) {
		sqlSession.getMapper(CommunityMapper.class).comUpdate(community);
		
	}
}
