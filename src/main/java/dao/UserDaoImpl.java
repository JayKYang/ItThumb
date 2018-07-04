package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.History;
import logic.User;

@Repository
public class UserDaoImpl implements UserDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.UserMapper.";
	@Override
	public void createNormalUser(User user) {
		sqlSession.getMapper(UserMapper.class).normalInsert(user);
	}
	@Override
	public void createCompanyUser(User user) {
		sqlSession.getMapper(UserMapper.class).companyInsert(user);
	}
	@Override
	public User selectUser(String memberid) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberid", memberid);
		return sqlSession.selectOne(NS+"getUser", map);
	}
	@Override
	public void updateUser(User user) {
		sqlSession.getMapper(UserMapper.class).userUpdate(user);
	}
	@Override
	public void deleteUser(String id) {
		sqlSession.getMapper(UserMapper.class).userDelete(id);
	}
	@Override
	public void confirmCode(User user) {
		sqlSession.getMapper(UserMapper.class).confirmCode(user);
	}
	@Override
	public List<History> getHistory(String memberid) {
		return (List<History>) sqlSession.getMapper(UserMapper.class).getHistory(memberid);
	}
	@Override
	public void insertHistory(History history) {
		sqlSession.getMapper(UserMapper.class).insertHistory(history);
	}
	@Override
	public int maxHistoryno() {
		return 	sqlSession.getMapper(UserMapper.class).maxHistoryno();
	}
	@Override
	public void deleteHistory(int historyno) {
		sqlSession.getMapper(UserMapper.class).deleteHistory(historyno);
	}
	@Override
	public void updateHistory(History history) {
		sqlSession.getMapper(UserMapper.class).updateHistory(history);
	}
}
