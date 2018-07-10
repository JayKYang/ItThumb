package dao;

import java.util.List;

import logic.Study;
import logic.StudyGroup;

public interface StudyDao {

	int studyMax(String searchType, String searchContent);

	List<Study> studylist(String searchType, String searchContent, Integer pageNum, int limit);

	int studyMaxNum();

	void StudyWrite(Study study);

	Study studySelect(Integer studyno);

	void studyDelete(Integer studyno);

	void studyUpdate(Study study);


}
