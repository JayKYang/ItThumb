package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Scrap;

public interface ScrapMapper {
	
	@Select("select ifnull(max(scrap),0) from scrap")
	int scrapMaxnum();
	
	@Insert("insert into scrap(scrap, memberid,hireno) values (#{scrap},#{memberid},#{hireno})")
	void insert(Scrap scrap);

	@Select("select hireno from scrap where hireno = #{hireno} and memberid = #{memberid}")
	String selectScrap(Map<Object, Object> map);
	
	@Delete("delete from scrap where hireno = #{hireno} and memberid = #{memberid}")
	void deleteScrap(Map<Object, Object> map);

	@Select("select ifnull(max(scrapnum),0) from board where hireno = #{hireno}")
	int hireScrapcount(Integer hireno);

	

}
