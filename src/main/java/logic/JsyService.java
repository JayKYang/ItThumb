package logic;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface JsyService {

	void createNormalUser(User user, HttpServletRequest request);

	void createCompanyUser(User user, HttpServletRequest request);

	User getUser(String memberid);

	int boardcount(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate,  Integer pageNum, int limit);

	void hireWrite(Hire hire, HttpServletRequest request);

	void updateUser(User user, HttpServletRequest request);

	void deleteUser(String id);

	void confirmCode(User user);

	int messagecount(String searchType, String searchContent, String sort, String memberid);

	List<Message> messagelist(String searchType, String searchContent, Integer pageNum, int limit, String sort, String memberid);

	Message messageSelect(Integer messageno);

	void messageConfirm(Integer messageno);

	void messagedelete(String messageno, Integer sort);

	void messageDBdelete(String messageno);

	void messageWrite(Message message);

	int messageMax();

	int studycount(String searchType, String searchContent);

	List<Study> studylist(String searchType, String searchContent, Integer pageNum, int limit);

	int studyMaxNum();

	void studyWrite(Study study);

	Study studySelect(Integer studyno);

	Scrap scrapComfirm(int studyno, String memberid);

	int ScrapMaxnum();

	void studyScrapInsert(Scrap insertScrap);

	void studyScrapDelete(int scrap);

	StudyGroup studyGroupComfirm(int studyno, String regmember);

	int studyGroupMaxNum();

	void studyGroupInsert(StudyGroup studyGroupInsert);

	void studyGroupDelete(int groupno);

	Hire getHire(Integer hireno);

	void readCntplus(Integer hireno);

	List<User> userList(Integer membergrade);

	int popBoardcount();

	List<Hire> popHirelist(int popLimit);

	List<Hire> getHirelist();

	void updateHide(int hireno);





	


	List<History> getHistory(String memberid);

	void insertHistory(History history);

	int maxHistoryno();

	void deleteHistory(int historyno);

	void updateHistory(History history);

	void updateUserAboutMe(User user, HttpServletRequest request);

	void deleteportfolio(String id);

	void studyDelete(Integer studyno);

	void studyUpdate(Study study);

	List<Project> getProject(String id);

	Project getProject(String id, String projectno);

	void deleteProject(String projectno);

	int maxProjectno();

	void updateproject(Project project, HttpServletRequest request);

	void insertproject(Project project, HttpServletRequest request);

	Scrap hireScrapSelect(int hireno, String memberid);

	void hireInsertScrap(Scrap insertScrap);

	void hireDeleteScrap(int scrap);

	void deleteHire(int hireno);

	List<Scrap> scrapHirelist(Integer hireno, String memberid);

}
