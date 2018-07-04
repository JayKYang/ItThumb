package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.History;
import logic.User;

public interface UserMapper {

	@Insert("insert into user (memberid, password, name, regdate, tel, membergrade, recognizecode, image, locking, createpf) values (#{memberid},#{password},#{name},CURDATE(),#{tel},#{membergrade},#{recognizecode},#{imageUrl},#{locking},#{createpf})")
	void normalInsert(User user);
	
	@Insert("insert into user (memberid, password, name, regdate, tel, membergrade, birth, image, locking, industy, site, address) values (#{memberid},#{password},#{name},CURDATE(),#{tel},#{membergrade},#{birth},#{imageUrl},#{locking},#{industy}, #{site}, #{address})")
	void companyInsert(User user);

	@Update("update user set name=#{name}, modifydate=now(), image=#{imageUrl} where memberid=#{memberid}")
	void userUpdate(User user);

	@Delete("delete from user where memberid=#{value}")
	void userDelete(String id);

	@Update("update user set locking=1, recognizecode=null where memberid=#{memberid} and recognizecode=#{recognizecode}")
	void confirmCode(User user);

	@Select("select * from history where memberid=#{value} order by getdate desc,skillful desc;")
	List<History> getHistory(String memberid);

	@Insert("insert into history(historyno,memberid,content,skillful,getdate,enddate,kindno) values(#{historyno},#{memberid},#{content},#{skillful},#{getdate},#{enddate},#{kindno})")
	void insertHistory(History history);

	@Select("select ifnull(max(historyno),0) from history")
	int maxHistoryno();

	@Delete("delete from history where historyno=#{value}")
	void deleteHistory(int historyno);

	@Update("update history set memberid=#{memberid}, content=#{content}, skillful=#{skillful}, getdate=#{getdate}, enddate=#{enddate}, kindno=#{kindno} where historyno=#{historyno}")
	void updateHistory(History history);

	@Update("update user set name=#{name}, modifydate=now(), tel=#{tel}, birth=#{birth}, image=#{imageUrl}, createpf=#{createpf}, slogun=#{slogun}, introduce=#{introduce}, site=#{site}, address=#{address} where memberid=#{memberid}")
	void updateUserAboutMe(User user);

	@Update("update user set modifydate=now(), createpf=0 where memberid=#{value}")
	void deleteportfolio(String id);
}
