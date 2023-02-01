package ns.order.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.order.dao.OrderDAO;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Resource(name = "orderDAO")
	private OrderDAO orderDAO;

	@Override
	public Map<String, Object> selectGoodsInfo(Map<String, Object> map) throws Exception {
		return orderDAO.selectGoodsInfo(map);
	}

	@Override
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		return orderDAO.selectAccountInfo(map);
	}

	@Override
	public void insertOrder(Map<String, Object> map) throws Exception {
		orderDAO.insertOrder(map);
	}

	@Override
	public void updateGoodsTstatusByOrder(Map<String, Object> map) throws Exception {
		orderDAO.updateGoodsTstatusByOrder(map);
	}

	@Override
	public Map<String, Object> selectOrderDetail(Map<String, Object> map) throws Exception {
		Map<String, Object> orderMap = orderDAO.selectOrderDetail(map); // map은 jsp에서 온거 (commandMap)
		orderMap.put("MEM_NUM", orderMap.get("ORDERS_USER"));
		Map<String, Object> memberMap = orderDAO.selectAccountInfo(orderMap);
		orderMap.put("MEM_NAME", memberMap.get("MEM_NAME"));
		return orderMap;
	}

	@Override
	public void updateOrderModify(Map<String, Object> map) throws Exception {
		orderDAO.updateOrderModify(map);

	}

	@Override
	public void deleteOrder(Map<String, Object> map) throws Exception {
		orderDAO.deleteOrder(map);

	}

	@Override
	public void updateGoodsTstatusByOrderCancel(Map<String, Object> map) throws Exception {
		orderDAO.updateGoodsTstatusByOrderCancel(map);
	}

	@Override
	public int selectMaxOrderNum() throws Exception {
		return orderDAO.selectMaxOrderNum();
	}

	@Override
	public void updateGoodsTstatusByOrder2(Map<String, Object> map) throws Exception {
		orderDAO.updateGoodsTstatusByOrder2(map);
	}

}
