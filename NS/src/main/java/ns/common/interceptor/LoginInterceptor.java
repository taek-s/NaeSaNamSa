package ns.common.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;


public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
				//세션영역에서 회원 정보 가져오기
				HttpSession session = request.getSession();
				
				if(session.getAttribute("session_MEM_ID") == null) { //세션영역에 회원정보가 없으면 
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('로그인 후 이용해주세요.'); location='"+request.getContextPath()+"/loginSelect'</script>");
					out.flush();
					
					return false;
				}
				
				return true;
			}		


	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

		
}
