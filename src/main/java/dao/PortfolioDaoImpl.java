package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.PortfolioMapper;
import logic.History;
import logic.Project;
import logic.User;

@Repository
public class PortfolioDaoImpl implements PortFolioDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.PortfolioMapper.";
	
	@Override
	public List<History> getHistory(String memberid) {
		return (List<History>) sqlSession.getMapper(PortfolioMapper.class).getHistory(memberid);
	}
	@Override
	public void insertHistory(History history) {
		sqlSession.getMapper(PortfolioMapper.class).insertHistory(history);
	}
	@Override
	public int maxHistoryno() {
		return 	sqlSession.getMapper(PortfolioMapper.class).maxHistoryno();
	}
	@Override
	public void deleteHistory(int historyno) {
		sqlSession.getMapper(PortfolioMapper.class).deleteHistory(historyno);
	}
	@Override
	public void updateHistory(History history) {
		sqlSession.getMapper(PortfolioMapper.class).updateHistory(history);
	}
	@Override
	public void updateUserAboutMe(User user) {
		sqlSession.getMapper(PortfolioMapper.class).updateUserAboutMe(user);
	}
	
	@Override
	public void deleteportfolio(String id) {
		sqlSession.getMapper(PortfolioMapper.class).deleteportfolio(id);
	}
	@Override
	public List<Project> getProject(String id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memberid",id);
		return sqlSession.selectList(NS+"select", param);
	}
	@Override
	public Project getProjectone(String id, String projectno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memberid",id);
		param.put("projectno", projectno);
		return sqlSession.selectOne(NS+"select", param);
	}
	@Override
	public void deleteProject(String projectno) {
		sqlSession.getMapper(PortfolioMapper.class).deleteProject(projectno);
	}
	@Override
	public void insertproject(Project project) {
		sqlSession.getMapper(PortfolioMapper.class).insertproject(project);
	}
	@Override
	public int maxProjectno() {
		return sqlSession.getMapper(PortfolioMapper.class).maxProjectno();
	}
	@Override
	public void updateproject(Project project) {
		sqlSession.getMapper(PortfolioMapper.class).updateproject(project);
	}
}
