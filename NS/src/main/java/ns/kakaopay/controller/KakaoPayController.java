package ns.kakaopay.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ns.common.common.CommandMap;
import ns.common.dao.InformDAO;
import ns.order.service.OrderService;

@Controller
public class KakaoPayController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "orderService")
	private OrderService orderService;

	@Resource(name = "informDAO")
	private InformDAO informDAO;

	// 결제 준비
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/kakaopay")
	public ModelAndView kakaopay(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 카카오 페이 결제 준비 ######");
		ModelAndView mv = null;

		// Request (카카오페이 서버에 전송해줄 필수 Parameter들 - 전송 후 결제 고유번호인 TID 수신예정)
		String cid = "TC0ONETIME"; // 가맹점 코드(테스트 결제시 TC0ONETIME로 사용)
		String partner_order_id = (String) commandMap.get("ORDERS_NUM"); // 주문번호
		String partner_user_id = (String) commandMap.get("ORDERS_USER"); // 구매자 회원 번호
		String item_name = (String) commandMap.get("GOODS_TITLE"); // 상품 타이틀
		String sellerNum = (String) commandMap.get("sellerNum");
		int quantity = 1; // 상품 수량(1로 고정)
		int total_amount = Integer.parseInt(String.valueOf(commandMap.get("ORDERS_TCOST"))); // 최종 결제금액
		int tax_free_amount = 0; // 상품 비과세 금액(0으로 고정)
		String approval_url = "http://localhost:8080/ns/kakaopay/success"; // 결제 성공시 redirect url
		String cancel_url = "http://localhost:8080/ns/kakaopay/cancel"; // 결제 취소시 redirect url
		String fail_url = "http://localhost:8080/ns/kakaopay/fail"; // 결제 실패시 redirect url

		// 결제 준비시 연결할 웹페이지 url
		String apiURL = "https://kapi.kakao.com/v1/payment/ready";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection(); // url 연결

			con.setRequestMethod("POST");
			con.setDoOutput(true); // OutputStream으로 POST 데이터 넘겨주기 위해 true로 지정
			con.setRequestProperty("Authorization", "KakaoAK 6b05a6dfce056caaf6979c93480cb27f"); // Admin Key
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

			StringBuilder sb = new StringBuilder();

			// append() 사용해 문자열 더하기 (보내줄 파라미터들 한줄로 묶기)
			sb.append("cid=" + cid);
			sb.append("&partner_order_id=" + partner_order_id);
			sb.append("&partner_user_id=" + partner_user_id);
			sb.append("&item_name=" + item_name);
			sb.append("&quantity=" + quantity);
			sb.append("&total_amount=" + total_amount);
			sb.append("&tax_free_amount=" + tax_free_amount);
			sb.append("&approval_url=" + approval_url);
			sb.append("&cancel_url=" + cancel_url);
			sb.append("&fail_url=" + fail_url);

			OutputStream os = con.getOutputStream();
			OutputStreamWriter writer = new OutputStreamWriter(os);

			writer.write(sb.toString()); // sb 객체 String으로 변경해서, 파라미터 보내기
			writer.flush();
			writer.close();

			os.close();
			con.connect();

			// 버퍼 이용해서 읽기위해 객체선언 (readLine():입력 값으로 들어온 데이터를 한 줄로 읽어 String으로 바꿔줌)
			BufferedReader br;
			int responseCode = con.getResponseCode(); // 응답코드 받아서 responseCode에 저장
			System.out.println("responseCode=" + responseCode);

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생 (응답코드 200 아님)
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer res = new StringBuffer();

			// 입력 값으로 들어온 데이터를 String으로 변경해 inputLine에 저장해주고, 이 값이 null이 아니면
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine); // StringBuffer객체에 더해주기
			}
			br.close();

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				Map<String, Object> resultMap = new HashMap<>();

				// StringBuffer값인 res를 String으로 변경하고, Object로 변환
				JsonParser jp = new JsonParser();
				JsonObject jo = (JsonObject) jp.parse(res.toString());
				log.debug("(JsonObject) jp.parse(res.toString()) : " + (JsonObject) jp.parse(res.toString()));

				// Response, 서버로부터 온 응답은 JSON 형태로 오니까 JSON형태로 온걸 Map으로 변환
				Gson gson = new Gson();
				resultMap = gson.fromJson(jo, resultMap.getClass());

				// Response로 받은 tid 및 각종 파라미터 값 session에 올리기
				HttpSession session = request.getSession();

				Map<String, Object> orderMap = commandMap.getMap();

				session.setAttribute("session_tid", resultMap.get("tid"));
				session.setAttribute("session_orderMap", orderMap);
				session.setAttribute("session_memNum", partner_user_id);
				session.setAttribute("session_seller", sellerNum);

				log.debug("resultMap.get(\"tid\") : " + resultMap.get("tid"));

				// 결제 요청 (이 때, 카카오페이 결제 대기화면 표시)
				// Map에서 꺼낸 PC용 redirect url로 리다이렉트
				String redirectUrl = (String) resultMap.get("next_redirect_pc_url");
				log.debug("(String) resultMap.get(\"next_redirect_pc_url\") : "
						+ (String) resultMap.get("next_redirect_pc_url"));
				mv = new ModelAndView("redirect:" + redirectUrl);

				return mv;

			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}

	// 결제 성공
	@RequestMapping(value = "/kakaopay/success")
	public ModelAndView kakaoPaySuccess(CommandMap commandMap, HttpServletRequest request,
			@RequestParam(value = "pg_token", required = false) String pg_token) throws Exception {
		log.debug("###### 카카오페이 결제 성공 ######");

		ModelAndView mv = null;

		HttpSession session = request.getSession();
		String sessionTid = (String) session.getAttribute("session_tid");

		commandMap.putAll((Map<String, Object>) session.getAttribute("session_orderMap"));
		log.debug("map 확인 " + commandMap.getMap());

		// request
		String cid = "TC0ONETIME"; // 가맹점 코드(테스트 결제시 TC0ONETIME로 사용)
		String tid = sessionTid; // 결제 고유번호(결제 준비 API 응답에 포함)
		String partner_order_id = (String) commandMap.get("ORDERS_NUM"); // 주문번호
		String partner_user_id = (String) commandMap.get("ORDERS_USER"); // 구매자 회원 번호
		String goodsTitle = (String) commandMap.get("GOODS_TITLE"); // 구매자 회원 번호
		String sellerNum = (String) session.getAttribute("session_seller");
		int total_amount = Integer.parseInt(String.valueOf(commandMap.get("ORDERS_TCOST"))); // 최종 결제금액

		Map<String, Object> sellerMap = new HashMap<>();
		sellerMap.put("MEM_NUM", sellerNum);
		sellerMap.put("INFORM_TYPE", 1);
		sellerMap.put("INFORM_PRONUM", partner_order_id);

		// 결제 승인 요청시 연결할 웹페이지 url
		String apiURL = "https://kapi.kakao.com/v1/payment/approve";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection(); // url 연결
			con.setRequestMethod("POST");
			con.setDoOutput(true); // OutputStream으로 POST 데이터 넘겨주기 위해 true로 지정
			con.setRequestProperty("Authorization", "KakaoAK 6b05a6dfce056caaf6979c93480cb27f"); // Admin Key
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

			StringBuilder sb = new StringBuilder();

			// append() 사용해 문자열 더하기 (보내줄 파라미터들 한줄로 묶기)
			sb.append("cid=" + cid);
			sb.append("&tid=" + tid);
			sb.append("&partner_order_id=" + partner_order_id);
			sb.append("&partner_user_id=" + partner_user_id);
			sb.append("&pg_token=" + pg_token);
			sb.append("&total_amount=" + total_amount);

			OutputStream os = con.getOutputStream();
			OutputStreamWriter writer = new OutputStreamWriter(os);

			writer.write(sb.toString()); // sb 객체 String으로 변경해서, 파라미터 보내기
			log.debug("sb.toString() : " + sb.toString());
			writer.flush();
			writer.close();

			os.close();
			con.connect();

			// 버퍼 이용해서 읽기위해 객체선언 (readLine():입력 값으로 들어온 데이터를 한 줄로 읽어 String으로 바꿔줌)
			BufferedReader br;
			int responseCode = con.getResponseCode(); // 응답코드 받아서 responseCode에 저장
			String responseMessage = con.getResponseMessage();
			System.out.println("responseCode=" + responseCode);
			System.out.println("responseMessage=" + responseMessage);

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생 (응답코드 200 아님)
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer res = new StringBuffer();

			// 입력 값으로 들어온 데이터를 String으로 변경해 inputLine에 저장해주고, 이 값이 null이 아니면
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine); // StringBuffer객체에 더해주기
			}
			br.close();

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				Map<String, Object> resultMap = new HashMap<>();

				// StringBuffer값인 res를 String으로 변경하고, Object로 변환
				JsonParser jp = new JsonParser();
				JsonObject jo = (JsonObject) jp.parse(res.toString());
				log.debug("(JsonObject) jp.parse(res.toString()) : " + (JsonObject) jp.parse(res.toString()));

				// Response, 서버로부터 온 응답은 JSON 형태로 오니까 JSON형태로 온걸 Map으로 변환
				Gson gson = new Gson();
				resultMap = gson.fromJson(jo, resultMap.getClass());
				log.debug("resultMap : " + resultMap);

				// 카카오페이 정상 결제될 경우 주문 완료하고, 상품 판매상태도 '거래중'으로 변경
				orderService.insertOrder(commandMap.getMap());

				if (commandMap.get("ORDERS_DMEMO").equals("직거래")) {
					orderService.updateGoodsTstatusByOrder2(commandMap.getMap()); // 직거래 구매시 판매상태 '판매 완료'로 변경
				} else {
					orderService.updateGoodsTstatusByOrder(commandMap.getMap()); // 배송 구매시 상품 판매상태 '거래중'으로 변경
				}

				// 결제 완료한 후, 주문 상세보기 페이지로 이동
				// 직거래일 경우, 직거래 주문상세 페이지로 이동
				if (commandMap.get("ORDERS_DMEMO").equals("직거래")) {
					mv = new ModelAndView("redirect:/shop/order/orderDetail2?ORDERS_NUM=" + commandMap.get("ORDERS_NUM")
							+ "&tid=" + tid);
				}
				// 배송일 경우, 배송 주문상세 페이지로 이동
				else {
					mv = new ModelAndView("redirect:/shop/order/orderDetail?ORDERS_NUM=" + commandMap.get("ORDERS_NUM")
							+ "&tid=" + tid);
				}
				informDAO.informInsert(sellerMap, "[ " + goodsTitle + " ] 해당 상품이 판매되었습니다");

				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return mv;
	}

	// 결제 취소
	@RequestMapping(value = "/kakaopay/cancel")
	public ModelAndView kakaoPayCancel(CommandMap commandMap, HttpServletRequest request,
			@RequestParam(value = "tid", required = false) String tid) throws Exception {
		log.debug("###### 카카오페이 결제 취소 ######");

		ModelAndView mv = null;
		log.debug("tid : " + tid);

		// tid가 있을경우 (결제 성공하고 난 후, 주문 취소할 때에 해당)
		if (tid != null) {

			HttpSession session = request.getSession();
			String sessionTid = (String) session.getAttribute("session_tid");

			Map<String, Object> orderDetail = orderService.selectOrderDetail(commandMap.getMap());

			// Request (카카오페이 서버에 전송해줄 필수 Parameter들)
			String cid = "TC0ONETIME"; // 가맹점 코드(테스트 결제시 TC0ONETIME로 사용)
			int cancel_amount = Integer.parseInt(orderDetail.get("ORDERS_TCOST").toString()); // 취소금액
			int cancel_tax_free_amount = 0; // 취소 비과세 금액

			// 결제 취소시 연결할 웹페이지 url
			String apiURL = "https://kapi.kakao.com/v1/payment/cancel ";

			try {
				URL url = new URL(apiURL);
				HttpURLConnection con = (HttpURLConnection) url.openConnection(); // url 연결
				con.setRequestMethod("POST");
				con.setDoOutput(true); // OutputStream으로 POST 데이터 넘겨주기 위해 true로 지정
				con.setRequestProperty("Authorization", "KakaoAK 6b05a6dfce056caaf6979c93480cb27f"); // Admin Key
				con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

				StringBuilder sb = new StringBuilder();

				// append() 사용해 문자열 더하기 (보내줄 파라미터들 한줄로 묶기)
				sb.append("cid=" + cid);
				sb.append("&tid=" + tid);
				sb.append("&cancel_amount=" + cancel_amount);
				sb.append("&cancel_tax_free_amount=" + cancel_tax_free_amount);

				OutputStream os = con.getOutputStream();
				OutputStreamWriter writer = new OutputStreamWriter(os);

				writer.write(sb.toString()); // sb 객체 String으로 변경해서, 파라미터 보내기
				log.debug("sb.toString() : " + sb.toString());
				writer.flush();
				writer.close();

				os.close();
				con.connect();

				// 버퍼 이용해서 읽기위해 객체선언 (readLine():입력 값으로 들어온 데이터를 한 줄로 읽어 String으로 바꿔줌)
				BufferedReader br;
				int responseCode = con.getResponseCode(); // 응답코드 받아서 responseCode에 저장
				String responseMessage = con.getResponseMessage();
				System.out.println("responseCode=" + responseCode);
				System.out.println("responseMessage=" + responseMessage);

				if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
					br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				} else { // 에러 발생 (응답코드 200 아님)
					br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}

				String inputLine;
				StringBuffer res = new StringBuffer();

				// 입력 값으로 들어온 데이터를 String으로 변경해 inputLine에 저장해주고, 이 값이 null이 아니면
				while ((inputLine = br.readLine()) != null) {
					res.append(inputLine); // StringBuffer객체에 더해주기
				}
				br.close();

				if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
					Map<String, Object> resultMap = new HashMap<>();

					// StringBuffer값인 res를 String으로 변경하고, Object로 변환
					JsonParser jp = new JsonParser();
					JsonObject jo = (JsonObject) jp.parse(res.toString());
					log.debug("(JsonObject) jp.parse(res.toString()) : " + (JsonObject) jp.parse(res.toString()));

					// Response, 서버로부터 온 응답은 JSON 형태로 오니까 JSON형태로 온걸 Map으로 변환
					Gson gson = new Gson();
					resultMap = gson.fromJson(jo, resultMap.getClass());
					log.debug("resultMap : " + resultMap);

					// 카카오페이 정상 취소될 경우 주문도 취소하고, 상품 판매상태도 다시 '판매중'으로 변경
					orderService.deleteOrder(commandMap.getMap());
					orderService.updateGoodsTstatusByOrderCancel(commandMap.getMap());
				}

			} catch (Exception e) {
				System.out.println(e);
			}

			// 결제 취소후, 주문 내역 조회 화면으로 리다이렉트
			mv = new ModelAndView("redirect:/myShop/orderHistory");
		}

		// tid가 null이라면, 즉 결제 성공하기 전인 결제 화면에서 x버튼 눌러서 결제 안할경우에 해당 (결제 성공 전이라서 저장된 tid값
		// 없어서 못받아옴)
		else {
			HttpSession session = request.getSession();
			Map<String, Object> orderMap = (Map<String, Object>) session.getAttribute("session_orderMap");
			log.debug("orderMap : " + orderMap);

			int ordersPronum = Integer.parseInt(orderMap.get("GOODS_NUM").toString());
			System.out.println("##ordersPronum : " + ordersPronum);

			// 직거래일 경우, 결제 취소 후 다시 직거래 구매하기 화면으로 이동
			if (orderMap.get("ORDERS_DMEMO").equals("직거래")) {
				mv = new ModelAndView("redirect:/shop/order/orderWriteForm2?GOODS_NUM=" + ordersPronum);
				commandMap.put("GOODS_NUM", ordersPronum);
			}

			// 배송일 경우, 결제 취소 후 다시 배송 구매하기 화면으로 이동
			else {
				mv = new ModelAndView("redirect:/shop/order/orderWriteForm?GOODS_NUM=" + ordersPronum);
				commandMap.put("GOODS_NUM", ordersPronum);
			}
		}
		return mv;
	}

	// 결제 실패(결제 준비 화면에서 15분 timeout 대기하면 동작함. 아니면 그냥 직접 GET방식으로 /kakaopay/fail 요청해서
	// 확인해도 됨)
	@RequestMapping(value = "/kakaopay/fail")
	public ModelAndView kakaoPaySuccessFail(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 카카오페이 결제 실패 ######");
		ModelAndView mv = null;

		HttpSession session = request.getSession();
		Map<String, Object> orderMap = (Map<String, Object>) session.getAttribute("session_orderMap");
		log.debug("orderMap : " + orderMap);

		int ordersPronum = Integer.parseInt(orderMap.get("GOODS_NUM").toString());
		System.out.println("##ordersPronum : " + ordersPronum);

		// 직거래일 경우, 결제 실패 후 다시 직거래 구매하기 화면으로 이동
		if (orderMap.get("ORDERS_DMEMO").equals("직거래")) {
			mv = new ModelAndView("redirect:/shop/order/orderWriteForm2?GOODS_NUM=" + ordersPronum);
			commandMap.put("GOODS_NUM", ordersPronum);
		}

		// 배송일 경우, 결제 실패 후 다시 배송 구매하기 화면으로 이동
		else {
			mv = new ModelAndView("redirect:/shop/order/orderWriteForm?GOODS_NUM=" + ordersPronum);
			commandMap.put("GOODS_NUM", ordersPronum);
		}

		return mv;
	}
}