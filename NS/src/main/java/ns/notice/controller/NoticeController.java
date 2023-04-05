package ns.notice.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;
import ns.notice.service.NoticeService;
import ns.paging.NoticeTotalListPaging;

@Controller
public class NoticeController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "noticeService")
	private NoticeService noticeService;

	@Resource(name = "noticeTotalListPaging")
	private NoticeTotalListPaging noticeTotalListPaging;

	@RequestMapping(value = "/help/noticeList")
	public ModelAndView noticeList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 고객센터 공지사항 리스트 조회 ######");
		ModelAndView mv = new ModelAndView("noticeList");

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

		// 검색어, 조건 등 추가 파라미터
		String searchType = (String) commandMap.get("searchType");
		String keyword = "";
		if (commandMap.get("keyword") != null) { // 키워드가 있으면 값으로 지정
			keyword = (String) commandMap.get("keyword");
		}

		// 총 개수를 가져오는 쿼리에는
		int totalList = noticeService.selectTotalNoticeListCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		noticeTotalListPaging.setCurrentPage(pg);
		noticeTotalListPaging.setPageBlock(pageBlock);
		noticeTotalListPaging.setPageSize(pageSize);
		noticeTotalListPaging.setTotalList(totalList);

		if (searchType != null) {
			noticeTotalListPaging.setSearchType(searchType);
		}

		if (keyword != null) {
			noticeTotalListPaging.setKeyword(keyword);
		}

		mv.addObject("searchType", searchType);
		mv.addObject("keyword", keyword);

		// jsp에 삽입될 html을 생성하여 보낸다
		noticeTotalListPaging.makePagingHTML();
		mv.addObject("noticeTotalListPaging", noticeTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		// 공지사항 리스트 목록 리턴해서 mv에 올리기
		List<Map<String, Object>> noticeList = noticeService.selectNoticeList(commandMap.getMap());
		mv.addObject("noticeList", noticeList);

		// 세션 객체에서 멤버정보 담긴 map가져와서, MEM_ADMIN만 따로 빼서 noticeList.jsp로 올리기
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		String memAdmin = (String) member.get("MEM_ADMIN");

		// session_MEM_INFO랑 memAdmin값 출력해서 확인 (나중에 삭제해도됨)
		System.out.println("session_MEM_INFO : " + member);
		System.out.println("memAdmin : " + memAdmin);

		mv.addObject("MEM_ADMIN", memAdmin);

		// 게시글 총 개수, 현재페이지 번호, 페이지 사이즈 이용해서 게시판 넘버링시 사용할 변수 number 계산해서 넘겨주기
		int number = totalList - (pg - 1) * pageSize;
		mv.addObject("number", number);
		System.out.println("number 값 : " + number);

		return mv;
	}

	@RequestMapping(value = "/help/noticeDetail")
	public ModelAndView noticeDetail(CommandMap commandMap) throws Exception {
		log.debug("###### 고객센터 공지사항 상세보기 ######");
		ModelAndView mv = new ModelAndView("noticeDetail");

		// 공지사항 정보들 담긴 Map객체 리턴해서 올려주기
		Map<String, Object> noticeDetail = noticeService.selectNoticeDetail(commandMap.getMap());
		mv.addObject("noticeDetail", noticeDetail);

		// Map객체에서 MEM_ADMIN 꺼내서 올려주기
		String memAdmin = (String) commandMap.get("MEM_ADMIN");
		mv.addObject("MEM_ADMIN", memAdmin);

		return mv;
	}
}
