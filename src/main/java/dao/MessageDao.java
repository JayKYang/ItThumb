package dao;

import java.util.List;

import logic.Message;

public interface MessageDao {

	int messagecount(String searchType, String searchContent, Integer sort, String memberid);

	List<Message> messagelist(String searchType, String searchContent, Integer pageNum, int limit, Integer sort, String memberid);

	Message messageselect(Integer messageno);

	void messageConfirm(Integer messageno);

	void messageDelete(String messageno, Integer sort);

	void messageDBdelete(String messageno);

	void messageWrite(Message message);

	int messageMax();

}
