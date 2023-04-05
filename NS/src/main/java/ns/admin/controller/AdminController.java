package ns.admin.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;

@Controller
public class AdminController {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value = "/admin/main")
	public ModelAndView adminMain(CommandMap commandMap) throws Exception {
		log.debug("###### 관리자 전용 메인 페이지 ######");
		ModelAndView mv = new ModelAndView("adminMain");

		return mv;
	}
}
