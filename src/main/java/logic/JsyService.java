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

	Hire getHire(Integer hireno,String searchType, String searchContent);

	void readCntplus(Integer hireno);

	List<User> userList(Integer membergrade);

	int popBoardcount();

	List<Hire> popHirelist(int popLimit);

	List<Hire> getHirelist();

	void updateHide(int hireno);

	List<History> getHistory(String memberid,String searchType, String searchContent);

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

	int Communitycount(String searchType, String searchContent, Integer communitykind, String memberid);

	List<Community> communityLlist(String searchType, String searchContent, Integer pageNum, int limit, Integer communitykind, String memberid);

	int comMaxNum();

	void comCreate(Community community, HttpServletRequest request);

	Community comSelect(Integer communityno);

	List<Filerep> fileList(Integer communityno);

	void comReadCount(Integer communityno);

	List<Reply> replyList(Integer communityno);

	int replyMaxNum();

	void replyCreate(Reply reply);

	Reply setlectReply(Integer replyno);

	void insertReReply(Reply reply);

	void updateRe(Reply replyUpdate);

	void replyDelete(Integer replyno);

	void communityDelete(Integer communityno);

	void comReplyDelete(Integer communityno);

	void comFileDelete(Integer communityno);

	int fileMaxNum();

	void comUpdate(Community community, HttpServletRequest request);

	void fileupdate(Filerep filerep);

	void studyGroupAllDelete(Integer studyno);

	void scrapAllDelete(Integer studyno);

	void updateRecognize(User user);

	void repassword(User user);

	Scrap hireScrapSelect(int hireno, String memberid);

	void hireInsertScrap(Scrap insertScrap);

	void hireDeleteScrap(int scrap);

	void deleteHire(int hireno);

	List<Scrap> scrapHirelist(String memberid,Integer pageNum,int limit);

	void hireUpdateScrapNum(int hireno);

	int suphirelistcount(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate);

	int scrapHireCount(String memberid,String searchType, String searchContent);

	int portfoliocount(String searchType, String searchContent, Integer createpf);

	List<User> portfoliolist(String searchType, String searchContent, Integer membergrade, Integer pageNum, int limit);

	Scrap portfolioScrapConfirm(String loginid, String scrapid);

	int usercount(String searchType, String searchContent);

	List<User> memberlist(String searchType, String searchContent, Integer membergrade, Integer pageNum, int limit);

	int hirecount(String searchType, String searchContent, Integer hide);

	List<Hire> getMypageHireList(String searchType, String searchContent, Integer pageNum, Integer hide, int limit);

	List<StudyGroup> studygrouplist(String memberid);


	List<Hire> getScrapList(String memberid, String searchType, String searchContent, Integer pageNum, int limit);

	List<Hire> getMyHireList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int getMyhirecount(String memberid, String searchType, String searchContent);


	int getScrapmembercount(String searchType, String searchContent, String memberid);

	List<User> scrapmemberlist(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int myApplyStudyCount(String searchType, String searchContent, String memberid);

	List<Study> myApplyStudyList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int myScrapStudyCount(String searchType, String searchContent, String memberid);

	List<Study> myScrapStudyList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	int myStudyCount(String searchType, String searchContent, String memberid);

	List<Study> myStudyList(String searchType, String searchContent, Integer pageNum, int limit, String memberid);

	List<User> myStudyInfoList(Integer studyno);


	void hireUpdate(Hire hire, HttpServletRequest request);

	int hireboardcount(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate);

	List<Hire> calhirelist(String searchRegion, String searchEdu, String searchCarr, String searchCareer,
			String searchCareerDate);

	void confirmuser(String id);

	void leaveStudy(Integer studyno, String memberid);

	void minusNowmember(Integer studyno);

	List<User> waitUserList(Integer studyno);

	void myStudyaceept(String regmember, Integer studyno, Integer state);

	void plusNowmember(Integer studyno);

	void myStudyKick(String regmember, Integer studyno);

	List<StudyGroup> studygroupAOP(int studyno);


}
