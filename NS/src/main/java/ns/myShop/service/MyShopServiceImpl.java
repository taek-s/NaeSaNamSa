package ns.myShop.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import ns.myShop.dao.MyShopDAO;

@Service("myShopService")
public class MyShopServiceImpl implements MyShopService {

	@Resource(name = "myShopDAO")
	private MyShopDAO myShopDAO;

	// 내가 등록한 상품 리스트 조회(상품정보 및 찜개수). 페이징
	@Override
	public List<Map<String, Object>> selectGoodsList(Map<String, Object> map) throws Exception {

		return myShopDAO.selectGoodsList(map);
	}

	// 내가 등록한 상품 총 개수 조회. 페이징O
	public int selectMyGoodsCount(Map<String, Object> map) throws Exception {

		return myShopDAO.selectMyGoodsCount(map);
	}

	// 주문 내역 리스트 조회. 페이징O
	@Override
	public List<Map<String, Object>> selectOrderList(Map<String, Object> map) throws Exception {

		return myShopDAO.selectOrderList(map);
	}

	// 내 주문 상품 총 개수
	@Override
	public int selectMyOrderTotalCount(Map<String, Object> map) throws Exception {

		return myShopDAO.selectMyOrderTotalCount(map);
	}

	// 판매 내역 리스트 조회. 페이징O
	@Override
	public List<Map<String, Object>> selectSellList(Map<String, Object> map) throws Exception {

		return myShopDAO.selectSellList(map);
	}

	// 내 판매 상품 총 개수
	@Override
	public int selectMySellTotalCount(Map<String, Object> map) throws Exception {

		return myShopDAO.selectMySellTotalCount(map);
	}

	// 찜 목록 조회. 페이징O
	@Override
	public List<Map<String, Object>> selectGoodsLikeList(Map<String, Object> map) throws Exception {

		return myShopDAO.selectGoodsLikeList(map);
	}

	// 내 찜 상품 총 개수
	@Override
	public int selectMyGoodsLikeTotalCount(Map<String, Object> map) throws Exception {

		return myShopDAO.selectMyGoodsLikeTotalCount(map);
	}

	// 최근 본 상품 조회. 페이징X(최근 본 상품 몇개만. 2*4개)
	@Override
	public Map<String, Object> selectRecentGoodsList(Map<String, Object> map) throws Exception {

		return myShopDAO.selectRecentGoodsList(map);
	}

	// 세션에 올라간 로그인 정보중 회원번호 리턴(다른 정보 필요할시 추가로 작성해도됨)
	@Override
	public int memberInfo(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int memNum = Integer.parseInt(member.get("MEM_NUM").toString());

		return memNum;
	}

}
