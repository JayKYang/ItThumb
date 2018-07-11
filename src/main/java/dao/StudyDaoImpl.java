package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.MessageMapper;
import dao.mapper.StudyMapper;
import logic.Study;
import logic.User;
@Repository
public class StudyDaoImpl implements StudyDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.StudyMapper.";
	@Override
	public int studyMax(String searchType, String searchContent) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		Integer count = sqlSession.selectOne(NS+"count", param); 
		return count;
	}
	@Override
	public List<Study> studylist(String searchType, String searchContent, Integer pageNum, int limit) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		return sqlSession.selectList(NS+"list", param);
	}
	@Override
	public int studyMaxNum() {
		return sqlSession.getMapper(StudyMapper.class).studyMaxNum();
	}
	@Override
	public void StudyWrite(Study study) {
		sqlSession.getMapper(StudyMapper.class).studyWrite(study);
		
	}
	@Override
	public Study studySelect(Integer studyno) {
		return sqlSession.getMapper(StudyMapper.class).studySelect(studyno);
	}
	@Override
	public void studyDelete(Integer studyno) {
		sqlSession.getMapper(StudyMapper.class).studyDelete(studyno);
	}
	@Override
	public void studyUpdate(Study study) {
		sqlSession.getMapper(StudyMapper.class).studyUpdate(study);	
	}
	@Override
	public int myApplyStudyCount(String searchType, String searchContent, String memberid) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("memberid", memberid);
		Integer count = sqlSession.selectOne(NS+"myApplyStudyCount", param); 
		return count;
	}
	@Override
	public List<Study> myApplyStudyList(String searchType, String searchContent, Integer pageNum, int limit,
			String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		param.put("memberid", memberid);
		return sqlSession.selectList(NS+"myApplyStudyList", param);
	}
	@Override
	public int myScrapStudyCount(String searchType, String searchContent, String memberid) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("memberid", memberid);
		Integer count = sqlSession.selectOne(NS+"myScrapStudyCount", param); 
		return count;
	}
	@Override
	public List<Study> myScrapStudyList(String searchType, String searchContent, Integer pageNum, int limit,
			String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		param.put("memberid", memberid);
		return sqlSession.selectList(NS+"myScrapStudyList", param);
	}
	@Override
	public int myStudyCount(String searchType, String searchContent, String memberid) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("memberid", memberid);
		Integer count = sqlSession.selectOne(NS+"myStudyCount", param); 
		return count;
	}
	@Override
	public List<Study> myStudyList(String searchType, String searchContent, Integer pageNum, int limit,
			String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		param.put("memberid", memberid);
		return sqlSession.selectList(NS+"myStudyList", param);
	}
	@Override
	public List<User> myStudyInfoList(Integer studyno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("studyno", studyno);
		return sqlSession.selectList(NS+"myStudyInfoList", param);
	}


}
