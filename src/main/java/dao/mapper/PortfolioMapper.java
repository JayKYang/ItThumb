package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.History;
import logic.Project;
import logic.User;

public interface PortfolioMapper {


	/*@Select("select * from history where memberid=#{value} order by getdate desc,skillful desc;")
	List<History> getHistory(String memberid);*/

	@Insert("insert into history(historyno,memberid,content,skillful,getdate,enddate,kindno) values(#{historyno},#{memberid},#{content},#{skillful},#{getdate},#{enddate},#{kindno})")
	void insertHistory(History history);

	@Select("select ifnull(max(historyno),0) from history")
	int maxHistoryno();
	
	@Delete("delete from history where historyno=#{value}")
	void deleteHistory(int historyno);

	@Update("update history set memberid=#{memberid}, content=#{content}, skillful=#{skillful}, getdate=#{getdate}, enddate=#{enddate}, kindno=#{kindno} where historyno=#{historyno}")
	void updateHistory(History history);

	@Update("update user set name=#{name}, modifydate=now(), tel=#{tel}, birth=#{birth}, image=#{imageUrl}, createpf=#{createpf}, slogun=#{slogun}, introduce=#{introduce}, site=#{site}, address=#{address} where memberid=#{memberid}")
	void updateUserAboutMe(User user);

	@Update("update user set modifydate=now(), createpf=0 where memberid=#{value}")
	void deleteportfolio(String id);
	
	@Delete("delete from project where projectno=#{value}")
	void deleteProject(String projectno);

	@Insert("insert into project(projectno,memberid,subject,imagefile,term,content,role,link,skills) values(#{projectno},#{memberid},#{subject},#{imagefileUrl},#{term},#{content},#{role},#{link},#{skills})")
	void insertproject(Project project);

	@Select("select ifnull(max(projectno),0) from project")
	int maxProjectno();

	@Update("update project set subject=#{subject}, imagefile=#{imagefileUrl}, term=#{term}, content=#{content}, role=#{role}, link=#{link}, skills=#{skills} where projectno=#{projectno}")
	void updateproject(Project project);
}
