package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.FilerepMapper;
import logic.Filerep;

@Repository
public class FilerepDaoImpl implements FilerepDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.FilerepMapper.";
	@Override
	public int fileMaxNum() {
		return sqlSession.getMapper(FilerepMapper.class).fileMaxNum();
	}
	@Override
	public void fileCreate(Filerep filerep) {
		sqlSession.getMapper(FilerepMapper.class).fileCreate(filerep);
	}
	@Override
	public List<Filerep> fileList(Integer communityno) {
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("communityno", communityno);
		return sqlSession.selectList(NS+"fileList", param);
	}
	@Override
	public void comFileDelete(Integer communityno) {
		sqlSession.getMapper(FilerepMapper.class).comFileDelete(communityno);
		
	}
}
