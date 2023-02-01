package ns.order.service;

import java.util.Map;

public interface OrderService {

	Map<String, Object> selectGoodsInfo(Map<String, Object> map) throws Exception;

	Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception;

	void insertOrder(Map<String, Object> map) throws Exception;

	void updateGoodsTstatusByOrder(Map<String, Object> map) throws Exception;

	Map<String, Object> selectOrderDetail(Map<String, Object> map) throws Exception;

	void updateOrderModify(Map<String, Object> map) throws Exception;

	void updateGoodsTstatusByOrderCancel(Map<String, Object> map) throws Exception;

	int selectMaxOrderNum() throws Exception;

	void deleteOrder(Map<String, Object> map) throws Exception;

	void updateGoodsTstatusByOrder2(Map<String, Object> map) throws Exception;

}
