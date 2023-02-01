package ns.help.controller;

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
import ns.help.service.HelpService;

@Controller
public class HelpController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "helpService")
	private HelpService helpService;

	@RequestMapping(value = "/help/main")
	public ModelAndView helpMain(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 고객센터 메인 ######");
		ModelAndView mv = new ModelAndView("helpMain");

		List<Map<String, Object>> faqList = helpService.selectMainFAQList(commandMap.getMap());
		List<Map<String, Object>> mainNoticeList = helpService.selectMainNotice(commandMap.getMap());

		// 세션생성 (MEM_ADMIN값 넘겨주기 위함)
		// 세션 객체에서 멤버정보 담긴 map가져와서, MEM_ADMIN만 따로 빼서 /help/main.jsp로 올리기
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		String memAdmin = (String) member.get("MEM_ADMIN");

		mv.addObject("MEM_ADMIN", memAdmin);

		// map객체 올려주기
		mv.addObject("faqList", faqList);
		mv.addObject("mainNoticeList", mainNoticeList);

		return mv;
	}
}
