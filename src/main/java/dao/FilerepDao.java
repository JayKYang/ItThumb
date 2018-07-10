package dao;

import java.util.List;

import logic.Filerep;

public interface FilerepDao {

	int fileMaxNum();

	void fileCreate(Filerep filerep);

	List<Filerep> fileList(Integer communityno);

	void comFileDelete(Integer communityno);

}
