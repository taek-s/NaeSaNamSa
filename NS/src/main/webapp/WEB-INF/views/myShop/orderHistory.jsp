<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
td.title22{
white-space:nowrap;
overflow:hidden;
text-overflow:ellipsis;
max-width:200px;
}
</style>
</head>
<body>


<div class="container text-start">
  
	  <!-- 내상점 상단 링크 -->
 	 <div class="row pt-4 pb-4" >
	    <ul class="nav nav-tabs" style="font-size:15px;">
		  <li class="nav-item">
		    <a class="nav-link link-dark" aria-current="page" href="/ns/myShop">상품 관리</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link active" href="/ns/myShop/orderHistory">주문 내역</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/sellHistory">판매 내역</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/goodsLikeList">찜목록</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/recentGoodsList">최근 본 상품</a>
		  </li>
		</ul>
	  </div>
  <!-- 내상점 상단 링크 end -->
    
	
    
          <!-- 주문 내역 리스트 -->
          <div class="row">
          	<table class="table" style="font-size:13px">
			  <thead class="table-secondary">
			    <tr>
			      <th scope="col">구분</th>
			      <th scope="col">상태</th>
			      <th scope="col">상품명</th>
			      <th scope="col">주문일자</th>
			      <th scope="col">주문번호</th>
			      <th scope="col">배송비</th>
			      <th scope="col">주문금액</th>
			      <th scope="col">주문취소</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:choose>
			  		<c:when test="${fn:length(orderList) > 0}" > <!-- order리스트(구매,판매 모두 포함) 가져와서 반복문으로 실행-->
			  			<c:forEach items="${orderList}" var="orders">
					  	 <tr>
						  <!-- 주문 목록에서 MEM_NUM(로그인한 회원번호)과 GOODS_SELLER(상품 판매자 회원번호) 같으면 판매, 다르면 구매 -->
					      <!-- 로그인한 사람의 회원 번호가 4번이라고 할 때,
							   10000000474 주문자 회원번호 4 판매자 회원번호 1 -> 4번 회원이 구매한 것
							   10000000237 주문자 회원번호 1 판매자 회원번호 4 -> 4번 회원이 판매한 것-->
						  <th scope="row">구매</th>
					      <td>${orders.ORDERS_STATUS}</td>
					      <td class="title22" title="${orders.GOODS_TITLE}"><a id="goodsNum" class="text-dark" href="#" name="title" data-num="${orders.GOODS_NUM}">${orders.GOODS_TITLE}</a></td>
					      <td>${orders.ORDERS_DATE} ${orders.ORDERS_TIME}</td>
					      <td><a class="text-dark" href="#" name="ordersNum" data-num="${orders.ORDERS_NUM}" data-cost="${orders.ORDERS_DCOST}">${orders.ORDERS_NUM}</a></td>
					      <td><fmt:formatNumber value="${orders.ORDERS_DCOST}" type="number"/>원</td>
     					  <td><fmt:formatNumber value="${orders.ORDERS_TCOST}" type="number"/>원</td>
					      <td> <!-- 주문 수정/취소 버튼은 ORDERS_STATUS가 '결제 완료'일 경우 && ${GOODS_SELLER}가 본인이 아닌 경우에만 표시 -->
					      	<c:if test="${MEM_NUM != orders.GOODS_SELLER && orders.ORDERS_STATUS =='결제 완료' && orders.ORDERS_DADD1 != '직거래'}">
					      		<button type="button" class="btn-sm btn-warning" name="orderModifyForm" data-num="${orders.ORDERS_NUM}" data-type="${orders.ORDERS_DZIPCODE}">수정</button>
					      		<button type="button" class="btn-sm btn-danger" name="orderDelete" data-num="${orders.ORDERS_NUM}">취소</button>
					      	</c:if>
					      </td>
					    </tr>
					   </c:forEach>
					</c:when>
			   </c:choose> 
			   
			  </tbody>
			</table>
		</div>
		<!-- 주문 내역 리스트 end -->
			
		<!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${myOrderTotalListPaging.pagingHTML}
			</nav>
		<!-- 페이징 끝-->
          
</div>
          
<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='title']").on("click", function(e) { // 상품 상세보기
		e.preventDefault();
		const num = $(this).attr('data-num');
		console.log(num);
		fn_goodsDetail(num);
	});
	
	$("a[name='ordersNum']").on("click", function(e) { // 주문 상세보기
		e.preventDefault();
		const num = $(this).attr('data-num');
		const cost = $(this).attr('data-cost');
		console.log(num);
		console.log(cost);
		fn_orderDetail(num, cost);
	});
	
	$("button[name='orderModifyForm']").on("click", function(e) { // 주문 수정 폼
		e.preventDefault();
		const num = $(this).attr('data-num');
		const type = $(this).attr('data-type');
		console.log(num);
		console.log(type);
		fn_orderModifyForm(num, type);
	});
	
	$("button[name='orderDelete']").on("click", function(e) {  // 주문 취소
		e.preventDefault();
		const num = $(this).attr('data-num');
		const goodsNum = $("#goodsNum").attr('data-num');
		console.log(num);
		fn_orderDelete(num, goodsNum);
	});
	
	function fn_goodsDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDetail");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
	function fn_orderDetail(num, cost) {
		var comSubmit = new ComSubmit();
		if(cost != 0) {
			comSubmit.setUrl("/ns/shop/order/orderDetail");
		} else if(cost == 0) {
			comSubmit.setUrl("/ns/shop/order/orderDetail2");
		}             															
		comSubmit.addParam("ORDERS_NUM", num);
		comSubmit.addParam("tid", localStorage.getItem(num)); // 카카오페이로 결제 안한 주문이면 여기서 null 들어감
		//alert(localStorage.getItem(num));
		comSubmit.submit();
	};
	
	function fn_orderModifyForm(num, type) {
		var comSubmit = new ComSubmit();
		if(type != 0) {
			comSubmit.setUrl("/ns/shop/order/orderModifyForm");
		} else if(type == 0) {
			comSubmit.setUrl("/ns/shop/order/orderModifyForm2");
		}
		comSubmit.addParam("ORDERS_NUM", num);
		comSubmit.addParam("tid", localStorage.getItem(num));
		comSubmit.submit();
	};
	
	function fn_orderDelete(num, goodsNum) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/kakaopay/cancel");
		comSubmit.addParam("ORDERS_NUM", num);
		comSubmit.addParam("ORDERS_PRONUM", goodsNum);
		comSubmit.addParam("tid", localStorage.getItem(num));
		alert("주문 및 결제가 취소되었습니다.");
		
		comSubmit.submit();
	};
});
</script>
</body>
</html>