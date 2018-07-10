package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Filerep;

public interface FilerepMapper {

	@Select("select ifnull(max(fileno),0) from filerep")
	int fileMaxNum();

	@Insert("insert into filerep (fileno, communityno, fname) values (#{fileno}, #{communityno}, #{fname})")
	void fileCreate(Filerep filerep);
	
	@Delete("delete from filerep where communityno=#{communityno}")
	void comFileDelete(Integer communityno);
}
