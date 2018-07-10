package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Community;

public interface CommunityMapper {

	@Select("select ifnull(max(communityno),0) from community")
	int comMaxNum();

	@Insert("insert into community (communityno, memberid, subject, content, regdate, communitykind, readcnt) values (#{communityno}, #{memberid}, #{subject}, #{content}, now(), #{communitykind}, #{readcnt})")
	void comCreate(Community community);

	@Select("select * from community where communityno=#{communityno}")
	Community comSelet(Integer communityno);

	@Update("update community set readcnt = readcnt+1 where communityno = #{communityno}")
	void comReadCount(Integer communityno);

	@Delete("delete from community where communityno=#{communityno}")
	void communityDelete(Integer communityno);

	@Update("update community set subject=#{subject}, content=#{content} where communityno = #{communityno}")
	void comUpdate(Community community);

}
