package dao.mapper;


import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Scrap;

public interface ScrapMapper {

	@Select("select ifnull(max(scrap),0) from scrap")
	int scrapMaxNum();

	@Insert("insert into scrap (scrap,memberid,studyno) VALUES (#{scrap},#{memberid},#{studyno})")
	void studyScrapInsert(Scrap insertScrap);

	@Delete("delete from scrap where scrap=#{scrap}")
	void studyScrapDelete(int scrap);

	@Delete("delete from scrap where studyno=#{studyno}")
	void scrapAllDelete(Integer studyno);

	@Insert("insert into scrap (scrap,memberid,hireno) values (#{scrap},#{memberid},#{hireno})")
	void hireInsertScrap(Scrap insertScrap);

	@Delete("delete from scrap where scrap = #{scrap}")
	void hireDeleteScrap(int scrap);

}
