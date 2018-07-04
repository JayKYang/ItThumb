package logic;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.MessageDao;
import dao.ScrapDao;
import dao.StudyDao;
import dao.StudyGroupDao;
import dao.UserDao;

@Service
public class JsyServiceImpl implements JsyService{
	@Autowired
	private UserDao userDao;
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
	public int boardcount(String searchRegion, String searchEdu, String searchCarr) {
		
		return boardDao.count(searchRegion, searchEdu,searchCarr);
	}

	@Override
	public List<Hire> hirelist(String searchRegion, String searchEdu, String searchCarr, Integer pageNum, int limit) {
	
		return boardDao.hirelist(searchRegion, searchEdu, searchCarr, pageNum, limit);
	}

	@Override
	public void updateUser(User user) {
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


	
}
