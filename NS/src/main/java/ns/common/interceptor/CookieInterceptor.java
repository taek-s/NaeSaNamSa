package ns.common.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ns.member.service.LoginService;

public class CookieInterceptor extends HandlerInterceptorAdapter {

	@Resource(name = "loginService")
	private LoginService loginService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();

		if (session.getAttribute("session_MEM_ID") == null) {
			Map<String, Object> map = new HashMap<String, Object>();
			Cookie[] cookies = request.getCookies();
			String emailCookie = "";
			String pwCookie = "";
			Cookie pw = null;
			Cookie email = null;

			if (cookies != null && cookies.length > 0) { // 쿠키 배열에 값이 있으면
				for (int i = 0; i < cookies.length; i++) { // 반복문으로 쿠키를 꺼냄
					if (cookies[i].getName().equals("emailCookie")) { // 이름이 emailCookie인 쿠키의 값을 꺼냄
						emailCookie = cookies[i].getValue();
						email = cookies[i];
						System.out.println("emailCookie : " + emailCookie);
					} else if (cookies[i].getName().equals("pwCookie")) { // 이름이 pwCookie인 쿠키의 값을 꺼냄
						pwCookie = cookies[i].getValue(); // String 객체
						pw = cookies[i]; // 쿠키타입 객체
						System.out.println("pwCookie : " + pwCookie);
					}
				}
			}
			// emailCookie와 pwCookie가 존재하면
			if ((emailCookie != "") && (pwCookie != "")) {
				System.out.println("이메일 쿠키 : " + emailCookie);
				System.out.println("비밀번호 쿠키 : " + pwCookie);

				map.put("MEM_EMAIL", (Object) emailCookie);

				Map<String, Object> resultMap = loginService.selectId(map); // DB의 이메일 가져오기
				System.out.println("DB로부터 가져온 회원정보 : " + resultMap);

				if (resultMap != null || resultMap.size() > 0) { // DB로부터 가져온 데이터가 있으면
					System.out.println("resultMap 이메일 : " + resultMap.get("MEM_EMAIL"));
					if (resultMap.get("MEM_PW").equals(pwCookie)) { // 비밀번호 쿠키 값과 DB의 비밀번호가 같으면
						// 세션에 회원정보 저장하여 로그인 처리
						session.setAttribute("session_MEM_ID", resultMap.get("MEM_EMAIL"));
						session.setAttribute("session_MEM_PW", pwCookie);
						session.setAttribute("session_MEM_INFO", resultMap);

					} else if (!resultMap.get("MEM_PW").equals(pwCookie)) { // 쿠키의 비밀번호와 DB가 일치하지 않으면 (쿠키 만료 전에 비밀번호를
																			// 변경했다면)

						// 기존 쿠키 삭제 (값 수정이 안 되고 계속 추가됨,,)
						Cookie oldEmail = new Cookie("emailCookie", ""); // 쿠키의 값을 비움
						Cookie oldPw = new Cookie("pwCookie", "");
						Cookie[] oldCookies = { oldEmail, oldPw };

						for (int i = 0; i < oldCookies.length; i++) {
							oldCookies[i].setMaxAge(0);
							oldCookies[i].setPath("/");
							response.addCookie(oldCookies[i]);
						}

						// 쿠키의 값을 DB의 비밀번호로 다시 생성
						Cookie cookie1 = new Cookie("emailCookie", (String) resultMap.get("MEM_EMAIL"));
						Cookie cookie2 = new Cookie("pwCookie", (String) resultMap.get("MEM_PW"));

						// 쿠키에 대한 설정
						Cookie[] newCookies = { cookie1, cookie2 };
						for (int i = 0; i < newCookies.length; i++) {
							// 유효시간 설정 (일주일)
							newCookies[i].setMaxAge(60 * 60 * 24 * 7);
							// 쿠키 경로 설정
							newCookies[i].setPath("/");
							// response로 쿠키 전달
							response.addCookie(newCookies[i]);
						}

						session.setAttribute("session_MEM_ID", resultMap.get("MEM_EMAIL"));
						session.setAttribute("session_MEM_PW", pw);
						session.setAttribute("session_MEM_INFO", resultMap);

					}
					System.out.println("세션에 저장한 데이터 : " + session.getAttribute("session_MEM_ID").toString() + ", "
							+ session.getAttribute("session_MEM_PW").toString());
				}
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

}
