package dao;

import logic.Scrap;

public interface ScrapDao {

	Scrap scrapComfirm(int studyno, String memberid);

	int scrapMaxNum();

	void studyScrapInsert(Scrap insertScrap);

	void studyScrapDelete(int scrap);

	Scrap hireScrapSelect(int hireno, String memberid);

	void hireInsertScrap(Scrap insertScrap);

	void hireDeleteScrap(int scrap);

}
