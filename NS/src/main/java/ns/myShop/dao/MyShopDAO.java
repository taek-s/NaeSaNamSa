package ns.myShop.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("myShopDAO")
public class MyShopDAO extends AbstractDAO {

	// 내상점
	// 내가 등록한 상품 리스트 조회(상품정보 및 찜개수). 페이징O - selectList() -> 추후 페이징 어떻게 할건지에 따라 수정
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("myshop.selectGoodsList", map);
	}

	// 내가 등록한 상품 총 개수 조회. 페이징O
	public int selectMyGoodsCount(Map<String, Object> map) throws Exception {
		System.out.println("selectMyGoodsCount 파라미터 : " + map);

		return (int) selectOne("myshop.selectMyGoodsCount", map);
	}

	// 주문내역 리스트 조회 . 페이징O - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOrderList(Map<String, Object> map) throws Exception {
		System.out.println("selectOrderList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("myshop.selectOrderList", map);
	}

	// 내 주문 상품 총 개수 조회
	public int selectMyOrderTotalCount(Map<String, Object> map) throws Exception {
		System.out.println("selectMyOrderTotalCount 파라미터 : " + map);

		return (int) selectOne("myshop.selectMyOrderTotalCount", map);
	}

	// 판매내역 리스트 조회 . 페이징O - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSellList(Map<String, Object> map) throws Exception {
		System.out.println("selectSellList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("myshop.selectSellList", map);
	}

	// 내 판매 상품 총 개수 조회
	public int selectMySellTotalCount(Map<String, Object> map) throws Exception {
		System.out.println("selectMySellTotalCount 파라미터 : " + map);

		return (int) selectOne("myshop.selectMySellTotalCount", map);
	}

	// 찜 목록 조회. 페이징O - selectList() -> 추후 페이징 어떻게 할건지에 따라 수정
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsLikeList(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsLikeList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("myshop.selectGoodsLikeList", map);
	}

	// 내 찜 상품 총 개수 조회
	public int selectMyGoodsLikeTotalCount(Map<String, Object> map) throws Exception {
		System.out.println("selectMyGoodsLikeTotalCount 파라미터 : " + map);

		return (int) selectOne("myshop.selectMyGoodsLikeTotalCount", map);
	}

	// 최근 본 상품 조회. 페이징X(최근 본 상품 몇개만.2*4개)
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectRecentGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("selectRecentGoodsList 파라미터 : " + map);

		return (Map<String, Object>) selectOne("myshop.selectRecentGoodsList", map);
	}

}
