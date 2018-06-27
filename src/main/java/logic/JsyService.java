package logic;

import javax.servlet.http.HttpServletRequest;

public interface JsyService {

	void createNormalUser(User user, HttpServletRequest request);

	void createCompanyUser(User user, HttpServletRequest request);

	User getUser(String memberid);

	int boardcount(String searchRegion, String searchEdu, String searchCarr);

	List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit);

}
