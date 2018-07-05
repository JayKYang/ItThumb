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
import dao.UserDao;

@Service
public class JsyServiceImpl implements JsyService{
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
	
	
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
	public Hire getHire(Integer hireno) {
		
		return boardDao.getHire(hireno);
	}

	@Override
	public void readCntplus(Integer hireno) {
		boardDao.readCntplus(hireno);
	}

	@Override
	public void boardScrap(Scrap scrap,Integer hireno) {
		
		boardDao.updateScrapNum(hireno);
		
		
		
		int num = boardDao.scrapMaxnum();
		scrap.setScrap(++num);
		
		boardDao.boardScrap(scrap);
	}

	@Override
	public String selectScrap(Integer hireno, String memberid) {
		// TODO Auto-generated method stub
		return boardDao.selectScrap(hireno,memberid);
	}

	@Override
	public void deleteScrap(Integer hireno, String memberid) {
		
		boardDao.scrapNumMinus(hireno);
		
		boardDao.deleteScrap(hireno, memberid);
		
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













	
}
