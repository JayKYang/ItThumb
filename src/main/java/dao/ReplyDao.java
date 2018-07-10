package dao;

import java.util.List;

import logic.Reply;

public interface ReplyDao {

	List<Reply> replyList(Integer communityno);

	int replyMaxNum();

	void replyCreate(Reply reply);

	Reply selectReply(Integer replyno);

	void insertReReply(Reply reply);

	void updateRe(Reply replyUpdate);

	void replyDelete(Integer replyno);

	void comReplyDelete(Integer communityno);

}
