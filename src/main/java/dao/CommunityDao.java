package dao;

import java.util.List;

import logic.Community;
import logic.Filerep;

public interface CommunityDao {

	int communitycount(String searchType, String searchContent, Integer communitykind, String memberid);

	List<Community> communityList(String searchType, String searchContent, Integer pageNum, int limit, Integer communitykind, String memberid);

	int comMaxNum();

	void comCreate(Community community);

	Community comSelect(Integer communityno);

	void comReadCount(Integer communityno);

	void communityDelete(Integer communityno);

	void comUpdate(Community community);
}
