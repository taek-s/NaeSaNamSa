package ns.admin.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.admin.dao.AdminUserDAO;

@Service("adminUserService")
public class AdminUserServiceImpl implements AdminUserService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "adminUserDAO")
	private AdminUserDAO adminUserDAO;

	@Override
	public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception {
		return adminUserDAO.selectUserList(map);
	}

	@Override
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) adminUserDAO.selectAccountInfo(map);
	}

	@Override
	public void deleteAccount(Map<String, Object> map) throws Exception {
		adminUserDAO.deleteAccount(map);
	}

	@Override
	public void updateAccountStatus(Map<String, Object> map) throws Exception {
		adminUserDAO.updateAccountStatus(map);
	}

	@Override
	public void updateAccountStatusNormal(Map<String, Object> map) throws Exception {
		adminUserDAO.updateAccountStatusNormal(map);
	}

	@Override
	public int selectUserCount(Map<String, Object> map) throws Exception {
		return adminUserDAO.selectUserCount(map);
	}

	@Override
	public void deleteGoodsTemp(Map<String, Object> map) throws Exception {
		adminUserDAO.deleteGoodsTemp(map);
	}

	@Override
	public void restoreGoods(Map<String, Object> map) throws Exception {
		adminUserDAO.restoreGoods(map);
	}

}
