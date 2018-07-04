package logic;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface JsyService {

	void createNormalUser(User user, HttpServletRequest request);

	void createCompanyUser(User user, HttpServletRequest request);

	User getUser(String memberid);

	int boardcount(String searchRegion, String searchEdu, String searchCarr);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit);

	void hireWrite(Hire hire, HttpServletRequest request);

	void updateUser(User user, HttpServletRequest request);

	void deleteUser(String id);

	void confirmCode(User user);

	Hire getHire(Integer hireno);

	void readCntplus(Integer hireno);

	void boardScrap(Scrap scrap);

	List<History> getHistory(String memberid);

	void insertHistory(History history);

	int maxHistoryno();

	void deleteHistory(int historyno);

	void updateHistory(History history);


}
