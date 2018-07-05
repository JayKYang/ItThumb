package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Study;

public interface StudyMapper {

	@Select("select ifnull(max(studyno),0) from study")
	int studyMaxNum();

	@Insert("INSERT into study (studyno, memberid, region, studyname, regdate, nowmember, limitmember, content, weekday, starttime, endtime, membername) VALUES(#{studyno},#{memberid},#{region},#{studyname},now(),${nowmember},${limitmember},#{content},#{weekday},#{starttime},#{endtime},#{membername})")
	void studyWrite(Study study);

	@Select("select * from study where studyno=#{studyno}")
	Study studySelect(Integer studyno);

	@Delete("delete from study where studyno=#{studyno}")
	void studyDelete(Integer studyno);

	@Update("update study set region=#{region}, studyname=#{studyname}, regdate=now(), limitmember=${limitmember}, content=#{content}, weekday=#{weekday}, starttime=#{starttime}, endtime=#{endtime} where studyno=#{studyno}")
	void studyUpdate(Study study);



}
