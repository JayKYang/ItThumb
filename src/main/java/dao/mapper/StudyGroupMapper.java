package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.StudyGroup;

public interface StudyGroupMapper {

	@Select("select ifnull(max(groupno),0) from studygroup")
	int studyGroupMaxNum();

	@Insert("insert into studygroup (groupno,studyno,leadermember,regmember,state) VALUES (#{groupno},#{studyno},#{leadermember},#{regmember},#{state})")
	void studyGroupInsert(StudyGroup studyGroupInsert);

	@Delete("delete from studygroup where groupno=#{groupno}")
	void studyGroupDelete(int groupno);

	@Delete("delete from studygroup where studyno=#{studyno}")
	void studyGroupAllDelete(Integer studyno);

	@Select("select * from studygroup where regmember=#{memberid}")
	List<StudyGroup> studygrouplist(String memberid);
}
