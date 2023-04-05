package ns.member.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
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
public class KakaoController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "loginService")
	private LoginService loginService;

	@Resource(name = "joinService")
	private JoinService joinService;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loginKakao")
	public ModelAndView loginKakao(CommandMap commandMap) throws Exception {
		log.debug("###### 카카오 로그인 ######");
		ModelAndView mv = null;

		String clientId = "b3fcf64864d96f4d4de5224fb6d56b33";// 애플리케이션 클라이언트 아이디값";
		String code = (String) commandMap.get("code"); // 인증 코드
		String redirectURI = "http://localhost:8080/ns/loginKakao";
		String apiURL = "https://kauth.kakao.com/oauth/token";
		String access_token = "";

		System.out.println("################ apiURL : " + apiURL);

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setDoOutput(true);

			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + clientId); // 본인이 발급받은 key
			sb.append("&redirect_uri=" + redirectURI); // 본인이 설정해 놓은 경로
			sb.append("&code=" + code);

//			int length = sb.toString().getBytes().length;
//			con.setRequestProperty("Content-Length", String.valueOf(length));

//			System.out.println("#################### params : " + sb.toString());

			OutputStream os = con.getOutputStream();
			OutputStreamWriter writer = new OutputStreamWriter(os);
			writer.write(sb.toString());
			writer.flush();
			writer.close();
			os.close();
			con.connect();

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
				System.out.println("##################### res : " + res);
				Map<String, String> map = new HashMap<>();
				Gson gson = new Gson();
				map = gson.fromJson(res.toString(), map.getClass());

				access_token = map.get("access_token");
				mv = new ModelAndView("redirect:/loginKakao/result");
				mv.addObject("access_token", access_token);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loginKakao/result")
	public ModelAndView loginNaverResult(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 카카오 로그인2 ######");
		ModelAndView mv = null;

		String access_token = (String) commandMap.get("access_token");
		String apiURL = "https://kapi.kakao.com/v2/user/me";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
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
				JsonObject jo2 = (JsonObject) jo.get("kakao_account");
				JsonObject nickjo = (JsonObject) jo2.get("profile");

				System.out.println("########## result + " + jo2);

				Map<String, Object> resultMap = new HashMap<>();
				Map<String, Object> memNameMap = new HashMap<>();
				Map<String, Object> idMap = new HashMap<>();
				Gson gson = new Gson();
				resultMap = gson.fromJson(jo2, resultMap.getClass());
				memNameMap = gson.fromJson(nickjo, memNameMap.getClass());
				idMap = gson.fromJson(jo, idMap.getClass());

				System.out.println("########## resultMap + " + resultMap);
				System.out.println("########## memName + " + memNameMap);
				System.out.println("########## idMap + " + idMap);

				String uniqueId = String.valueOf(idMap.get("id"));
				resultMap.put("MEM_EMAIL", uniqueId);

				resultMap.put("MEM_PW", idMap.get("id"));
				String gender = (String) resultMap.get("gender");
				if (gender.equals("male")) {
					resultMap.put("MEM_GEN", "1");
				} else {
					resultMap.put("MEM_GEN", "2");
				}
				resultMap.put("MEM_NAME", memNameMap.get("nickname"));

				StringBuffer sb = new StringBuffer();
				String birthyear = (String) resultMap.get("age_range");
				String birthday = (String) resultMap.get("birthday");
				sb.append(birthyear.substring(0, 2));
				sb.append(birthday);
				resultMap.put("MEM_BIRTH", sb.toString());

				Map<String, Object> emailMap = joinService.selectEmailCheck(resultMap);
				System.out.println("###################### emailMap : " + emailMap);
				if (emailMap == null) {
					System.out.println("########## resultMap + " + resultMap);

					mv = new ModelAndView("kakaoJoinForm");
					mv.addObject("member", resultMap);
					return mv;
				} else {
					mv = new ModelAndView("redirect:/main");

					Map<String, Object> memPhone = joinService.selectMemPhone(resultMap);
					resultMap.put("MEM_PHONE", memPhone.get("MEM_PHONE"));

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
					session.setAttribute("session_MEM_KAKAO", "Y");
					session.setAttribute("access_token", access_token);

					return mv;
				}

			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}

	@RequestMapping(value = "/logoutKakao")
	public ModelAndView logoutKakao(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 카카오 로그아웃 ######");
		ModelAndView mv = null;

		HttpSession session = request.getSession(false);
		String access_token = (String) session.getAttribute("access_token");
		String apiURL = "https://kapi.kakao.com/v1/user/logout";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
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
				mv = new ModelAndView("redirect:/main");
				session.invalidate();
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}

}
