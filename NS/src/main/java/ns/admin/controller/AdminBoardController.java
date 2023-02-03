package ns.admin.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ns.admin.service.AdminBoardService;
import ns.common.common.CommandMap;
import ns.common.service.InformService;
import ns.paging.AdminCSTotalListPaging;
import ns.paging.AdminReportTotalListPaging;

@Controller
public class AdminBoardController {

	// 건주 커밋 테스트
	// 윤정 커밋
	// 커밋.. 커밋추가
	// 민준 커밋
	// 햬리 커밋
	// 동영 커밋

	// 성택 커밋함
	// kst branch 생성하여 커밋

	// test branch 생성하고 테스트 해보기

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "adminBoardService")
	private AdminBoardService adminBoardService;

	@Resource(name = "informService")
	private InformService informService;

	@Resource(name = "adminCSTotalListPaging")
	private AdminCSTotalListPaging adminCSTotalListPaging;

	@Resource(name = "adminReportTotalListPaging")
	private AdminReportTotalListPaging adminReportTotalListPaging;

	// 추후 코드 수정필요시 수정
	@RequestMapping(value = "/admin/goodsDelete")
	public ModelAndView adminGoodsDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 상품 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/shop/totalList");
		adminBoardService.deleteGoods(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/noticeWriteForm")
	public ModelAndView nfWriteForm(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 공지사항 작성 폼 ######");
		ModelAndView mv = new ModelAndView("noticeWriteForm");

		return mv;
	}

	// 공지사항 작성 + 새로운 공지사항이 작성되면 모든 회원에게 알림
	@RequestMapping(value = "/admin/noticeWrite")
	public ModelAndView noticeWrite(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 관리자 공지사항 작성 ######");
		ModelAndView mv = new ModelAndView("redirect:/help/noticeList");

		adminBoardService.insertNotice(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/noticeModifyForm")
	public ModelAndView noticeModifyForm(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 공지사항 수정 폼 ######");
		ModelAndView mv = new ModelAndView("noticeModifyForm");

		// Map객체 넣어서 noticeDetail 맵 리턴 후 noticeModifyForm.jsp로 올리기 (commandMap에
		// NOTICE_NUM 담겨있음)
		Map<String, Object> noticeDetail = adminBoardService.selectNoticeDetail(commandMap.getMap());
		mv.addObject("noticeDetail", noticeDetail);

		return mv;
	}

	@RequestMapping(value = "/admin/noticeModify")
	public ModelAndView noticeModify(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 공지사항 수정 ######");
		ModelAndView mv = new ModelAndView("redirect:/help/noticeList");

		adminBoardService.updateNoticeModify(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/noticeDelete")
	public ModelAndView noticeDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 공지사항 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/help/noticeList");

		adminBoardService.deleteNotice(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/faqWriteForm")
	public ModelAndView faqWriteForm(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 FAQ 작성 폼 ######");
		ModelAndView mv = new ModelAndView("faqWriteForm");

		return mv;
	}

	@RequestMapping(value = "/admin/faqWrite")
	public ModelAndView faqWrite(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 FAQ 작성 ######");
		ModelAndView mv = new ModelAndView("redirect:/help/faqList");

		adminBoardService.insertFAQ(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/faqModifyForm")
	public ModelAndView faqModifyForm(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 FAQ 수정 폼 ######");
		ModelAndView mv = new ModelAndView("faqModifyForm");

		// faq 정보 담긴 Map 리턴 후, jsp로 올리기
		Map<String, Object> faqDetail = adminBoardService.selectFAQDetail(commandMap.getMap());
		mv.addObject("faqDetail", faqDetail);

		return mv;
	}

	@RequestMapping(value = "/admin/faqModify")
	public ModelAndView faqModify(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 FAQ 수정 ######");
		ModelAndView mv = new ModelAndView("redirect:/help/faqList");

		adminBoardService.updateFAQModify(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/faqDelete")
	public ModelAndView faqDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 FAQ 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/help/faqList");

		adminBoardService.deleteFAQ(commandMap.getMap());

		return mv;
	}

	@RequestMapping(value = "/admin/reportList")
	public ModelAndView adminReportList(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 전체 신고 리스트 조회 ######");
		ModelAndView mv = new ModelAndView("allReportList");

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
		if (commandMap.get("keyword") != null) {
			keyword = (String) commandMap.get("keyword");
		}

		// 총 개수를 가져오는 쿼리에는
		int totalList = adminBoardService.selectAdminReportCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		adminReportTotalListPaging.setCurrentPage(pg);
		adminReportTotalListPaging.setPageBlock(pageBlock);
		adminReportTotalListPaging.setPageSize(pageSize);
		adminReportTotalListPaging.setTotalList(totalList);

		if (searchType != null) {
			adminReportTotalListPaging.setSearchType(searchType);
		}

		if (keyword != null) {
			adminReportTotalListPaging.setKeyword(keyword);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		adminReportTotalListPaging.makePagingHTML();
		mv.addObject("adminReportTotalListPaging", adminReportTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> reportList = adminBoardService.selectAdminReportList(commandMap.getMap());
		mv.addObject("reportList", reportList);
		mv.addObject("searchType", searchType);
		mv.addObject("keyword", keyword);

		// 게시글 총 개수, 현재페이지 번호, 페이지 사이즈 이용해서 게시판 넘버링시 사용할 변수 number 계산해서 넘겨주기
		int number = totalList - (pg - 1) * pageSize;
		mv.addObject("number", number);
		System.out.println("number 값 : " + number);

		return mv;
	}

	// 신고글에 댓글 작성시, 해당 신고글 작성한 회원에게 알림
	@RequestMapping(value = "/admin/reportReplyWrite")
	public ModelAndView reportReplyWrite(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 신고 댓글 작성 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/reportDetail");

		adminBoardService.insertReportReply(commandMap.getMap());
		mv.addObject("REPORT_NUM", commandMap.get("REPORT_NUM"));

		return mv;
	}

	@RequestMapping(value = "/admin/reportReplyModify")
	public ModelAndView reportReplyModify(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 신고 댓글 수정 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/reportDetail");

		adminBoardService.updateReportReply(commandMap.getMap());
		mv.addObject("REPORT_NUM", commandMap.get("REPORT_NUM"));

		return mv;
	}

	@RequestMapping(value = "/admin/reportReplyDelete")
	public ModelAndView reportReplyDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 신고 댓글 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/reportDetail");

		adminBoardService.deleteReportReply(commandMap.getMap());

		mv.addObject("REPORT_NUM", commandMap.get("REPORT_NUM"));

		return mv;
	}

	@RequestMapping(value = "/admin/csList")
	public ModelAndView adminCSList(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 전체 고객센터 문의 리스트 조회 ######");
		ModelAndView mv = new ModelAndView("allCSList");

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
		if (commandMap.get("keyword") != null) {
			keyword = (String) commandMap.get("keyword");
		}

		// 총 개수를 가져오는 쿼리에는
		int totalList = adminBoardService.selectAdminCSCount(commandMap.getMap()); // 총 게시글 수

		// 페이징 클래스에 필요한 값을 넣어준다
		adminCSTotalListPaging.setCurrentPage(pg);
		adminCSTotalListPaging.setPageBlock(pageBlock);
		adminCSTotalListPaging.setPageSize(pageSize);
		adminCSTotalListPaging.setTotalList(totalList);

		if (searchType != null) {
			adminCSTotalListPaging.setSearchType(searchType);
		}

		if (keyword != null) {
			adminCSTotalListPaging.setKeyword(keyword);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		adminCSTotalListPaging.makePagingHTML();
		mv.addObject("adminCSTotalListPaging", adminCSTotalListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> csList = adminBoardService.selectAdminCSList(commandMap.getMap());
		mv.addObject("csList", csList);

		if (searchType != null) {
			mv.addObject("searchType", searchType);
		}

		// 게시글 총 개수, 현재페이지 번호, 페이지 사이즈 이용해서 게시판 넘버링시 사용할 변수 number 계산해서 넘겨주기
		int number = totalList - (pg - 1) * pageSize;
		mv.addObject("number", number);
		System.out.println("number 값 : " + number);

		return mv;
	}

	// 문의글에 댓글 작성시, 해당 문의글 작성한 회원에게 알림
	@RequestMapping(value = "/admin/csReplyWrite")
	public ModelAndView csReplyWrite(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 고객센터 문의 댓글 작성 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/csDetail");

		adminBoardService.insertCSReply(commandMap.getMap());
		mv.addObject("CS_NUM", commandMap.get("CS_NUM"));

		return mv;
	}

	@RequestMapping(value = "/admin/csReplyModify")
	public ModelAndView csReplyModify(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 고객센터 문의 댓글 수정 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/csDetail");

		adminBoardService.updateCSReply(commandMap.getMap());
		System.out.println("######CS_REPLY_NUM : " + commandMap.get("CS_REPLY_NUM"));

		mv.addObject("CS_NUM", commandMap.get("CS_NUM"));

		return mv;
	}

	@RequestMapping(value = "/admin/csReplyDelete")
	public ModelAndView csReplyDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 고객센터 문의 댓글 삭제 ######");
		ModelAndView mv = new ModelAndView("redirect:/myPage/csDetail");

		adminBoardService.deleteCSReply(commandMap.getMap());
		mv.addObject("CS_NUM", commandMap.get("CS_NUM"));

		return mv;
	}
}
