package ns.seller.service;

import java.util.List;
import java.util.Map;

public interface SellerService {

	List<Map<String, Object>> selectSellerDetail(Map<String, Object> map) throws Exception;

	// 판매자 정보 상세보기, 리뷰 보기
	List<Map<String, Object>> selectReviewList(Map<String, Object> map) throws Exception;

	// 판매자 추천하기
	void insertRecommend(Map<String, Object> map) throws Exception;

	// 판매자 추천 취소
	void deleteRecommend(Map<String, Object> map) throws Exception;

	// 판매자 후기 작성
	void insertReview(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectRecommend(Map<String, Object> map) throws Exception;

	// 추천수 카운트
	Map<String, Object> selectRecommendCount(Map<String, Object> map) throws Exception;

	// 후기 리스트
	int selectReviewCount(Map<String, Object> map) throws Exception;

	// 후기 한줄 가져오기
	Map<String, Object> selectReview(Map<String, Object> map) throws Exception;

	// 회원이 등록한 상품 리스트 조회(상품정보 및 찜개수). 페이징O - selectList() -> 추후 페이징 어떻게 할건지에 따라 수정
	List<Map<String, Object>> selectSellerGoodsList(Map<String, Object> map) throws Exception;

	// 회원이 등록한 상품 총 개수 조회. 페이징O
	int selectSellerGoodsCount(Map<String, Object> map) throws Exception;

	Map<String, Object> selectSellerInfo(Map<String, Object> map) throws Exception;

	// 후기 삭제
	void deleteReview(Map<String, Object> map) throws Exception;

	// 후기 수정
	void updateModifyReview(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectOrderPronum(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectGoodsNum(Map<String, Object> map) throws Exception;
}
