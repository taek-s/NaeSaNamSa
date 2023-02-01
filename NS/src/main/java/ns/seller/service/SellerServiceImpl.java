package ns.seller.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.seller.dao.SellerDAO;

@Service("sellerService")
public class SellerServiceImpl implements SellerService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "sellerDAO")
	private SellerDAO sellerDAO;

	@Override
	// 판매자 정보 상세보기
	public List<Map<String, Object>> selectSellerDetail(Map<String, Object> map) throws Exception {
		return sellerDAO.selectSellerDetail(map);
	}

	@Override
	// 판매자 정보 상세보기, 리뷰 보기
	public List<Map<String, Object>> selectReviewList(Map<String, Object> map) throws Exception {
		return sellerDAO.selectReviewList(map);
	}

	// 판매자 추천하기
	@Override
	public void insertRecommend(Map<String, Object> map) throws Exception {
		sellerDAO.insertRecommend(map);
	}

	// 판매자 추천 취소
	@Override
	public void deleteRecommend(Map<String, Object> map) throws Exception {
		sellerDAO.deleteRecommend(map);
	}

	// 판매자 후기 작성
	@Override
	public void insertReview(Map<String, Object> map) throws Exception {
		sellerDAO.insertReview(map);
	}

	@Override
	public List<Map<String, Object>> selectRecommend(Map<String, Object> map) throws Exception {
		return sellerDAO.selectRecommend(map);
	}

	// 추천수 카운트
	@Override
	public Map<String, Object> selectRecommendCount(Map<String, Object> map) throws Exception {
		return sellerDAO.selectRecommendCount(map);
	}

	// 후기 페이징위한 카운트
	@Override
	public int selectReviewCount(Map<String, Object> map) throws Exception {

		return sellerDAO.selectReviewCount(map);
	}

	// 후기 한줄 가져오기
	@Override
	public Map<String, Object> selectReview(Map<String, Object> map) throws Exception {

		return sellerDAO.selectReview(map);
	}

	// 회원이 등록한 상품 리스트 조회(상품정보 및 찜개수). 페이징O - selectList() -> 추후 페이징 어떻게 할건지에 따라 수정
	@Override
	public List<Map<String, Object>> selectSellerGoodsList(Map<String, Object> map) throws Exception {
		return sellerDAO.selectSellerGoodsList(map);
	}

	// 등록한 상품 총 개수 조회. 페이징O
	@Override
	public int selectSellerGoodsCount(Map<String, Object> map) throws Exception {
		return sellerDAO.selectSellerGoodsCount(map);
	}

	@Override
	public Map<String, Object> selectSellerInfo(Map<String, Object> map) throws Exception {
		return sellerDAO.selectSellerInfo(map);
	}

	// 후기 삭제
	@Override
	public void deleteReview(Map<String, Object> map) throws Exception {
		sellerDAO.deleteReview(map);

	}

	// 후기 수정
	@Override
	public void updateModifyReview(Map<String, Object> map) throws Exception {
		sellerDAO.updateModifyReview(map);
	}

	@Override
	public List<Map<String, Object>> selectOrderPronum(Map<String, Object> map) throws Exception {
		return sellerDAO.selectOrderPronum(map);
	}

	@Override
	public List<Map<String, Object>> selectGoodsNum(Map<String, Object> map) throws Exception {
		return sellerDAO.selectGoodsNum(map);
	}

}
