package ns.order.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("orderDAO")
public class OrderDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGoodsInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("order.selectGoodsInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("order.selectAccountInfo", map);
	}

	@SuppressWarnings("unchecked")
	public void insertOrder(Map<String, Object> map) throws Exception {
		insert("order.insertOrder", map);
	}

	@SuppressWarnings("unchecked")
	public void updateGoodsTstatusByOrder(Map<String, Object> map) throws Exception {
		update("order.updateGoodsTstatusByOrder", map);
	}

	@SuppressWarnings("unchecked")
	public void updateGoodsTstatusByOrder2(Map<String, Object> map) throws Exception {
		update("order.updateGoodsTstatusByOrder2", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOrderDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("order.selectOrderDetail", map);
	}

	@SuppressWarnings("unchecked")
	public void updateOrderModify(Map<String, Object> map) throws Exception {
		update("order.updateOrderModify", map);
	}

	@SuppressWarnings("unchecked")
	public void deleteOrder(Map<String, Object> map) throws Exception {
		delete("order.deleteOrder", map);
	}

	@SuppressWarnings("unchecked")
	public void updateGoodsTstatusByOrderCancel(Map<String, Object> map) throws Exception {
		update("order.updateGoodsTstatusByOrderCancel", map);
	}

	public int selectMaxOrderNum() throws Exception {
		int result = 999999763;
		if (selectOne("order.selectMaxOrderNum") == null) {
			return result;
		} else {
			return (int) selectOne("order.selectMaxOrderNum");
		}

	}

}
