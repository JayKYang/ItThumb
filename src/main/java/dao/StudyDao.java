package dao;

import java.util.List;

import logic.Study;
import logic.StudyGroup;
import logic.User;

public interface StudyDao {

	int studyMax(String searchType, String searchContent);

	List<Study> studylist(String searchType, String searchContent, Integer pageNum, int limit);

	int studyMaxNum();

	void StudyWrite(Study study);

	Study studySelect(Integer studyno);

	void studyDelete(Integer studyno);

	void studyUpdate(Study study);

	int myApplyStudyCount(String searchType, String searchContent, String memberid);

	List<Study> myApplyStudyList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int myScrapStudyCount(String searchType, String searchContent, String memberid);

	List<Study> myScrapStudyList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int myStudyCount(String searchType, String searchContent, String memberid);

	List<Study> myStudyList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	List<User> myStudyInfoList(Integer studyno);


}
