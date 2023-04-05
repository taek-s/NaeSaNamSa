package ns.shop.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import ns.common.common.CommandMap;
import ns.paging.GoodsTotalListPaging;
import ns.shop.service.ShopService;

@Controller
public class ShopController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "shopService")
	private ShopService shopService;

	@Resource(name = "goodsTotalListPaging")
	private GoodsTotalListPaging goodsTotalListPaging;

	@SuppressWarnings("unused")
	@RequestMapping(value = "/shop/totalList")
	public ModelAndView shopTotalList(CommandMap commandMap) throws Exception {
		log.debug("###### 상품 전체 리스트 ######");
		ModelAndView mv = new ModelAndView("goodsTotalList");

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

		// 검색어, 조건 등 추가 파라미터
		String categoryType = (String) commandMap.get("categoryType");
		String keyword = "";
		if (commandMap.get("keyword") != null) { // 키워드가 있으면 값으로 지정
			keyword = (String) commandMap.get("keyword");
		}
		String priceType = (String) commandMap.get("priceType");
		String tstatusType = (String) commandMap.get("tstatusType");

		// 총 개수를 가져오는 쿼리에는
		int totalList = shopService.selectAllGoodsCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		goodsTotalListPaging.setCurrentPage(pg);
		goodsTotalListPaging.setPageBlock(pageBlock);
		goodsTotalListPaging.setPageSize(pageSize);
		goodsTotalListPaging.setTotalList(totalList);

		if (categoryType != null) {
			goodsTotalListPaging.setCategoryType(categoryType);
		}

		if (keyword != null) {
			goodsTotalListPaging.setKeyword(keyword);
		}

		if (priceType != null) {
			goodsTotalListPaging.setPriceType(priceType);
		}

		if (tstatusType != null) {
			goodsTotalListPaging.setTstatusType(tstatusType);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		goodsTotalListPaging.makePagingHTML();
		mv.addObject("goodsTotalListPaging", goodsTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> list = shopService.selectAllGoodsList(commandMap.getMap());
		mv.addObject("list", list);

		return mv;
	}

	@RequestMapping(value = "/shop/goodsWriteForm")
	public ModelAndView goodsWriteForm(CommandMap commandMap) throws Exception {
		log.debug("###### 상품 등록 폼 ######");
		ModelAndView mv = new ModelAndView("goodsWriteForm");

		return mv;
	}

	@RequestMapping(value = "/shop/goodsWrite", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsWrite(CommandMap commandMap, MultipartHttpServletRequest request)
			throws Exception {
		log.debug("###### 상품 등록 ######");

		int goodsNum = shopService.insertGoods(commandMap.getMap(), request);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("GOODS_NUM", goodsNum);
		map.put("code", "OK");

		return map;
	}

	@RequestMapping(value = "/shop/display", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName, HttpServletRequest request) throws Exception {
		ResponseEntity<byte[]> result = null;
		log.debug("############### fileName : " + fileName);
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		File file = new File(filePath_temp + fileName);

		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/shop/modifyDisplay", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public @ResponseBody List<Map<String, Object>> modifyDisplay(HttpServletRequest request) throws Exception {

		String jsonParam = request.getParameter("json").replaceAll("&quot;", "\"");
		JSONParser jsonParser = new JSONParser();
		Object jsonObj = jsonParser.parse(jsonParam);
		JSONArray jsonArray = (JSONArray) jsonObj;
		List<Map<String, Object>> list = new ArrayList<>();
		for (int i = 0; i < jsonArray.size(); i++) {
			// Gson을 통해서 각각의 값들을 객체에 매핑 시켜준다
			Map<String, Object> obj = new Gson().fromJson(jsonArray.get(i).toString(), Map.class);
			list.add(obj);
		}

		List<Map<String, Object>> resultList = new ArrayList<>();
		Map<String, Object> returnMap = null;
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		String fileName = null;
		String fileExtension = null;
		String fileOrgName = null;
		double fileNum = 0;
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> imgMap = list.get(i);
			fileName = (String) imgMap.get("GOODS_IMAGE_STD");
			fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
			fileOrgName = (String) imgMap.get("GOODS_IMAGE_ORG");
			fileNum = (double) imgMap.get("GOODS_IMAGE_NUM");
			File file = new File(filePath_temp + fileName);

			returnMap = new HashMap<>();
			if (file.exists()) {
				returnMap.put("exist", true);
				returnMap.put("fileExtension", fileExtension);
				returnMap.put("filename", fileOrgName);
				returnMap.put("fileNum", fileNum);
				returnMap.put("blob", FileCopyUtils.copyToByteArray(file));
			} else {
				returnMap.put("exist", false);
			}
			resultList.add(returnMap);
		}
		return resultList;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/shop/goodsDetail")
	public ModelAndView goodsDetail(CommandMap commandMap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		log.debug("###### 상품 상세보기 ######");
		ModelAndView mv = new ModelAndView("goodsDetail");

		HttpSession session = request.getSession(false);
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");

		if (member != null) {
			mv.addObject("member", member);

			int memNum = Integer.parseInt(String.valueOf(member.get("MEM_NUM")));
			commandMap.put("session_MEM_NUM", memNum);
			List<Map<String, Object>> goodsLikeMap = shopService.selectGoodsLike(commandMap.getMap());
			int isLike = 0; // 해당 상품이 찜한 상품이면 1, 아니면 0
			for (int i = 0; i < goodsLikeMap.size(); i++) { // 로그인한 회원이 찜한 상품번호를 가져와서 해당 상품과 비교 후 결과 리턴
				int likeGoods = Integer.parseInt(String.valueOf(goodsLikeMap.get(i).get("GOODS_LIKE_PARENT")));
				int goodsNum = Integer.parseInt((String) commandMap.get("GOODS_NUM"));
				if (likeGoods == goodsNum) {
					isLike = 1;
					break;
				}
			}
			mv.addObject("isLike", isLike);
		}

		Map<String, Object> goodsDetailMap = shopService.selectGoodsDetail(commandMap.getMap());
		List<Map<String, Object>> goodsImgMap = shopService.selectGoodsImage(commandMap.getMap());
		if (goodsImgMap != null) {
			goodsImgMap.remove(0); // 썸네일을 제외한다
		}
		Map<String, Object> goodsLikeCountMap = shopService.selectGoodsLikeCount(commandMap.getMap());

		mv.addObject("GOODS", goodsDetailMap); // 상품과 썸네일, 판매자 정보
		mv.addObject("GOODSIMG", goodsImgMap); // 상품의 썸네일 외 이미지 정보
		mv.addObject("GOODSLIKE", goodsLikeCountMap); // 상품의 찜하기 수

		// (String) commandMap.get("GOODS_NUM")
		// 상품 상세 페이지로 접속 시, 쿠키 생성
		log.debug("###### 쿠키 생성 ######");

		String goodsNum = (String) commandMap.get("GOODS_NUM");
		Cookie cookie = null;

		Cookie[] cookies = request.getCookies();
		// log.debug("쿠키 : " + cookies.length);
		for (Cookie c : cookies) {
			if (c.getName().equals("recentGoods_" + goodsNum)) { // 쿠키 이름중에 동일한 쿠키 이름이 있을경우
				// System.out.println("#######################"+c.getValue());

				// 쿠키 삭제(유효시간 0으로 설정). 쿠키 값 새로 들어가도록 하기위함
				c.setMaxAge(0);
				c.setDomain("localhost");
				c.setPath("/");
				response.addCookie(c);

				// System.out.println("#######################"+c.getValue());
				break;
			}
		}
		// log.debug("쿠키 : " + cookies.length);

		// 상품 상세보기 들어갈 때마다 쿠키 생성하기 위해, 쿠키 이름뒤에 goodsNum 붙이기
		cookie = new Cookie("recentGoods_" + goodsNum, goodsNum);
		log.debug("쿠키 : " + (String) commandMap.get("GOODS_NUM"));

		// 쿠키 이름 및 값 확인
		log.debug(cookie.getName());
		log.debug(cookie.getValue());

		cookie.setMaxAge(60 * 60 * 24); // 24시간(1일)동안 쿠키 저장 (일단 테스트 위해서 30으로 지정하고, 추후 60*60*24로 변경)
		cookie.setDomain("localhost");
		cookie.setPath("/");
		response.addCookie(cookie); // 응답 헤더에 쿠키 추가

		Cookie countCookie = null;

		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌
				if (cookies[i].getName().equals("count_" + goodsNum)) {
					countCookie = cookies[i];
				}
			}
		}

		if (countCookie == null) {
			// 쿠키 생성(이름, 값)
			Cookie newCookie = new Cookie("count_" + goodsNum, "|" + goodsNum + "|");

			// 쿠키 추가
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);

			// 쿠키를 추가 시키고 조회수 증가시킴
			shopService.updateHitCnt(commandMap.getMap());
		}

		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/shop/goodsModifyForm", method = RequestMethod.POST)
	public ModelAndView goodsModifyForm(CommandMap commandMap) throws Exception {
		log.debug("###### 상품 수정 폼 ######");
		ModelAndView mv = new ModelAndView("goodsModifyForm");
		Map<String, Object> goodsDetailMap = shopService.selectGoodsDetail(commandMap.getMap());
		List<Map<String, Object>> goodsImgMap = shopService.selectGoodsImage(commandMap.getMap());
		mv.addObject("GOODS", goodsDetailMap);
		mv.addObject("GOODSIMG", goodsImgMap);

		JSONArray jsonArray = new JSONArray();
		for (Map<String, Object> map : goodsImgMap) {
			JSONObject json = new JSONObject();

			for (Map.Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				json.put(key, value);
			}
			jsonArray.add(json);
		}
		mv.addObject("imgJson", jsonArray);

		return mv;
	}

	@RequestMapping(value = "/shop/goodsModify", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsModify(CommandMap commandMap, MultipartHttpServletRequest request)
			throws Exception {
		log.debug("###### 상품 수정 ######");

		shopService.updateGoodsModify(commandMap.getMap(), request);

		int goodsNum = (int) commandMap.get("GOODS_NUM");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("GOODS_NUM", goodsNum);
		map.put("code", "OK");

		return map;
	}

	@RequestMapping(value = "/shop/goodsDelete")
	public ModelAndView goodsDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 상품 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/myShop");

		shopService.deleteGoods(commandMap.getMap());

		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/shop/goodsDetail/goodsLike")
	public Map<String, Object> goodsLike(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 상품 찜하기 ######");
		shopService.insertGoodsLike(map);
		map.put("GOODS_NUM", map.get("LIKE_GOODS_NUM"));
		Map<String, Object> goodsLikeCountMap = shopService.selectGoodsLikeCount(map);
		int count = Integer.parseInt(String.valueOf(goodsLikeCountMap.get("GOODS_LIKE_COUNT")));

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("count", count);
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = "/shop/goodsDetail/goodsUnlike")
	public Map<String, Object> goodsUnlike(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 상품 찜취소 ######");
		shopService.deleteGoodsLike(map);
		map.put("GOODS_NUM", map.get("LIKE_GOODS_NUM"));
		Map<String, Object> goodsLikeCountMap = shopService.selectGoodsLikeCount(map);
		int count = Integer.parseInt(String.valueOf(goodsLikeCountMap.get("GOODS_LIKE_COUNT")));

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("count", count);
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = "/shop/goodsDetail/goodslikeCount")
	public Map<String, Object> goodslikeCount(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 뒤로가기 시 상품 찜 수 가져오기 ######");
		map.put("GOODS_NUM", map.get("LIKE_GOODS_NUM"));
		Map<String, Object> goodsLikeCountMap = shopService.selectGoodsLikeCount(map);
		int count = Integer.parseInt(String.valueOf(goodsLikeCountMap.get("GOODS_LIKE_COUNT")));

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("count", count);
		return resultMap;
	}
}
