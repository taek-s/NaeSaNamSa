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
		    <a class="nav-link link-dark" href="/ns/myShop/orderHistory">주문 내역</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link active" href="/ns/myShop/sellHistory">판매 내역</a>
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
    
    
          <!-- 판매 내역 리스트 -->
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
			    </tr>
			  </thead>
			  <tbody>
			  	<c:choose>
			  		<c:when test="${fn:length(sellList) > 0}" > <!-- order리스트(구매,판매 모두 포함) 가져와서 반복문으로 실행-->
			  			<c:forEach items="${sellList}" var="sell">
					  	 <tr>
					      <th scope="row">판매</th>
					      <td>${sell.GOODS_TSTATUS}</td>
					       <td class="title22" title="${sell.GOODS_TITLE}"><a class="text-dark" href="#" name="title" data-num="${sell.GOODS_NUM}">${sell.GOODS_TITLE}</a></td>
					      <td>${sell.ORDERS_DATE} ${sell.ORDERS_TIME}</td>
					      <td><a class="text-dark" href="#" name="ordersNum" data-num="${sell.ORDERS_NUM}" data-cost="${sell.ORDERS_DCOST}">${sell.ORDERS_NUM}</a></td>
					      <td><fmt:formatNumber value="${sell.ORDERS_DCOST}" type="number"/>원</td>
					      <td><fmt:formatNumber value="${sell.ORDERS_PRICE}" type="number"/>원</td>
					    </tr>
					   </c:forEach>
					</c:when>
			   </c:choose> 
			   
			  </tbody>
			</table>
		</div>
		<!-- 판매 내역 리스트 end -->
			
		<!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${mySellTotalListPaging.pagingHTML}
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
		comSubmit.addParam("tid", localStorage.getItem(num));
		comSubmit.submit();
	};
	
	
});
</script>
</body>
</html>