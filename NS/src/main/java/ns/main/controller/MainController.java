package ns.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;
import ns.common.service.InformService;
import ns.main.service.MainService;

@Controller
public class MainController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "mainService")
	private MainService mainService;

	@Resource(name = "informService")
	private InformService informService;

	@RequestMapping(value = "/main")
	public ModelAndView main(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 내사남사 메인페이지 ######");
		ModelAndView mv = new ModelAndView("main");

		HttpSession session = request.getSession(false);
		if (session != null) {
			@SuppressWarnings("unchecked")
			Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
			if (member != null) {
				String memEmail = (String) session.getAttribute("session_MEM_ID");
				int memNum = Integer.parseInt(String.valueOf(member.get("MEM_NUM")));
				log.debug("################ 로그인 된 회원 ID : " + memEmail + " ##############");
				log.debug("################ 로그인 된 회원 번호 : " + memNum + " ##############");
			}
		}

		List<Map<String, Object>> list = mainService.selectNewGoodsList(commandMap.getMap());
		mv.addObject("list", list);
		mv.addObject("loginFail", commandMap.get("loginFail"));

		String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources");
		System.out.println("###################### uploadPath : " + uploadPath);

		return mv;
	}

	@RequestMapping(value = "/inform")
	public @ResponseBody List<Map<String, Object>> inform(HttpServletRequest request) throws Exception {
		log.debug("###### Inform ########");

		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int userNum = Integer.parseInt(member.get("MEM_NUM").toString());

		Map<String, Object> map = new HashMap<>();
		map.put("MEM_NUM", userNum);

		List<Map<String, Object>> informList = informService.informList(map);

		log.debug("informList : " + informList);

		return informList;
	}

	@RequestMapping(value = "/inform/value")
	public @ResponseBody Map<String, Object> confirmUpdate(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### confirmUpdate ########");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		informService.confirmUpdate(map);

		return resultMap;
	}

}
