package ns.myShop.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;
import ns.myShop.service.MyShopService;
import ns.paging.MyGoodsLikeTotalListPaging;
import ns.paging.MyGoodsTotalListPaging;
import ns.paging.MyOrderTotalListPaging;
import ns.paging.MySellTotalListPaging;

@Controller
public class MyShopController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "myShopService")
	private MyShopService myShopService;

	@Resource(name = "myGoodsTotalListPaging")
	private MyGoodsTotalListPaging myGoodsTotalListPaging;

	@Resource(name = "myOrderTotalListPaging")
	private MyOrderTotalListPaging myOrderTotalListPaging;

	@Resource(name = "mySellTotalListPaging")
	private MySellTotalListPaging mySellTotalListPaging;

	@Resource(name = "myGoodsLikeTotalListPaging")
	private MyGoodsLikeTotalListPaging myGoodsLikeTotalListPaging;

	@RequestMapping(value = "/myShop")
	public ModelAndView myShopMain(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 내상점 상품관리 ######");
		ModelAndView mv = new ModelAndView("myShopMain");

		// 세션에 올린 회원번호
		int memNum = myShopService.memberInfo(request);
		commandMap.put("MEM_NUM", memNum);

		/////////////////////////////// 페이징 /////////////////////////////////
		int pg = 1; // 현재 페이지 기본값 1
		if (commandMap.get("pg") != null) {
			pg = Integer.parseInt((String) commandMap.get("pg")); // 현제 페이지 값이 넘어오면 설정
		}
		int pageSize = 5; // 한 페이지에 보여줄 게시글 수 정하기
		int pageBlock = 10; // 페이지 수 정하기

		int endNum = pg * pageSize; // 가져올 데이터의 끝 행 ${END}
		int startNum = endNum - pageSize + 1; // 가져올 데이터의 첫 행 ${START}

		commandMap.put("START", startNum);
		commandMap.put("END", endNum);

		// 총 개수를 가져오는 쿼리에는
		int totalList = myShopService.selectMyGoodsCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		myGoodsTotalListPaging.setCurrentPage(pg);
		myGoodsTotalListPaging.setPageBlock(pageBlock);
		myGoodsTotalListPaging.setPageSize(pageSize);
		myGoodsTotalListPaging.setTotalList(totalList);

		String goodsTstatus = (String) commandMap.get("goodsTstatus");
		String keyword = "";

		if (commandMap.get("keyword") != null) {
			keyword = (String) commandMap.get("keyword");
		}

		if (goodsTstatus != null) {
			myGoodsTotalListPaging.setGoodsTstatus(goodsTstatus);
		}

		if (keyword != null) {
			myGoodsTotalListPaging.setKeyword(keyword);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		myGoodsTotalListPaging.makePagingHTML();
		mv.addObject("myGoodsTotalListPaging", myGoodsTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		// selectGoodsList에 Map객체 넣어서 내 상품 리스트 리턴하고, main.jsp에서 쓸 수 있게 올려주기
		List<Map<String, Object>> goodsList = myShopService.selectGoodsList(commandMap.getMap());
		mv.addObject("goodsList", goodsList);

		return mv;
	}

	@RequestMapping(value = "/myShop/orderHistory")
	public ModelAndView myShopOrderHistory(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 내상점 주문 내역 조회 ######");
		ModelAndView mv = new ModelAndView("myShopOrderHistory");

		// 세션에 올린 회원번호
		int memNum = myShopService.memberInfo(request);
		commandMap.put("MEM_NUM", memNum);

		/////////////////////////////// 페이징 /////////////////////////////////
		int pg = 1; // 현재 페이지 기본값 1
		if (commandMap.get("pg") != null) {
			pg = Integer.parseInt((String) commandMap.get("pg")); // 현제 페이지 값이 넘어오면 설정
		}
		int pageSize = 10; // 한 페이지에 보여줄 게시글 수 정하기
		int pageBlock = 10; // 페이지 수 정하기

		int endNum = pg * pageSize; // 가져올 데이터의 끝 행 ${END}
		int startNum = endNum - pageSize + 1; // 가져올 데이터의 첫 행 ${START}

		commandMap.put("START", startNum);
		commandMap.put("END", endNum);

		// 총 개수를 가져오는 쿼리에는
		int totalList = myShopService.selectMyOrderTotalCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		myOrderTotalListPaging.setCurrentPage(pg);
		myOrderTotalListPaging.setPageBlock(pageBlock);
		myOrderTotalListPaging.setPageSize(pageSize);
		myOrderTotalListPaging.setTotalList(totalList);

		// jsp에 삽입될 html을 생성하여 보낸다
		myOrderTotalListPaging.makePagingHTML();
		mv.addObject("myOrderTotalListPaging", myOrderTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		// selectOrderList에 Map 객체 넣어서 주문 내역 리스트 리턴하고, orderHistory.jsp에서 사용할 수 있게
		// orderList 올려주기
		List<Map<String, Object>> orderList = myShopService.selectOrderList(commandMap.getMap());
		mv.addObject("orderList", orderList);

		return mv;
	}

	@RequestMapping(value = "/myShop/sellHistory")
	public ModelAndView myShopSellHistory(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 내상점 판매 내역 조회 ######");
		ModelAndView mv = new ModelAndView("myShopSellHistory");

		// 세션에 올린 회원번호
		int memNum = myShopService.memberInfo(request);
		commandMap.put("MEM_NUM", memNum);

		/////////////////////////////// 페이징 /////////////////////////////////
		int pg = 1; // 현재 페이지 기본값 1
		if (commandMap.get("pg") != null) {
			pg = Integer.parseInt((String) commandMap.get("pg")); // 현제 페이지 값이 넘어오면 설정
		}
		int pageSize = 10; // 한 페이지에 보여줄 게시글 수 정하기
		int pageBlock = 10; // 페이지 수 정하기

		int endNum = pg * pageSize; // 가져올 데이터의 끝 행 ${END}
		int startNum = endNum - pageSize + 1; // 가져올 데이터의 첫 행 ${START}

		commandMap.put("START", startNum);
		commandMap.put("END", endNum);

		// 총 개수를 가져오는 쿼리에는
		int totalList = myShopService.selectMySellTotalCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		mySellTotalListPaging.setCurrentPage(pg);
		mySellTotalListPaging.setPageBlock(pageBlock);
		mySellTotalListPaging.setPageSize(pageSize);
		mySellTotalListPaging.setTotalList(totalList);

		// jsp에 삽입될 html을 생성하여 보낸다
		mySellTotalListPaging.makePagingHTML();
		mv.addObject("mySellTotalListPaging", mySellTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		// selectOrderList에 Map 객체 넣어서 주문/판매 내역 리스트 리턴하고, history.jsp에서 사용할 수 있게
		// orderList 올려주기
		List<Map<String, Object>> sellList = myShopService.selectSellList(commandMap.getMap());
		mv.addObject("sellList", sellList);

		return mv;
	}

	@RequestMapping(value = "/myShop/goodsLikeList")
	public ModelAndView myShopGoodsLikeList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 내상점 찜목록 ######");
		ModelAndView mv = new ModelAndView("myShopGoodsLikeList");

		// 세션에 올린 회원번호
		int memNum = myShopService.memberInfo(request);
		commandMap.put("MEM_NUM", memNum);

		/////////////////////////////// 페이징 /////////////////////////////////
		int pg = 1; // 현재 페이지 기본값 1
		if (commandMap.get("pg") != null) {
			pg = Integer.parseInt((String) commandMap.get("pg")); // 현제 페이지 값이 넘어오면 설정
		}
		int pageSize = 8; // 한 페이지에 보여줄 게시글 수 정하기
		int pageBlock = 10; // 페이지 수 정하기

		int endNum = pg * pageSize; // 가져올 데이터의 끝 행 ${END}
		int startNum = endNum - pageSize + 1; // 가져올 데이터의 첫 행 ${START}

		commandMap.put("START", startNum);
		commandMap.put("END", endNum);

		// 총 개수를 가져오는 쿼리에는
		int totalList = myShopService.selectMyGoodsLikeTotalCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		myGoodsLikeTotalListPaging.setCurrentPage(pg);
		myGoodsLikeTotalListPaging.setPageBlock(pageBlock);
		myGoodsLikeTotalListPaging.setPageSize(pageSize);
		myGoodsLikeTotalListPaging.setTotalList(totalList);

		// jsp에 삽입될 html을 생성하여 보낸다
		myGoodsLikeTotalListPaging.makePagingHTML();
		mv.addObject("myGoodsLikeTotalListPaging", myGoodsLikeTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> likeList = myShopService.selectGoodsLikeList(commandMap.getMap());

		mv.addObject("likeList", likeList);

		return mv;
	}

	@RequestMapping(value = "/myShop/recentGoodsList")
	public ModelAndView myShopRecentGoodsList(CommandMap commandMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.debug("###### 내상점 최근 본 상품 ######");
		ModelAndView mv = new ModelAndView("myShopRecentGoodsList");

		// 세션에 올린 회원번호
		int memNum = myShopService.memberInfo(request);
		commandMap.put("MEM_NUM", memNum);

		// 쿠키 읽기
		Cookie[] cookies = request.getCookies();
		log.debug("쿠키 : " + cookies);

		List<String> values = new ArrayList<String>(); // 쿠키 값 저장할 리스트 선언
		List<String> names = new ArrayList<String>(); // 쿠키 이름 저장할 리스트 선언

		if (cookies != null) { // 쿠키가 있을경우, 쿠키 이름과 값
			for (Cookie cookie : cookies) {
				if (!cookie.getName().equals("JSESSIONID") && !cookie.getName().equals("pwCookie")
						&& !cookie.getName().equals("emailCookie")) { // 쿠키 이름이 JSESSIONID가 아닐경우
					log.debug("##쿠키 이름 : " + cookie.getName());
					values.add(cookie.getValue()); // 쿠키 값을 values에 저장 (=GOODS_NUM값)
				}
			}
		} else { // 쿠키가 없을경우 (기본으로 JSESSIONID 쿠키가 있어서 else가 실행될 일은 없을 듯. JSESSIONID : 톰캣이 기본적으로
					// 제공하는 세션 관련 쿠키)
			log.debug("cookie is null");
		}

		log.debug("쿠키 전체 값 : " + values); // 리스트에 들어있는 쿠키 전체 값 출력해서 확인

		// 최근 본 상품 조회해서 리스트로 담아줄 List 객체 생성 (리스트에 최대 8개 담을거임)
		List<Map<String, Object>> recentList = new ArrayList<>();

		// 쿠키 시간이 아직 유효하면 (즉, 쿠키 값이 있으면)
		if (values != null) {
			log.debug("쿠키 길이  " + values.size());

			// 쿠키 개수가 9개 이상일경우
			if (values.size() > 8) {
				for (int i = values.size() - 1; i >= values.size() - 8; i--) { // Ex, 쿠키가 9개 있으면, 8번째 쿠키 값부터 1번 쿠키값까지
																				// 가져오도록 반복문 실행
					String value = values.get(i);

					// 가져온 쿠키 값인 GOODS_NUM을 commandMap에 넣어주고, 그걸 selectRecentGoodsList()에 넣어서 Map객체
					// 리턴
					commandMap.put("RECENT_SAW_LIST", value);
					Map<String, Object> recentMap = myShopService.selectRecentGoodsList(commandMap.getMap());
					String del = (String) recentMap.get("GOODS_DEL_GB");

					// 상품이 삭제되지 않았을 경우에만 recentList에 추가
					if (del.equals("N")) {
						recentList.add(recentMap);
					}
				}
			} else { // 쿠키 개수가 8개 이하일경우
				for (int i = values.size() - 1; i >= 0; i--) {
					String value = values.get(i);
					commandMap.put("RECENT_SAW_LIST", value);

					Map<String, Object> recentMap = myShopService.selectRecentGoodsList(commandMap.getMap());
					String del = (String) recentMap.get("GOODS_DEL_GB");

					if (del.equals("N")) {
						recentList.add(recentMap);
					}
				}
			}

			mv.addObject("recentList", recentList);
		}

		// 쿠키 시간이 다 끝나서 쿠키 값이 null일경우
		String noRecentGoods = "최근 본 상품이 없습니다";
		mv.addObject("noRecentGoods", noRecentGoods);

		return mv;
	}
}
