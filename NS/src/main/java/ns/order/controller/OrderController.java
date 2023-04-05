package ns.order.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ns.common.common.CommandMap;
import ns.order.service.OrderService;

@Controller
public class OrderController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "orderService")
	private OrderService orderService;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/shop/order/orderWriteForm")
	public ModelAndView orderWriteForm(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 배송으로 주문하기 폼  ######");
		ModelAndView mv = new ModelAndView("orderWriteForm");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());
		String session_mem_phone = map.get("MEM_PHONE").toString();

		commandMap.put("MEM_NUM", session_mem_num);
		Map<String, Object> member = orderService.selectAccountInfo(commandMap.getMap());

		Map<String, Object> goods = orderService.selectGoodsInfo(commandMap.getMap());

		String goodsNum = (String) commandMap.get("GOODS_NUM");

		int maxOrderNum = orderService.selectMaxOrderNum();

		String mem_phone = (String) member.get("MEM_PHONE");
		String phone1 = mem_phone.substring(0, 3);
		String phone2 = mem_phone.substring(3, 7);
		String phone3 = mem_phone.substring(7);

		member.put("MEM_PHONE1", phone1);
		member.put("MEM_PHONE2", phone2);
		member.put("MEM_PHONE3", phone3);

		mv.addObject("member", member);

		mv.addObject("maxOrderNum", maxOrderNum);
		mv.addObject("MEM_NUM", session_mem_num);
		mv.addObject("MEM_PHONE", session_mem_phone);
		mv.addObject("GOODS_NUM", goodsNum);
		mv.addObject("goods", goods);

		String sellerNum = (String) commandMap.get("sellerNum");

		mv.addObject("seller", sellerNum);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderWriteForm2")
	public ModelAndView orderWriteForm2(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 직거래로 주문하기 폼  ######");
		log.debug("###commandMap 확인 : " + commandMap.getMap());

//		int goodsNum1 = Integer.parseInt(commandMap.get("ORDERS_PRONUM").toString());
//		commandMap.put("GOODS_NUM", goodsNum1);

		ModelAndView mv = new ModelAndView("orderWriteForm2");
		Map<String, Object> goods = orderService.selectGoodsInfo(commandMap.getMap());
		int maxOrderNum = orderService.selectMaxOrderNum();
		String goodsNum = (String) commandMap.get("GOODS_NUM");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());
		String session_mem_phone = map.get("MEM_PHONE").toString();

		mv.addObject("maxOrderNum", maxOrderNum);
		mv.addObject("GOODS_NUM", goodsNum);
		mv.addObject("goods", goods);
		mv.addObject("MEM_NUM", session_mem_num);
		mv.addObject("MEM_PHONE", session_mem_phone);

		String sellerNum = (String) commandMap.get("sellerNum");

		mv.addObject("seller", sellerNum);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderWrite")
	public ModelAndView orderWrite(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 주문하기 ######");
		ModelAndView mv = new ModelAndView("redirect:/myShop/orderHistory");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());
		String session_mem_phone = map.get("MEM_PHONE").toString();
		String session_mem_name = (map.get("MEM_NAME").toString());

		commandMap.put("MEM_NAME", session_mem_name);
		commandMap.put("ORDERS_PHONE", session_mem_phone);
		orderService.insertOrder(commandMap.getMap());

		mv.addObject("MEM_NUM", session_mem_num);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderDetail") // 배송
	public ModelAndView orderDetail(CommandMap commandMap, @RequestParam(value = "tid", required = false) String tid,
			HttpServletRequest request) throws Exception {
		log.debug("###### 주문 상세 보기 ######");

		ModelAndView mv = new ModelAndView("orderDetail");

		Map<String, Object> orderMap = orderService.selectOrderDetail(commandMap.getMap());

		String mem_phone = (String) orderMap.get("ORDERS_PHONE");
		String phone1 = mem_phone.substring(0, 3);
		String phone2 = mem_phone.substring(3, 7);
		String phone3 = mem_phone.substring(7);

		orderMap.put("ORDERS_PHONE1", phone1);
		orderMap.put("ORDERS_PHONE2", phone2);
		orderMap.put("ORDERS_PHONE3", phone3);

		mv.addObject("order", orderMap);
		mv.addObject("tid", tid);

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());
		mv.addObject("MEM_NUM", session_mem_num);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderDetail2") // 직거래
	public ModelAndView orderDetail2(CommandMap commandMap, @RequestParam("tid") String tid, HttpServletRequest request)
			throws Exception {
		log.debug("###### 주문 상세 보기 ######");

		ModelAndView mv = new ModelAndView("orderDetail2");

		Map<String, Object> orderMap = orderService.selectOrderDetail(commandMap.getMap());

		mv.addObject("order", orderMap);
		mv.addObject("tid", tid);
		System.out.println("###########tid 값 확인#############" + tid);

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());
		mv.addObject("MEM_NUM", session_mem_num);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderModifyForm")
	public ModelAndView orderModifyForm(CommandMap commandMap) throws Exception {
		log.debug("###### 배송으로 주문 수정 폼 ######");
		ModelAndView mv = new ModelAndView("orderModifyForm");

		Map<String, Object> orderMap = orderService.selectOrderDetail(commandMap.getMap());

		System.out.println("################# : " + (String) orderMap.get("ORDERS_PHONE"));

		String memPhone = (String) orderMap.get("ORDERS_PHONE");
		String phone1 = memPhone.substring(0, 3);
		String phone2 = memPhone.substring(3, 7);
		String phone3 = memPhone.substring(7);

		orderMap.put("ORDERS_PHONE1", phone1);
		orderMap.put("ORDERS_PHONE2", phone2);
		orderMap.put("ORDERS_PHONE3", phone3);

		mv.addObject("order", orderMap);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderModifyForm2")
	public ModelAndView orderModifyForm2(CommandMap commandMap) throws Exception {
		log.debug("###### 직거래로 주문 수정 폼 ######");
		ModelAndView mv = new ModelAndView("orderModifyForm2");

		Map<String, Object> orderMap = orderService.selectOrderDetail(commandMap.getMap());

		mv.addObject("order", orderMap);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderModify")
	public ModelAndView orderModify(CommandMap commandMap, HttpServletRequest request) throws Exception {
		log.debug("###### 주문 수정 ######");
		ModelAndView mv = new ModelAndView("redirect:/myShop/orderHistory");

		HttpSession session = request.getSession();
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		int session_mem_num = Integer.parseInt(map.get("MEM_NUM").toString());

		commandMap.put("MEM_NUM", session_mem_num);

		String phone1 = (String) commandMap.get("ORDERS_PHONE1");
		String phone2 = (String) commandMap.get("ORDERS_PHONE2");
		String phone3 = (String) commandMap.get("ORDERS_PHONE3");

		String phone = phone1 + phone2 + phone3;
		commandMap.put("ORDERS_PHONE", phone);

		orderService.updateOrderModify(commandMap.getMap());
		mv.addObject("MEM_NUM", session_mem_num);

		return mv;
	}

	@RequestMapping(value = "/shop/order/orderDelete")
	public ModelAndView orderDelete(CommandMap commandMap) throws Exception {
		log.debug("###### 주문 취소하기 ######");
		ModelAndView mv = new ModelAndView("redirect:/myShop/orderHistory");

		orderService.deleteOrder(commandMap.getMap());

		return mv;
	}
}
