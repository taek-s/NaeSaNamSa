package ns.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("adminUserDAO")
public class AdminUserDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("adminUser.selectUserList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("adminUser.selectAccountInfo", map);
	}

	public void deleteAccount(Map<String, Object> map) throws Exception {
		update("adminUser.deleteAccount", map);
	}

	public void updateAccountStatus(Map<String, Object> map) throws Exception {
		update("adminUser.updateAccountStatus", map);
	}

	public void updateAccountStatusNormal(Map<String, Object> map) throws Exception {
		update("adminUser.updateAccountStatusNormal", map);
	}

	public int selectUserCount(Map<String, Object> map) throws Exception {
		System.out.println("selectUserCount 파라미터: " + map);
		return (int) selectOne("adminUser.selectUserCount", map);
	}

	public void deleteGoodsTemp(Map<String, Object> map) throws Exception {
		update("adminUser.deleteGoodsTemp", map);
	}

	public void restoreGoods(Map<String, Object> map) throws Exception {
		update("adminUser.restoreGoods", map);
	}
}
