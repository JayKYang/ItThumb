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

	void updateUser(User user);

	void deleteUser(String id);

	void confirmCode(User user);

	Hire getHire(Integer hireno);

	void readCntplus(Integer hireno);

	void boardScrap(Scrap scrap, Integer hireno);

	String selectScrap(Integer hireno, String memberid);

	void deleteScrap(Integer hireno, String memberid);

	List<User> userList(Integer membergrade);

	int popBoardcount();

	List<Hire> popHirelist(int popLimit);

	List<Hire> getHirelist();

	void updateHide(int hireno);





	




}
