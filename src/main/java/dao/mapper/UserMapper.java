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

	@Update("update user set name=#{name}, modifydate=now(), tel=#{tel}, membergrade=#{membergrade}, birth=#{birth}, image=#{imageUrl}, createpf=#{createpf}, slogun=#{slogun}, introduce=#{introduce}, site=#{site}, address=#{address} where memberid=#{memberid}")
	void userUpdate(User user);

	@Delete("delete from user where memberid=#{value}")
	void userDelete(String id);

	@Update("update user set locking=1, recognizecode=null where memberid=#{memberid} and recognizecode=#{recognizecode}")
	void confirmCode(User user);

	@Select("select * from history where memberid=#{value} order by getdate")
	List<History> getHistory(String memberid);


}
