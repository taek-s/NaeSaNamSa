package ns.seller.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("sellerDAO")
public class SellerDAO extends AbstractDAO {

	// 판매자 정보 상세보기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSellerDetail(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("seller.selectSellerDetail", map);
	}

	// 판매자 정보 상세보기, 리뷰 보기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReviewList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("seller.selectReviewList", map);
	}

	// 판매자 추천하기
	public void insertRecommend(Map<String, Object> map) throws Exception {
		update("seller.insertRecommend", map);
	}

	public void deleteRecommend(Map<String, Object> map) throws Exception {
		update("seller.deleteRecommend", map);
	}

	// 판매자 후기 작성
	public void insertReview(Map<String, Object> map) throws Exception {
		System.out.println("insertReview 파라미터 : " + map);

		insert("seller.insertReview", map);
	}

	// 후기 리스트
	public int selectReviewCount(Map<String, Object> map) throws Exception {
		System.out.println("reviewCount 파라미터 : " + map);
		return (int) selectOne("seller.selectReviewCount", map);
	}

	// 후기 한 줄 데이터 가져오기
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReview(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("seller.selectReview", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRecommend(Map<String, Object> map) throws Exception {
		return selectList("seller.selectRecommend", map);
	}

	// 추천수 카운트
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectRecommendCount(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("seller.selectRecommendCount", map);
	}

	// 판매자 정보
	// 내가 등록한 상품 리스트 조회(상품정보 및 찜개수). 페이징O - selectList() -> 추후 페이징 어떻게 할건지에 따라 수정
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSellerGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("selectSellerGoodsList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("seller.selectSellerGoodsList", map);
	}

	// 등록한 상품 총 개수 조회. 페이징O
	public int selectSellerGoodsCount(Map<String, Object> map) throws Exception {
		System.out.println("selectSellerGoodsCount 파라미터 : " + map);

		return (int) selectOne("seller.selectSellerGoodsCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSellerInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("seller.selectSellerInfo", map);
	}

	// 후기 삭제
	public void deleteReview(Map<String, Object> map) throws Exception {
		delete("seller.deleteReview", map);
	}

	// 후기 수정
	public void updateModifyReview(Map<String, Object> map) throws Exception {
		update("seller.updateModifyReview", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOrderPronum(Map<String, Object> map) throws Exception {
		return selectList("seller.selectOrderPronum", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsNum(Map<String, Object> map) throws Exception {
		return selectList("seller.selectGoodsNum", map);
	}
}
