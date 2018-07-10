package dao;

import logic.StudyGroup;

public interface StudyGroupDao {

	StudyGroup studyGroupComfirm(int studyno, String regmember);

	int studyGroupMaxNum();

	void studyGroupInsert(StudyGroup studyGroupInsert);

	void studyGroupDelete(int groupno);

	void studyGroupAllDelete(Integer studyno);

}
