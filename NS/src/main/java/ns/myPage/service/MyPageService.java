package ns.myPage.service;

import java.util.Map;

public interface MyPageService {

	Map<String, Object> selectPwCheck(Map<String, Object> map) throws Exception;

	Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception;

	void updateAccountModify(Map<String, Object> map) throws Exception;

	// 탈퇴처리된 회원의 수를 int로 리턴받음
	int deleteAccount(Map<String, Object> map) throws Exception;

	int realDeleteAccount(Map<String, Object> map) throws Exception;

	void updateGoodsDelGB(Map<String, Object> map) throws Exception;
}
