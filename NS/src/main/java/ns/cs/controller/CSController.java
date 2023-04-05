package ns.cs.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;
import ns.cs.service.CSService;
import ns.paging.CsListPaging;

@Controller
public class CSController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "csService")
	private CSService csService;

	@Resource(name = "csListPaging")
	private CsListPaging csListPaging;

	@RequestMapping(value = "/myPage/csList")
	public ModelAndView csList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 마이페이지 고객센터 문의 내역 조회 ######");
		ModelAndView mv = new ModelAndView("csList");

		// 세션을 이거로 사용
		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int memNum = Integer.parseInt(String.valueOf(map.get("MEM_NUM")));

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
		int totalList = csService.selectAllCsCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		csListPaging.setCurrentPage(pg);
		csListPaging.setPageBlock(pageBlock);
		csListPaging.setPageSize(pageSize);
		csListPaging.setTotalList(totalList);

		// jsp에 삽입될 html을 생성하여 보낸다
		csListPaging.makePagingHTML();
		mv.addObject("csListPaging", csListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> csList = csService.selectCSList(commandMap.getMap());
		mv.addObject("csList", csList);

		// 게시글 총 개수, 현재페이지 번호, 페이지 사이즈 이용해서 게시판 넘버링시 사용할 변수 number 계산해서 넘겨주기
		int number = totalList - (pg - 1) * pageSize;
		mv.addObject("number", number);
		System.out.println("number 값 : " + number);

		return mv;
	}

	@RequestMapping(value = "/myPage/csWriteForm")
	public ModelAndView csWriteForm(CommandMap commandMap) throws Exception {
		log.debug("###### 마이페이지 고객센터 문의 작성 폼 ######");
		ModelAndView mv = new ModelAndView("csWriteForm");

		return mv;
	}

	@RequestMapping(value = "/myPage/csWrite")
	public @ResponseBody int csWrite(CommandMap commandMap, MultipartHttpServletRequest request) throws Exception {
		log.debug("###### 마이페이지 고객센터 문의 작성 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/csDetail");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int memNum = Integer.parseInt(String.valueOf(map.get("MEM_NUM")));
		commandMap.put("MEM_NUM", memNum);

		System.out.println(memNum);
		commandMap.put("boardType", 1);

		csService.insertCS(commandMap.getMap(), request);

		int csNum = Integer.parseInt(String.valueOf(commandMap.get("CS_NUM")));

		return csNum;
	}

	@RequestMapping(value = "/myPage/csDetail")
	public ModelAndView csDetail(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 마이페이지 고객센터 문의 상세보기 ######");
		ModelAndView mv = new ModelAndView("csDetail");

		Map<String, Object> csDetail = csService.selectCSDetail(commandMap.getMap());
		mv.addObject("csDetail", csDetail);

		Map<String, Object> csReplyDetail = csService.selectCSReplyDetail(commandMap.getMap());
		mv.addObject("csReplyDetail", csReplyDetail);

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		mv.addObject("map", map);

		System.out.println(map);
		// cs 파일 넣기 실패
		// List<Map<String, Object>> csFile =
		// csService.selectCSFile(commandMap.getMap());
		// mv.addObject("csFile", csFile);

		return mv;
	}

	/*
	 * //파일 보기
	 * 
	 * @RequestMapping(value = "/myPage/csDetail") public ModelAndView
	 * csFile(CommandMap commandMap, MultipartHttpServletRequest request) throws
	 * Exception{ log.debug("###### 마이페이지 고객센터 파일 보기 ######"); ModelAndView mv = new
	 * ModelAndView("csFile");
	 * 
	 * List<Map<String, Object>> csFile =
	 * csService.selectCSFile(commandMap.getMap()); mv.addObject("csFile", csFile);
	 * 
	 * return mv; }
	 */

	@RequestMapping(value = "/myPage/csDelete")
	public ModelAndView csDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 마이페이지 고객센터 문의 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/csList");

		csService.deleteCS(commandMap.getMap());
		csService.deleteCSFile(commandMap.getMap());
		csService.deleteCSReply(commandMap.getMap());

		return mv;
	}

}
