package dao.mapper;

import org.apache.ibatis.annotations.Insert;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (memberid, password, name, regdate, tel, membergrade, recognizecode, image, locking) values (#{memberid},#{password},#{name},now(),#{tel},#{membergrade},#{recognizecode},#{imageUrl},#{locking})")
	void insert(User user);

}
