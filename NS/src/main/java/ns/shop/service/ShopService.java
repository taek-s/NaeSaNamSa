package ns.shop.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ShopService {

	List<Map<String, Object>> selectAllGoodsList(Map<String, Object> map) throws Exception;

	int selectAllGoodsCount(Map<String, Object> map) throws Exception;

	int insertGoods(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception;

	Map<String, Object> selectGoodsDetail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectGoodsImage(Map<String, Object> map) throws Exception;

	Map<String, Object> selectGoodsLikeCount(Map<String, Object> map) throws Exception;

	void updateHitCnt(Map<String, Object> map) throws Exception;

	void updateGoodsModify(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception;

	void deleteGoods(Map<String, Object> map) throws Exception;

	void insertGoodsLike(Map<String, Object> map) throws Exception;

	void deleteGoodsLike(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectGoodsLike(Map<String, Object> map) throws Exception;

}
