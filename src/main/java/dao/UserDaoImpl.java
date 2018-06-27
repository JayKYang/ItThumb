package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
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
}
