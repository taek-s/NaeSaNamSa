package ns.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminUserService {

	List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception;

	Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception;

	void deleteAccount(Map<String, Object> map) throws Exception;

	void updateAccountStatus(Map<String, Object> map) throws Exception;

	void updateAccountStatusNormal(Map<String, Object> map) throws Exception;

	int selectUserCount(Map<String, Object> map) throws Exception;

	void deleteGoodsTemp(Map<String, Object> map) throws Exception;

	void restoreGoods(Map<String, Object> map) throws Exception;
}
