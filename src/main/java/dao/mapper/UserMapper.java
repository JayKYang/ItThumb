package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (memberid, password, name, regdate, tel, membergrade, recognizecode, image, locking, createpf) values (#{memberid},#{password},#{name},CURDATE(),#{tel},#{membergrade},#{recognizecode},#{imageUrl},#{locking},#{createpf})")
	void normalInsert(User user);
	
	@Insert("insert into user (memberid, password, name, regdate, tel, membergrade, birth, image, locking, industy, site, address) values (#{memberid},#{password},#{name},CURDATE(),#{tel},#{membergrade},#{birth},#{imageUrl},#{locking},#{industy}, #{site}, #{address})")
	void companyInsert(User user);

	@Update("update user set name=#{name}, modifydate=now(), tel=#{tel}, membergrade=#{membergrade}, birth=#{birth}, image=#{imageUrl}, createpf=#{createpf}, slogun=#{slogun}, introduce=#{introduce}, site=#{site}, address=#{address} where memberid=#{memberid}")
	void userUpdate(User user);

}
