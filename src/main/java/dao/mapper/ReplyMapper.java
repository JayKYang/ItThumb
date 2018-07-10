package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Reply;

public interface ReplyMapper {

	@Select("select ifnull(max(replyno),0) from reply")
	int replyMaxNum();

	@Insert("insert into reply (replyno, memberid, name, content, regdate, ref, reflevel, refstep, communityno) values (#{replyno}, #{memberid}, #{name}, #{content}, now(), #{ref}, #{reflevel}, #{refstep}, #{communityno})")
	void replyCreate(Reply reply);

	@Select("select * from reply where replyno = #{replyno}")
	Reply selectReply(Integer replyno);

	@Update("update reply set refstep = refstep+1 where ref=#{ref} and refstep > #{refstep}")
	void updateReReply(Reply reply);

	@Update("update reply set content = #{content} where replyno = #{replyno}")
	void updateRe(Reply replyUpdate);

	@Delete("delete from reply where replyno=#{replyno}")
	void replyDelete(Integer replyno);

	@Delete("delete from reply where communityno=#{communityno}")
	void comReplyDelete(Integer communityno);

}
