package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ScrapMapper;
import dao.mapper.StudyMapper;
import logic.Scrap;

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
}
