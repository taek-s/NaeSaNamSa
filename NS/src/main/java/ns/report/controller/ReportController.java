package ns.report.controller;

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
import ns.paging.ReportTotalListPaging;
import ns.report.service.ReportService;

@Controller
public class ReportController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "reportService")
	private ReportService reportService;

	@Resource(name = "reportTotalListPaging")
	private ReportTotalListPaging reportTotalListPaging;

	@RequestMapping(value = "/myPage/reportWrite")
	public ModelAndView reportWrite(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 상품 신고하기 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/reportList");

		// commandMap.put("MEM_EMAIL", "KIMST");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		String email = (String) map.get("MEM_EMAIL");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());

		commandMap.put("MEM_EMAIL", email);
		commandMap.put("MEM_NUM", session_mem_num);

		reportService.reportWrite(commandMap.getMap());

		String type = (String) commandMap.get("REPORT_TYPE");
		System.out.println("타입 잘 받는지 테스트: " + type);

		mv.addObject("MEM_NUM", session_mem_num);

		return mv;
	}

	@RequestMapping(value = "/myPage/reportList")
	public ModelAndView reportList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 마이페이지 신고 내역 조회 ######");
		ModelAndView mv = new ModelAndView("reportList");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int memNum = Integer.parseInt(String.valueOf(map.get("MEM_NUM")));
		commandMap.put("MEM_NUM", memNum); // 신고 작성자

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
		int totalList = reportService.selectReportCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		reportTotalListPaging.setCurrentPage(pg);
		reportTotalListPaging.setPageBlock(pageBlock);
		reportTotalListPaging.setPageSize(pageSize);
		reportTotalListPaging.setTotalList(totalList);

		// jsp에 삽입될 html을 생성하여 보낸다
		reportTotalListPaging.makePagingHTML();
		mv.addObject("reportTotalListPaging", reportTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> reportMap = reportService.selectReportList(commandMap.getMap());
		mv.addObject("reportMap", reportMap);
		mv.addObject("reportPaging", reportTotalListPaging);

		// 게시글 총 개수, 현재페이지 번호, 페이지 사이즈 이용해서 게시판 넘버링시 사용할 변수 number 계산해서 넘겨주기
		int number = totalList - (pg - 1) * pageSize;
		mv.addObject("number", number);
		System.out.println("number 값 : " + number);

		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/myPage/reportDetail")
	public ModelAndView reportDetail(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 마이페이지 신고 상세보기 ######");
		ModelAndView mv = new ModelAndView("reportDetail");

		// commandMap.put("REPORT_REPLY_NUM", 2); // 임시로 번호 넣어둠 ?
		Map<String, Object> reportDetailMap = reportService.selectReportDetail(commandMap.getMap());
		mv.addObject("reportDetailMap", reportDetailMap);

		Map<String, Object> reportReplyMap = reportService.selectReportReply(commandMap.getMap());
		mv.addObject("reportReplyMap", reportReplyMap);

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		mv.addObject("session", map);

		System.out.println(map);

		return mv;
	}

	@RequestMapping(value = "/myPage/reportDelete")
	public ModelAndView reportDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 마이페이지 신고 취소/삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/reportList");

		reportService.deleteReport(commandMap.getMap());
		reportService.deleteReportReply(commandMap.getMap());

		return mv;
	}
}
