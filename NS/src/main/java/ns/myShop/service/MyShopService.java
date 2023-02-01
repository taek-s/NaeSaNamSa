package ns.myShop.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface MyShopService {

	// 내가 등록한 상품 리스트 조회(상품정보 및 찜개수). 페이징O
	List<Map<String, Object>> selectGoodsList(Map<String, Object> map) throws Exception;

	// 내가 등록한 상품 총 개수 조회. 페이징O
	int selectMyGoodsCount(Map<String, Object> map) throws Exception;

	// 주문 내역 리스트 조회. 페이징O
	List<Map<String, Object>> selectOrderList(Map<String, Object> map) throws Exception;

	// 내 주문 상품 총 개수
	int selectMyOrderTotalCount(Map<String, Object> map) throws Exception;

	// 판매 내역 리스트 조회. 페이징O
	List<Map<String, Object>> selectSellList(Map<String, Object> map) throws Exception;

	// 내 판매 상품 총 개수
	int selectMySellTotalCount(Map<String, Object> map) throws Exception;

	// 찜 목록 조회. 페이징O
	List<Map<String, Object>> selectGoodsLikeList(Map<String, Object> map) throws Exception;

	// 내 찜 상품 총 개수
	int selectMyGoodsLikeTotalCount(Map<String, Object> map) throws Exception;

	// 최근 본 상품 조회. 페이징X(최근 본 상품 몇개만. 2*4개)
	Map<String, Object> selectRecentGoodsList(Map<String, Object> map) throws Exception;

	// 세션에 올라간 로그인 정보중 회원번호 리턴
	int memberInfo(HttpServletRequest request) throws Exception;

}
