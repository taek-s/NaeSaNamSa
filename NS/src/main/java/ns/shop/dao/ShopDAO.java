package ns.shop.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("shopDAO")
public class ShopDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllGoodsList(Map<String, Object> map) throws Exception {
		return selectList("shop.selectAllGoodsList", map);
	}

	public int selectAllGoodsCount(Map<String, Object> map) throws Exception {
		return (int) selectOne("shop.selectAllGoodsCount", map);
	}

	public void insertGoods(Map<String, Object> map) throws Exception {
		insert("shop.insertGoods", map);
	}

	public void insertGoodsImage(Map<String, Object> map) throws Exception {
		insert("shop.insertGoodsImage", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGoodsDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("shop.selectGoodsDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsImage(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("shop.selectGoodsImage", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGoodsLikeCount(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("shop.selectGoodsLikeCount", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception {
		update("shop.updateHitCnt", map);
	}

	public void updateGoodsModify(Map<String, Object> map) throws Exception {
		update("shop.updateGoodsModify", map);
	}

	public void updateGoodsImageModify(Map<String, Object> map) throws Exception {
		update("shop.updateGoodsImageModify", map);
	}

	public void deleteGoods(Map<String, Object> map) throws Exception {
		update("shop.deleteGoods", map);
	}

	public void deleteGoodsImage(Map<String, Object> map) throws Exception {
		update("shop.deleteGoodsImage", map);
	}

	public void insertGoodsLike(Map<String, Object> map) throws Exception {
		update("shop.insertGoodsLike", map);
	}

	public void deleteGoodsLike(Map<String, Object> map) throws Exception {
		update("shop.deleteGoodsLike", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsLike(Map<String, Object> map) throws Exception {
		return selectList("shop.selectGoodsLike", map);
	}
}
