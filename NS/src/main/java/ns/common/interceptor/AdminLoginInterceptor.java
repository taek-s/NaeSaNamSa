package ns.common.interceptor;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 세션영역에서 회원 정보 가져오기
		Map<String, Object> member = (Map<String, Object>) request.getSession().getAttribute("session_MEM_INFO");
		String admin = (String) member.get("MEM_ADMIN"); // 관리자 여부 뽑아오기
		System.out.println("admin : " + admin); // 확인을 위해 출력

		HttpSession session = request.getSession();

		if (admin.equals("N")) { // 관리자가 아니면
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('관리자만 접근 가능합니다.'); location='" + request.getContextPath() + "/main'</script>");
			out.flush();

			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		super.postHandle(request, response, handler, modelAndView);

	}

}
