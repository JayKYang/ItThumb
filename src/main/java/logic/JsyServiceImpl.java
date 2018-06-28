package logic;

import java.io.File;
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

	
}
