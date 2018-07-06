package dao;

import java.util.HashMap;
import java.util.List;
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
	public List<Scrap> scrapHirelist(Integer hireno, String memberid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("hireno", hireno);
		map.put("memberid", memberid);
		return sqlSession.selectList(NS+"scrapHirelist",map);
	}
}
