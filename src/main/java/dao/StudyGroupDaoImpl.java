package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ScrapMapper;
import dao.mapper.StudyGroupMapper;
import logic.StudyGroup;

@Repository
public class StudyGroupDaoImpl implements StudyGroupDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.StudyGroupMapper.";
	@Override
	public StudyGroup studyGroupComfirm(int studyno, String regmember) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("studyno", studyno);
		param.put("regmember", regmember);
		return sqlSession.selectOne(NS+"studyGroupComfirmSelect", param);
	}
	@Override
	public int studyGroupMaxNum() {
		return sqlSession.getMapper(StudyGroupMapper.class).studyGroupMaxNum();
	}
	@Override
	public void studyGroupInsert(StudyGroup studyGroupInsert) {
		sqlSession.getMapper(StudyGroupMapper.class).studyGroupInsert(studyGroupInsert);
		
	}
	@Override
	public void studyGroupDelete(int groupno) {
		sqlSession.getMapper(StudyGroupMapper.class).studyGroupDelete(groupno);
		
	}
	@Override
	public List<StudyGroup> studygrouplist(String memberid) {
		return sqlSession.getMapper(StudyGroupMapper.class).studygrouplist(memberid);
	}
}
