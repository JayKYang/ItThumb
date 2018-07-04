package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.StudyGroup;

public interface StudyGroupMapper {

	@Select("select count(*) from studygroup")
	int studyGroupMaxNum();

	@Insert("insert into studygroup (groupno,studyno,leadermember,regmember,state) VALUES (#{groupno},#{studyno},#{leadermember},#{regmember},#{state})")
	void studyGroupInsert(StudyGroup studyGroupInsert);

	@Delete("delete from studygroup where groupno=#{groupno}")
	void studyGroupDelete(int groupno);

}
