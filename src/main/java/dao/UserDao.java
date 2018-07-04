package dao;

import java.util.List;

import logic.History;
import logic.User;

public interface UserDao {

	void createNormalUser(User user);

	void createCompanyUser(User user);

	User selectUser(String memberid);

	void updateUser(User user);

	void deleteUser(String id);

	void confirmCode(User user);

	List<History> getHistory(String memberid);

	void insertHistory(History history);

	int maxHistoryno();

	void deleteHistory(int historyno);

	void updateHistory(History history);

	void updateUserAboutMe(User user);

	void deleteportfolio(String id);


}
