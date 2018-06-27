package dao;

import logic.User;

public interface UserDao {

	void createNormalUser(User user);

	void createCompanyUser(User user);

	User selectUser(String memberid);

}
