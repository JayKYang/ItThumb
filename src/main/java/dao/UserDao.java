package dao;

import java.util.List;

import logic.User;

public interface UserDao {

	void createNormalUser(User user);

	void createCompanyUser(User user);

	User selectUser(String memberid);

	void updateUser(User user);

	void deleteUser(String id);

	void confirmCode(User user);

	void updateRecognize(User user);

	void repassword(User user);

	List<User> userList(Integer membergrade);

}
