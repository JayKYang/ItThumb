package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Hire;

public interface HireMapper {
	@Select("select ifnull(max(hireno),0) from hireboard")
	int maxNum();
	
	@Insert("insert into hireboard (hireno, qualification,hirestatus,salary,workday,memberid,hide,deadline,readcnt,subject,image,content,region) "
					+"values (#{hireno},#{qualification},#{hirestatus},#{salary},#{workday},#{memberid},0,now(),0,#{imageUrl},#{content},#{region})")
	void insert(Hire hire);

}
