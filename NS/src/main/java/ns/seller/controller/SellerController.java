package ns.seller.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;
import ns.paging.SellerInfoListPaging;
import ns.paging.SellerReviewTotalListPaging;
import ns.seller.service.SellerService;

@Controller
public class SellerController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "sellerInfoListPaging")
	private SellerInfoListPaging sellerInfoListPaging;

	@Resource(name = "sellerService")
	private SellerService sellerService;

	@Resource(name = "sellerReviewTotalListPaging")
	private SellerReviewTotalListPaging sellerReviewTotalListPaging;

	// 판매자 정보 보기& 후기 리스트
	@RequestMapping(value = "/seller/info")
	public ModelAndView sellerInfo(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 판매자 상세보기 ######");
		ModelAndView mv = new ModelAndView("sellerInfo");

		int memNum = 0;

		/////////////////////////////// 페이징 /////////////////////////////////
		int pg = 1; // 현재 페이지 기본값 1
		if (commandMap.get("pg") != null && !commandMap.get("pg").equals("null")) {
			pg = Integer.parseInt((String) commandMap.get("pg")); // 현제 페이지 값이 넘어오면 설정
		}
		int pageSize = 8; // 한 페이지에 보여줄 게시글 수 정하기
		int pageBlock = 5; // 페이지 수 정하기

		int endNum = pg * pageSize; // 가져올 데이터의 끝 행 ${END}
		int startNum = endNum - pageSize + 1; // 가져올 데이터의 첫 행 ${START}

		commandMap.put("START", startNum);
		commandMap.put("END", endNum);

		// goodsTstatus
		// 총 개수를 가져오는 쿼리에는
		int totalList = sellerService.selectSellerGoodsCount(commandMap.getMap()); // 총 등록 상품 수

		// 페이징 클래스에 필요한 값을 넣어준다
		sellerInfoListPaging.setCurrentPage(pg);
		sellerInfoListPaging.setPageBlock(pageBlock);
		sellerInfoListPaging.setPageSize(pageSize);
		sellerInfoListPaging.setTotalList(totalList);

		String goodsTstatus = (String) commandMap.get("goodsTstatus");
		String sellerMemNum = (String) commandMap.get("MEM_NUM");
		String pgrStr = (String) commandMap.get("pgr");
		System.out.println("######################### sellerMemNum : " + sellerMemNum);

		// 69~70까지
		if (goodsTstatus != null) {
			sellerInfoListPaging.setGoodsTstatus(goodsTstatus);
		}

		if (sellerMemNum != null) {
			sellerInfoListPaging.setSellerMemNum(sellerMemNum);
		}

		if (pgrStr != null) {
			sellerInfoListPaging.setPgr(pgrStr);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		sellerInfoListPaging.makePagingHTML();
		mv.addObject("sellerInfoListPaging", sellerInfoListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		HttpSession session = request.getSession(false); // 추천버튼 추가한 부분
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		if (member != null) {
			mv.addObject("member", member);

			memNum = Integer.parseInt(String.valueOf(member.get("MEM_NUM")));
			commandMap.put("session_MEM_NUM", memNum);
			List<Map<String, Object>> recommendMap = sellerService.selectRecommend(commandMap.getMap());
			int isLike = 0; // 해당 회원이 추천한 회원이면 1, 아니면 0
			for (int i = 0; i < recommendMap.size(); i++) { // 로그인한 회원이 추천한 회원과 비교 후 결과 리턴
				int recommendMem = Integer.parseInt(String.valueOf(recommendMap.get(i).get("RECOMMEND_PARENT")));
				int memberNum = Integer.parseInt((String) commandMap.get("MEM_NUM"));

				System.out.println("###############recommendMem : " + recommendMem);
				System.out.println("###############memberNum : " + memberNum);

				if (recommendMem == memberNum) {
					isLike = 1;
					break;
				}
			}

			mv.addObject("isLike", isLike);
		} // 추천하기 추가 부분 끝

		Map<String, Object> recommendCountMap = sellerService.selectRecommendCount(commandMap.getMap());
		Map<String, Object> sellerInfo = sellerService.selectSellerInfo(commandMap.getMap());
		List<Map<String, Object>> seller = sellerService.selectSellerDetail(commandMap.getMap());

		Map<String, Object> memMap = new HashMap<>();
		memMap.put("MEM_NUM", memNum);
		List<Map<String, Object>> orders = sellerService.selectOrderPronum(memMap);

		List<Map<String, Object>> goodsNumList = sellerService.selectGoodsNum(commandMap.getMap());

		boolean canReview = false;
		Loop1: for (int i = 0; i < orders.size(); i++) {
			String ordersPronum = String.valueOf(orders.get(i).get("ORDERS_PRONUM"));
			Loop2: for (int j = 0; j < goodsNumList.size(); j++) {
				String goodsNum = String.valueOf(goodsNumList.get(j).get("GOODS_NUM"));
				System.out.println("############### ordersPronum : " + ordersPronum);
				System.out.println("############### goodsNum : " + goodsNum);
				if (ordersPronum.equals(goodsNum)) {
					canReview = true;
					break Loop1;
				}
			}
		}
		System.out.println("################################# boolean : " + canReview);
		mv.addObject("canReview", canReview);

		mv.addObject("seller", seller);
		mv.addObject("sellerInfo", sellerInfo);
		mv.addObject("memNum", memNum);
		mv.addObject("recommendCount", recommendCountMap);

		/////////////////////////////// 페이징 /////////////////////////////////
		int pgr = 1; // 현재 페이지 기본값 1
		if (commandMap.get("pgr") != null && !commandMap.get("pgr").equals("null")) {
			pgr = Integer.parseInt((String) commandMap.get("pgr")); // 현제 페이지 값이 넘어오면 설정
		}
		int pageSizer = 8; // 한 페이지에 보여줄 게시글 수 정하기
		int pageBlockr = 10; // 페이지 수 정하기

		int endNumr = pgr * pageSizer; // 가져올 데이터의 끝 행 ${END}
		int startNumr = endNumr - pageSizer + 1; // 가져올 데이터의 첫 행 ${START}

		commandMap.put("START", startNumr);
		commandMap.put("END", endNumr);

		// 총 개수를 가져오는 쿼리에는
		int totalListr = sellerService.selectReviewCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		sellerReviewTotalListPaging.setCurrentPage(pgr);
		sellerReviewTotalListPaging.setPageBlock(pageBlockr);
		sellerReviewTotalListPaging.setPageSize(pageSizer);
		sellerReviewTotalListPaging.setTotalList(totalListr);

		String pgStr = String.valueOf(pg);

		if (goodsTstatus != null) {
			sellerReviewTotalListPaging.setGoodsTstatus(goodsTstatus);
		}

		if (sellerMemNum != null) {
			sellerReviewTotalListPaging.setSellerMemNum(sellerMemNum);
		}

		if (pgStr != null) {
			sellerReviewTotalListPaging.setPg(pgStr);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		sellerReviewTotalListPaging.makePagingHTML();
		mv.addObject("sellerReviewTotalListPaging", sellerReviewTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> reviewList = sellerService.selectReviewList(commandMap.getMap());
		mv.addObject("reviewListMap", reviewList);

		return mv;
	}

	/*
	 * 판매자 추천하기
	 * 
	 * @RequestMapping(value = "/seller/recommend") public ModelAndView
	 * updateRecommend(CommandMap commandMap) throws Exception {
	 * log.debug("###### 판매자 추천하기 ######"); ModelAndView mv = new
	 * ModelAndView("redirect:/seller/info");
	 * 
	 * return mv; }
	 */

	@ResponseBody
	@RequestMapping(value = "/seller/recommend", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> Recommend(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 회원 추천하기 ######");
		sellerService.insertRecommend(map);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap = sellerService.selectRecommendCount(map);
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = "/seller/unRecommend", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> unRecommend(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 회원 추천취소 ######");
		sellerService.deleteRecommend(map);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap = sellerService.selectRecommendCount(map);
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = "/seller/recommendCount", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> recommendCount(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 뒤로가기 시 회원 추천수 가져오기 ######");

		Map<String, Object> resultMap = new HashMap<>();
		resultMap = sellerService.selectRecommendCount(map);
		return resultMap;
	}

	// 리뷰쓰기
	@ResponseBody
	@RequestMapping(value = "/seller/reviewWrite")
	public Map<String, Object> create(@RequestBody Map<String, Object> map, HttpServletRequest request)
			throws Exception {

		log.info("###################map: " + map);

		HttpSession session = request.getSession();
		Map<String, Object> member_num = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(member_num.get("MEM_NUM").toString());
		map.put("REVIEW_WRITER", session_mem_num);

		sellerService.insertReview(map);

		// 후기 한줄 가져오기
		Map<String, Object> resultMap = sellerService.selectReview(map);

		return resultMap;

	}

	// 후기 수정
	@ResponseBody
	@RequestMapping(value = "/seller/updateModifyReview", method = RequestMethod.POST)
	public Map<String, Object> updateModifyReview(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 후기 수정 ######");

		sellerService.updateModifyReview(map);

		Map<String, Object> modify = new HashMap<>();

		return modify;
	}

	// 후기 삭제
	@ResponseBody
	@RequestMapping(value = "/seller/deleteReview")
	public Map<String, Object> deleteReview(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 후기 삭제 ######");

		sellerService.deleteReview(map);

		Map<String, Object> delete = new HashMap<>();

		return delete;
	}
}
