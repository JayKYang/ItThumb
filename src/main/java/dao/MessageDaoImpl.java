package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.MessageMapper;
import logic.Message;

@Repository
public class MessageDaoImpl implements MessageDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.MessageMapper.";
	@Override
	public int messagecount(String searchType, String searchContent, Integer sort, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("sort", sort);
		param.put("memberid", memberid);
		Integer count = sqlSession.selectOne(NS+"count", param); 
		return count;
	}
	@Override
	public List<Message> messagelist(String searchType, String searchContent, Integer pageNum, int limit, Integer sort, String memberid) {
		Map<String, Object> param = new HashMap<String, Object>();
		int startrow = (pageNum - 1) * limit;
		param.put("searchType", searchType);
		param.put("searchContent", searchContent);
		param.put("startrow", startrow);
		param.put("limit", limit);
		param.put("sort", sort);
		param.put("memberid", memberid);
		return sqlSession.selectList(NS+"list", param);
	}
	@Override
	public Message messageselect(Integer messageno) {
		return sqlSession.getMapper(MessageMapper.class).messageSelect(messageno);
	}
	@Override
	public void messageConfirm(Integer messageno) {
		sqlSession.getMapper(MessageMapper.class).messageComfirm(messageno);
		
	}
	@Override
	public void messageDelete(String messageno, Integer sort) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("messageno", messageno);
		param.put("sort", sort);
		sqlSession.delete(NS+"delete", param);
	}
	@Override
	public void messageDBdelete(String messageno) {
		sqlSession.getMapper(MessageMapper.class).messageDBdelete(messageno);
		
	}
	@Override
	public void messageWrite(Message message) {
		sqlSession.getMapper(MessageMapper.class).messageWrite(message);
		
	}
	@Override
	public int messageMax() {
		return sqlSession.getMapper(MessageMapper.class).messageMax();
	}
}
