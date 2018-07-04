package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Message;

public interface MessageMapper {

	@Select("select * from message where messageno = #{messageno}")
	Message messageSelect(Integer messageno);

	@Update("update message set confirm = 1 where messageno = #{messageno}")
	void messageComfirm(Integer messageno);

	@Delete("delete from message where messageno=#{messageno} and senddelete = 1 and receivedelete = 1")
	void messageDBdelete(String messageno);

	@Insert("insert into message (messageno,sender, receiver, subject, content, senddate, senddelete, receivedelete, confirm) VALUES (#{messageno},#{sender},#{receiver},#{subject},#{content},now(),0,0,0)")
	void messageWrite(Message message);

	@Select("select count(*) from message")
	int messageMax();

}
