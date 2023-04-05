package ns.common.common;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ns.member.service.MailService;

@Controller
public class MailHandler {

	@Resource(name = "mailService")
	private MailService mailService;

	@RequestMapping(value = "/join/emailAuth")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
	}
}
