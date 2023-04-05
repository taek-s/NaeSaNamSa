package ns.admin.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ns.admin.service.AdminUserService;
import ns.common.common.CommandMap;
import ns.myPage.service.MyPageService;
import ns.paging.AdminUserListPaging;

@Controller
public class AdminUserController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "adminUserService")
	private AdminUserService adminUserService;

	@Resource(name = "myPageService")
	private MyPageService myPageService;

	@Resource(name = "adminUserListPaging")
	private AdminUserListPaging adminUserListPaging;

	@RequestMapping(value = "/admin/userList")
	public ModelAndView userList(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 회원관리 리스트 조회 ######");
		System.out.println("####### searchType : " + commandMap.get("searchType"));
		System.out.println("####### keyword : " + commandMap.get("keyword"));

		ModelAndView mv = new ModelAndView("userList");

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
		int totalList = adminUserService.selectUserCount(commandMap.getMap()); // 총 회원 수

		// 페이징 클래스에 필요한 값을 넣어준다
		adminUserListPaging.setCurrentPage(pg);
		adminUserListPaging.setPageBlock(pageBlock);
		adminUserListPaging.setPageSize(pageSize);
		adminUserListPaging.setTotalList(totalList);

		String keyword = "";
		String searchType = (String) commandMap.get("searchType");

		if (commandMap.get("keyword") != null) {
			keyword = String.valueOf(commandMap.get("keyword"));
		}

		System.out.println("keyword 확인 " + keyword);

		if (keyword != null) {
			adminUserListPaging.setKeyword(keyword);
		}

		if (searchType != null) {
			adminUserListPaging.setSearchType(searchType);
		}

		// jsp에 삽입될 html을 생성하여 보낸다
		adminUserListPaging.makePagingHTML();
		mv.addObject("adminUserListPaging", adminUserListPaging);
		/////////////////////////////// 페이징 end /////////////////////////////////

		List<Map<String, Object>> list = adminUserService.selectUserList(commandMap.getMap());

		mv.addObject("userList", list);

		if (list.size() > 0) {
			mv.addObject("TOTAL", list.get(0).get("TOTAL"));
		} else {
			mv.addObject("TOTAL", 0);
		}

		return mv;
	}

	@RequestMapping(value = "/admin/userDetail")
	public ModelAndView userDetail(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 회원관리 상세보기 ######");
		ModelAndView mv = new ModelAndView("userDetail");
		Map<String, Object> member = adminUserService.selectAccountInfo(commandMap.getMap());

		mv.addObject("userDetail", member);
		return mv;
	}

	@RequestMapping(value = "/admin/userDelete")
	public ModelAndView userDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 회원 탈퇴시키기 ######");
		ModelAndView mv = new ModelAndView("redirect:/admin/userList");
		adminUserService.deleteAccount(commandMap.getMap());
		myPageService.updateGoodsDelGB(commandMap.getMap());
		return mv;
	}

	@RequestMapping(value = "/admin/userStop")
	public ModelAndView userStop(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 회원 정지시키기 ######");
		ModelAndView mv = new ModelAndView("redirect:/admin/userList");
		adminUserService.updateAccountStatus(commandMap.getMap());
		adminUserService.deleteGoodsTemp(commandMap.getMap());
		return mv;
	}

	@RequestMapping(value = "/admin/userRestoration")
	public ModelAndView userRestoration(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 회원 정지에서 복구시키기 ######");
		ModelAndView mv = new ModelAndView("redirect:/admin/userList");
		adminUserService.updateAccountStatusNormal(commandMap.getMap());
		adminUserService.restoreGoods(commandMap.getMap());
		return mv;
	}
}
