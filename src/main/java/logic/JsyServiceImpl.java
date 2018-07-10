package logic;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.CommunityDao;
import dao.FilerepDao;
import dao.MessageDao;
import dao.ReplyDao;
import dao.PortFolioDao;
import dao.ScrapDao;
import dao.StudyDao;
import dao.StudyGroupDao;
import dao.UserDao;

@Service
public class JsyServiceImpl implements JsyService{
	@Autowired
	private UserDao userDao;
	@Autowired
	private PortFolioDao portfolioDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private MessageDao messageDao;
	@Autowired
	private StudyDao studyDao;
	@Autowired
	private ScrapDao scrapDao;
	@Autowired
	private StudyGroupDao studyGroupDao;
	@Autowired
	private CommunityDao communityDao;
	@Autowired
	private FilerepDao filerepDao;
	@Autowired
	private ReplyDao replydao;
	
	
	@Override
	public void createNormalUser(User user, HttpServletRequest request) {
		if(user.getImage() != null && !user.getImage().isEmpty()) {
			uploadUserImageCreate(user.getImage(), request);
			user.setImageUrl(user.getImage().getOriginalFilename());
		}
		userDao.createNormalUser(user);
		
	}

	private void uploadUserImageCreate(MultipartFile image, HttpServletRequest request) {
		String uploadPath = request.getServletContext().getRealPath("/")+"/photo/"; 
		String orgFile = image.getOriginalFilename();
		try {
			image.transferTo(new File(uploadPath+orgFile));
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void createCompanyUser(User user, HttpServletRequest request) {
		if(user.getImage() != null && !user.getImage().isEmpty()) {
			uploadUserImageCreate(user.getImage(), request);
			user.setImageUrl(user.getImage().getOriginalFilename());
		}
		userDao.createCompanyUser(user);
		
	}

	@Override
	public User getUser(String memberid) {
		return userDao.selectUser(memberid);
	}
	
	@Override
	public List<History> getHistory(String memberid) {
		return portfolioDao.getHistory(memberid);
	}
	
	@Override
	public int boardcount(String searchRegion, String searchEdu, String searchCarr,String searchCareer,String searchCareerDate) {
		
		return boardDao.count(searchRegion, searchEdu,searchCarr,searchCareer,searchCareerDate);
	}

	@Override
	public List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, String searchCareer,String searchCareerDate,Integer pageNum, int limit) {
		return boardDao.hirelist(searchRegion, searchEdu, searchCarr,searchCareer,searchCareerDate, pageNum, limit);
	}

	@Override
	public void hireWrite(Hire hire, HttpServletRequest request) {
				
		try {
			Date deadline = hire.getDeadline();
			   SimpleDateFormat sourceDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   sourceDateFormat.format(deadline);
		    hire.setDeadline(deadline);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		if(hire.getImage() != null && !hire.getImage().isEmpty()) {
			uploadhireImageCreate(hire.getImage(),request);
			hire.setImageUrl(hire.getImage().getOriginalFilename());
		}
		
		int num = boardDao.maxNum();
		hire.setHireno(++num);
		
		boardDao.hireWrite(hire);
	}

	private void uploadhireImageCreate(MultipartFile image, HttpServletRequest request) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/hireimg/";  
		
		String orgFile = image.getOriginalFilename();
		try {
			image.transferTo(new File(uploadPath + orgFile));
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
		
	public void updateUser(User user, HttpServletRequest request) {
		if(user.getImage() != null && !user.getImage().isEmpty()) {
			uploadUserImageCreate(user.getImage(), request);
			user.setImageUrl(user.getImage().getOriginalFilename());
		}
		userDao.updateUser(user);
	}

	@Override
	public void deleteUser(String id) {
		userDao.deleteUser(id);
	}

	@Override
	public void confirmCode(User user) {
		userDao.confirmCode(user);
	}

	@Override
	public Hire getHire(Integer hireno) {
		
		return boardDao.getHire(hireno);
	}

	@Override
	public void readCntplus(Integer hireno) {
		boardDao.readCntplus(hireno);
	}
	@Override
	public List<User> userList(Integer membergrade) {
		
		return userDao.userList(membergrade);
	}

	@Override
	public int popBoardcount() {
		
		return boardDao.popBoardcount();
	}

	@Override
	public List<Hire> popHirelist(int popLimit) {
	
		return boardDao.popHirelist(popLimit);
	}

	@Override
	public List<Hire> getHirelist() {
		return boardDao.getHirelist();
	}
	@Override
	public void updateHide(int hireno) {	
		boardDao.updateHide(hireno);
	}

	@Override
	public void insertHistory(History history) {
		portfolioDao.insertHistory(history);
	}

	@Override
	public int maxHistoryno() {
		return portfolioDao.maxHistoryno();
	}

	@Override
	public void deleteHistory(int historyno) {
		portfolioDao.deleteHistory(historyno);
	}

	@Override
	public void updateHistory(History history) {
		portfolioDao.updateHistory(history);
	}

	@Override
	public void updateUserAboutMe(User user, HttpServletRequest request) {
		if(user.getImage() != null && !user.getImage().isEmpty()) {
			uploadUserImageCreate(user.getImage(), request);
			user.setImageUrl(user.getImage().getOriginalFilename());
		}
		portfolioDao.updateUserAboutMe(user);
	}

	@Override
	public int messagecount(String searchType, String searchContent, String sort, String memberid) {
		return messageDao.messagecount(searchType, searchContent, sort, memberid);
	}

	@Override
	public List<Message> messagelist(String searchType, String searchContent, Integer pageNum, int limit, String sort, String memberid) {

		return messageDao.messagelist(searchType, searchContent, pageNum, limit, sort, memberid);
	}

	@Override
	public Message messageSelect(Integer messageno) {
		return messageDao.messageselect(messageno);
	}

	@Override
	public void messageConfirm(Integer messageno) {
		messageDao.messageConfirm(messageno);
	}

	@Override
	public void messagedelete(String messageno, Integer sort) {
		messageDao.messageDelete(messageno, sort);
		
	}

	@Override
	public void messageDBdelete(String messageno) {
		messageDao.messageDBdelete(messageno);
		
	}

	@Override
	public void messageWrite(Message message) {
		messageDao.messageWrite(message);
		
	}

	@Override
	public int messageMax() {
		return messageDao.messageMax();
	}

	@Override
	public int studycount(String searchType, String searchContent) {
		return studyDao.studyMax(searchType, searchContent);
	}

	@Override
	public List<Study> studylist(String searchType, String searchContent, Integer pageNum, int limit) {
		return studyDao.studylist(searchType, searchContent, pageNum, limit);
	}

	@Override
	public int studyMaxNum() {
		return studyDao.studyMaxNum();
	}

	@Override
	public void studyWrite(Study study) {
		studyDao.StudyWrite(study);
	}

	@Override
	public Study studySelect(Integer studyno) {
		return studyDao.studySelect(studyno);
	}

	@Override
	public Scrap scrapComfirm(int studyno, String memberid) {
		return scrapDao.scrapComfirm(studyno, memberid);
	}

	@Override
	public int ScrapMaxnum() {
		return scrapDao.scrapMaxNum();
	}

	@Override
	public void studyScrapInsert(Scrap insertScrap) {
		scrapDao.studyScrapInsert(insertScrap);
		
	}

	@Override
	public void studyScrapDelete(int scrap) {
		scrapDao.studyScrapDelete(scrap);
		
	}

	@Override
	public StudyGroup studyGroupComfirm(int studyno, String regmember) {
		return studyGroupDao.studyGroupComfirm(studyno, regmember);
	}

	@Override
	public int studyGroupMaxNum() {
		return studyGroupDao.studyGroupMaxNum();
	}

	@Override
	public void studyGroupInsert(StudyGroup studyGroupInsert) {
		studyGroupDao.studyGroupInsert(studyGroupInsert);
		
	}

	@Override
	public void studyGroupDelete(int groupno) {
		studyGroupDao.studyGroupDelete(groupno);
		
	}


	@Override
	public void deleteportfolio(String id) {
		portfolioDao.deleteportfolio(id);
	}

	@Override
	public List<Project> getProject(String id) {
		return portfolioDao.getProject(id);
	}

	@Override
	public Project getProject(String id, String projectno) {
		return portfolioDao.getProjectone(id,projectno);
	}

	@Override
	public void deleteProject(String projectno) {
		 portfolioDao.deleteProject(projectno);
	}

	@Override
	public void studyDelete(Integer studyno) {
		studyDao.studyDelete(studyno);
	}

	@Override
	public void studyUpdate(Study study) {
		studyDao.studyUpdate(study);
	}
	
	private void uploadprojectImageCreate(MultipartFile image, HttpServletRequest request) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/projectimg/";  
		
		String orgFile = image.getOriginalFilename();
		try {
			image.transferTo(new File(uploadPath + orgFile));
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	@Override
	public void insertproject(Project project, HttpServletRequest request) {
		if(project.getImagefile() != null && !project.getImagefile().isEmpty()) {
			uploadprojectImageCreate(project.getImagefile(),request);
			project.setImagefileUrl(project.getImagefile().getOriginalFilename());
		}
		portfolioDao.insertproject(project);
	}

	@Override
	public int maxProjectno() {
		return portfolioDao.maxProjectno();
	}

	@Override
	public void updateproject(Project project, HttpServletRequest request) {
		if(project.getImagefile() != null && !project.getImagefile().isEmpty()) {
			uploadprojectImageCreate(project.getImagefile(),request);
			project.setImagefileUrl(project.getImagefile().getOriginalFilename());
		}
		 portfolioDao.updateproject(project);
	}
	@Override
	public Scrap hireScrapSelect(int hireno, String memberid) {
		
		return scrapDao.hireScrapSelect(hireno,memberid);
	}

	@Override
	public void hireInsertScrap(Scrap insertScrap) {
		scrapDao.hireInsertScrap(insertScrap);
		
	}

	@Override
	public void hireDeleteScrap(int scrap) {
		scrapDao.hireDeleteScrap(scrap);
		
	}
	
	@Override
	public void updateRecognize(User user) {
		userDao.updateRecognize(user);
	}

	@Override
	public void repassword(User user) {
		userDao.repassword(user);
	}


	@Override
	public void deleteHire(int hireno) {
		boardDao.deleteHire(hireno);
		
	}

	@Override
	public List<Scrap> scrapHirelist(Integer hireno, String memberid) {
	
		return scrapDao.scrapHirelist(hireno, memberid);
	}

	@Override
	public int Communitycount(String searchType, String searchContent, Integer communitykind, String memberid) {
		return communityDao.communitycount(searchType, searchContent, communitykind, memberid);
	}

	@Override
	public List<Community> communityLlist(String searchType, String searchContent, Integer pageNum, int limit, Integer communitykind, String memberid) {
		return communityDao.communityList(searchType, searchContent, pageNum, limit, communitykind, memberid);
	}

	@Override
	public int comMaxNum() {
		return communityDao.comMaxNum();
	}

	@Override
	public void comCreate(Community community, HttpServletRequest request) {
		for(MultipartFile mf : community.getFileList()) {
			if(!mf.isEmpty()) {
				uploadComFiles(mf, request, community.getCommunityno());
			}
		}
		communityDao.comCreate(community);
	}

	private void uploadComFiles(MultipartFile mf, HttpServletRequest request, int communityno) {
		String uploadPath = request.getServletContext().getRealPath("/")+"/comfiles/";
		try {
			
				Filerep filerep = new Filerep();
				int fileMaxNum = filerepDao.fileMaxNum()+1;
				String orgFileName = mf.getOriginalFilename();
				filerep.setFileno(fileMaxNum);
				filerep.setCommunityno(communityno);
				filerep.setFname(orgFileName);
				filerepDao.fileCreate(filerep);
				mf.transferTo(new File(uploadPath + orgFileName));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Community comSelect(Integer communityno) {
		return communityDao.comSelect(communityno);
	}

	@Override
	public List<Filerep> fileList(Integer communityno) {
		return filerepDao.fileList(communityno);
	}

	@Override
	public void comReadCount(Integer communityno) {
		communityDao.comReadCount(communityno);
		
	}

	@Override
	public List<Reply> replyList(Integer communityno) {
		return replydao.replyList(communityno);
	}

	@Override
	public int replyMaxNum() {
		return replydao.replyMaxNum();
	}

	@Override
	public void replyCreate(Reply reply) {
		replydao.replyCreate(reply);
		
	}

	@Override
	public Reply setlectReply(Integer replyno) {
		return replydao.selectReply(replyno);
	}

	@Override
	public void insertReReply(Reply reply) {
		replydao.insertReReply(reply);
	}

	@Override
	public void updateRe(Reply replyUpdate) {
		replydao.updateRe(replyUpdate);
		
	}

	@Override
	public void replyDelete(Integer replyno) {
		replydao.replyDelete(replyno);
		
	}

	@Override
	public void communityDelete(Integer communityno) {
		communityDao.communityDelete(communityno);
		
	}

	@Override
	public void comReplyDelete(Integer communityno) {
		replydao.comReplyDelete(communityno);
		
	}

	@Override
	public void comFileDelete(Integer communityno) {
		filerepDao.comFileDelete(communityno);
		
	}

	@Override
	public int fileMaxNum() {
		return filerepDao.fileMaxNum();
	}

	@Override
	public void comUpdate(Community community, HttpServletRequest request) {
		if(community.getFileList() != null) {
			for(MultipartFile mf : community.getFileList()) {
				if(!mf.isEmpty()) {
					uploadComFiles(mf, request, community.getCommunityno());
				}
			}
		}
		communityDao.comUpdate(community);
		
	}

	@Override
	public void fileupdate(Filerep filerep) {
		filerepDao.fileCreate(filerep);
	}

	@Override
	public void studyGroupAllDelete(Integer studyno) {
		studyGroupDao.studyGroupAllDelete(studyno);
		
	}

	@Override
	public void scrapAllDelete(Integer studyno) {
		scrapDao.scrapAllDelete(studyno);
		
	}
		
}
