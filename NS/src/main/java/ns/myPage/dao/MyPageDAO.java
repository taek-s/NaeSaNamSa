package ns.myPage.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("myPageDAO")
public class MyPageDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPwCheck(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("myPage.selectPwCheck", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("myPage.selectAccountInfo", map);
	}

	public void updateAccountModify(Map<String, Object> map) throws Exception {
		update("myPage.updateAccountModify", map);
	}

	public void updateNaverAccountModify(Map<String, Object> map) throws Exception {
		update("myPage.updateNaverAccountModify", map);
	}

	public void updateKakaoAccountModify(Map<String, Object> map) throws Exception {
		update("myPage.updateKakaoAccountModify", map);
	}

	public int deleteAccount(Map<String, Object> map) throws Exception {
		String result = String.valueOf(update("myPage.deleteAccount", map));
		int count = Integer.parseInt(result);
		// update처리된 행의 수를 리턴. 성공하면 1, 실패하면 0 리턴
		return count;
	}

	public int realDeleteAccount(Map<String, Object> map) throws Exception {
		String result = String.valueOf(delete("myPage.realDeleteAccount", map));
		int count = Integer.parseInt(result);
		// update처리된 행의 수를 리턴. 성공하면 1, 실패하면 0 리턴
		return count;
	}

	public void updateGoodsDelGB(Map<String, Object> map) throws Exception {
		update("myPage.updateGoodsDelGB", map);
	}
}
