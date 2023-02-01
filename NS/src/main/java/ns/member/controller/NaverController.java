package ns.member.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ns.common.common.CommandMap;
import ns.member.service.JoinService;
import ns.member.service.LoginService;

@Controller
public class NaverController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "loginService")
	private LoginService loginService;

	@Resource(name = "joinService")
	private JoinService joinService;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loginNaver")
	public ModelAndView loginNaver(CommandMap commandMap) throws Exception {
		log.debug("###### 네이버 로그인 ######");
		ModelAndView mv = new ModelAndView("redirect:/loginNaver/result");

		String clientId = "3kvMcStoYugzaUkMxzep";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "12yuGsDOrR";// 애플리케이션 클라이언트 시크릿값";
		String code = (String) commandMap.get("code");
		String state = (String) commandMap.get("state");
		String redirectURI = URLEncoder.encode("http://localhost:8080/ns/loginNaver/result", "UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		System.out.println("apiURL=" + apiURL);

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.print("responseCode=" + responseCode);
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {

				Map<String, String> map = new HashMap<>();
				Gson gson = new Gson();
				map = gson.fromJson(res.toString(), map.getClass());

				access_token = map.get("access_token");
				mv.addObject("access_token", access_token);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}

	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/loginNaver/result")
	public ModelAndView loginNaverResult(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 네이버 로그인2 ######");
		ModelAndView mv = null;

		String access_token = (String) commandMap.get("access_token");
		String apiURL = "https://openapi.naver.com/v1/nid/me";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", "Bearer " + access_token);

			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.println("responseCode=" + responseCode);
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				JsonParser jp = new JsonParser();
				JsonObject jo = (JsonObject) jp.parse(res.toString());
				JsonObject jo2 = (JsonObject) jo.get("response");

				System.out.println("########## result + " + jo2);

				Map<String, Object> resultMap = new HashMap<>();
				Gson gson = new Gson();
				resultMap = gson.fromJson(jo2, resultMap.getClass());

				String uniqueId = (String) resultMap.get("id");
				resultMap.put("MEM_EMAIL", uniqueId);
				String phone = (String) resultMap.get("mobile");
				resultMap.put("MEM_PHONE1", phone.substring(0, 3));
				resultMap.put("MEM_PHONE2", phone.substring(4, 8));
				resultMap.put("MEM_PHONE3", phone.substring(9));
				resultMap.put("MEM_PHONE", phone.substring(0, 3) + phone.substring(4, 8) + phone.substring(9));
				resultMap.put("MEM_NAME", resultMap.remove("name"));

				resultMap.put("MEM_PW", uniqueId);
				String gender = (String) resultMap.get("gender");
				if (gender.equals("M")) {
					resultMap.put("MEM_GEN", "1");
				} else {
					resultMap.put("MEM_GEN", "2");
				}

				StringBuffer sb = new StringBuffer();
				String birthyear = (String) resultMap.get("birthyear");
				String birthday = (String) resultMap.get("birthday");
				sb.append(birthyear.substring(2));
				sb.append(birthday.substring(0, 2));
				sb.append(birthday.substring(3));
				resultMap.put("MEM_BIRTH", sb.toString());

				Map<String, Object> emailMap = joinService.selectEmailCheck(resultMap);
				System.out.println("###################### emailMap : " + emailMap);
				if (emailMap == null) {

					System.out.println("########## resultMap + " + resultMap);

					mv = new ModelAndView("naverJoinForm");
					mv.addObject("member", resultMap);
					return mv;
				} else {
					mv = new ModelAndView("redirect:/main");

					int check = joinService.selectDelGB(resultMap);

					if (check == 1) {
						// DB에 회원가입 처리 전, 회원 탈퇴한 이력이 있고 7일 지났는지 여부 확인
						int delCount = joinService.selectDelCount(resultMap);
						System.out.println("delCount : " + delCount);

						if (delCount == 0) { // 회원 탈퇴 후 7일이 지나지 않았을 경우
							mv.addObject("loginFail", "Y");
							return mv;
						} else {
							joinService.updateDelGB(resultMap);
						}
					}

					Map<String, Object> member = loginService.selectId(resultMap);

					HttpSession session = request.getSession();
					session.setAttribute("session_MEM_ID", emailMap.get("MEM_EMAIL")); // 지워도 문제 없을 듯
					session.setAttribute("session_MEM_INFO", member);
					session.setAttribute("session_MEM_NAVER", "Y");

					return mv;
				}

			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}
}
