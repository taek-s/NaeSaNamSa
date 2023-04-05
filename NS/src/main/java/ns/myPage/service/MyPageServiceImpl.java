package ns.myPage.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.myPage.dao.MyPageDAO;

@Service("myPageService")
public class MyPageServiceImpl implements MyPageService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "myPageDAO")
	private MyPageDAO myPageDAO;

	@Override
	public Map<String, Object> selectPwCheck(Map<String, Object> map) throws Exception {
		System.out.println("selectPwCheck : " + map);
		return myPageDAO.selectPwCheck(map);
	}

	@Override
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		Map<String, Object> getMap = myPageDAO.selectAccountInfo(map);

		String phone = (String) getMap.get("MEM_PHONE");
		String phone1 = phone.substring(0, 3);
		String phone2 = phone.substring(3, 7);
		String phone3 = phone.substring(7, 11);
		getMap.put("MEM_PHONE1", phone1);
		getMap.put("MEM_PHONE2", phone2);
		getMap.put("MEM_PHONE3", phone3);

		return getMap;
	}

	@Override
	public void updateAccountModify(Map<String, Object> map) throws Exception {
		String phone1 = (String) map.get("MEM_PHONE1");
		String phone2 = (String) map.get("MEM_PHONE2");
		String phone3 = (String) map.get("MEM_PHONE3");
		String phone = phone1 + phone2 + phone3;
		map.put("MEM_PHONE", phone);

		if (map.get("kakao") != null) {
			myPageDAO.updateKakaoAccountModify(map);
		} else if (map.get("naver") != null) {
			myPageDAO.updateNaverAccountModify(map);
		} else {
			myPageDAO.updateAccountModify(map);
		}

	}

	@Override
	public int deleteAccount(Map<String, Object> map) throws Exception {
		return myPageDAO.deleteAccount(map);
	}

	@Override
	public int realDeleteAccount(Map<String, Object> map) throws Exception {
		return myPageDAO.realDeleteAccount(map);
	}

	@Override
	public void updateGoodsDelGB(Map<String, Object> map) throws Exception {
		myPageDAO.updateGoodsDelGB(map);

	}

}
