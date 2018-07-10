package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReplyMapper;
import logic.Reply;

@Repository
public class ReplyDaoImpl implements ReplyDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.ReplyMapper.";
	@Override
	public List<Reply> replyList(Integer communityno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("communityno", communityno);
		return sqlSession.selectList(NS+"replyList", param);
	}
	@Override
	public int replyMaxNum() {
		return sqlSession.getMapper(ReplyMapper.class).replyMaxNum();
	}
	@Override
	public void replyCreate(Reply reply) {
		sqlSession.getMapper(ReplyMapper.class).replyCreate(reply);
		
	}
	@Override
	public Reply selectReply(Integer replyno) {
		return sqlSession.getMapper(ReplyMapper.class).selectReply(replyno);
	}
	@Override
	public void insertReReply(Reply reply) {
		sqlSession.getMapper(ReplyMapper.class).updateReReply(reply);
		int reflevel = reply.getReflevel()+1;
		int refstep = reply.getRefstep()+1;
		int replyno = this.replyMaxNum()+1;
		reply.setRef(reply.getRef());
		reply.setReflevel(reflevel);
		reply.setRefstep(refstep);
		reply.setReplyno(replyno);
		this.replyCreate(reply);
	}
	@Override
	public void updateRe(Reply replyUpdate) {
		sqlSession.getMapper(ReplyMapper.class).updateRe(replyUpdate);
		
	}
	@Override
	public void replyDelete(Integer replyno) {
		sqlSession.getMapper(ReplyMapper.class).replyDelete(replyno);
		
	}
	@Override
	public void comReplyDelete(Integer communityno) {
		sqlSession.getMapper(ReplyMapper.class).comReplyDelete(communityno);
		
	}
}
