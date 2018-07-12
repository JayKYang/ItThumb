package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.MessageMapper;
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
	public List<History> getHistory(String memberid,String searchType, String searchContent) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memberid", memberid);
		if(searchType != null && (searchType.equals("1") || searchType.equals("2"))) {
			param.put("searchType", searchType);
			param.put("searchContent", searchContent);
		}else {
			param.put("searchType", null);
			param.put("searchContent", null);
		}
		return sqlSession.selectList(NS+"history", param);
//		return (List<History>) sqlSession.getMapper(PortfolioMapper.class).getHistory(memberid);
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
	@Override
	public int portfolioMax(String searchType, String searchContent , Integer createpf) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("createpf", createpf);
		Integer count = sqlSession.selectOne(NS+"count", param); 
		return count;
	}
	@Override
	public List<User> portfoliolist(String searchType, String searchContent,Integer membergrade, Integer pageNum, int limit) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = 0;
		if(pageNum != null) {
			startrow = (pageNum - 1) * limit;
		}
		if(searchType == null/* || searchType.equals("1") || searchType.equals("2")*/) {
			param.put("searchType", null);
			param.put("searchContent", null);
		}else {
//			System.out.println(searchType + "," + searchContent + "@@@"  );
			param.put("searchType", searchType);
			param.put("searchContent", searchContent);
		}
		if(membergrade==null) {
			param.put("membergrade", null);
		}else {
			param.put("membergrade", membergrade);
		}
		param.put("startrow", startrow);
		param.put("limit", limit);
		return sqlSession.selectList(NS+"list", param);
	}
}
