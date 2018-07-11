package dao;

import java.util.List;

import logic.Scrap;
import logic.User;

public interface ScrapDao {

	Scrap scrapComfirm(int studyno, String memberid);

	int scrapMaxNum();

	void studyScrapInsert(Scrap insertScrap);

	void studyScrapDelete(int scrap);

	void scrapAllDelete(Integer studyno);

	Scrap hireScrapSelect(int hireno, String memberid);

	void hireInsertScrap(Scrap insertScrap);

	void hireDeleteScrap(int scrap);


	List<Scrap> scrapHirelist(String memberid,Integer pageNum, int limit);

	int scrapHireCount(String memberid);

	Scrap portfolioScrapConfirm(String loginid, String scrapid);

	int getScrapmembercount(String searchType, String searchContent, String memberid);

	List<User> getScrapmemberlist(String searchType, String searchContent, Integer pageNum, int limit,
			String memberid);

}
