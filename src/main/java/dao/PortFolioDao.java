package dao;

import java.util.List;

import logic.History;
import logic.Project;
import logic.User;

public interface PortFolioDao {
	void insertHistory(History history);

	int maxHistoryno();

	void deleteHistory(int historyno);

	void updateHistory(History history);

	void updateUserAboutMe(User user);

	void deleteportfolio(String id);

	List<History> getHistory(String memberid);

	List<Project> getProject(String id);

	Project getProjectone(String id, String projectno);

	void deleteProject(String projectno);

	void insertproject(Project project);

	int maxProjectno();

	void updateproject(Project project);


}
