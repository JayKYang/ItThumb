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

	void leaveStudy(Integer studyno, String memberid);

	void myStudyaceept(String regmember, Integer studyno, Integer state);

	void myStudyKick(String regmember, Integer studyno);

	List<StudyGroup> studygroupAOP(int studyno);
}
