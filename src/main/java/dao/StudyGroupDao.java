package dao;

import java.util.List;

import logic.StudyGroup;

public interface StudyGroupDao {

	StudyGroup studyGroupComfirm(int studyno, String regmember);

	int studyGroupMaxNum();

	void studyGroupInsert(StudyGroup studyGroupInsert);

	void studyGroupDelete(int groupno);

	List<StudyGroup> studygrouplist(String memberid);

	void studyGroupAllDelete(Integer studyno);
}
