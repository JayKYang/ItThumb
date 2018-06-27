package logic;

import javax.servlet.http.HttpServletRequest;

public interface JsyService {

	void createNormalUser(User user, HttpServletRequest request);

	void createCompanyUser(User user, HttpServletRequest request);

}
