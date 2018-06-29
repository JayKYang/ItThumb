package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Scrap;

public interface ScrapMapper {
	
	@Select("select ifnull(max(scrap),0) from scrap")
	int scrapMaxnum();
	
	@Insert("insert into scrap(scrap, memberid,hireno) values (#{scrap},#{memberid},#{hireno})")
	void insert(Scrap scrap);

}
