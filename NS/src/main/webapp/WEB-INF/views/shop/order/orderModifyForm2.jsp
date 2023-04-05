<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <div class="container text-start p-5">
      <form
        id="orderForm"
      >
        <!-- 뒤로가기  -->
        <a href="javascript:history.back();" class="text-dark">
	        <svg
	          xmlns="http://www.w3.org/2000/svg"
	          width="65"
	          height="75"
	          fill="currentColor"
	          class="bi bi-arrow-left"
	          viewBox="0 0 16 16"
	        >
	          <path
	            fill-rule="evenodd"
	            d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"
	          />
	        </svg>
	    </a>
        <!-- 뒤로가기  끝-->

        <!-- 배송으로 구매하기 타이틀 -->
        <div class="row">
          <div class="col">
            <h2
              class="fs-1 fw-semibold"
            >
              주문 수정(직거래)
            </h2>
          </div>
        </div>
        <!-- 배송으로 구매하기 타이틀 끝-->

        <hr style="border: solid 1px black" />

        <!-- 상품정보 -->
        <div class="row flex-column">
          <div class="col-auto mt-3 mb-3">
            <h3
              class="fs-2 fw-semibold"
            >
              상품 정보
            </h3>
          </div>
          
          <table class="table">
            <thead class="table-info">
              <tr>
                <th scope="col">상품명</th> 
                <th scope="col">주문금액</th> 
                <th scope="col">최종결제금액</th> 
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">${order.GOODS_TITLE }</th> <!-- GOODS_TITLE -->
                <td><fmt:formatNumber value="${order.ORDERS_PRICE }" type="number"/>원</td> <!-- ORDERS_PRICE -->
                <td><fmt:formatNumber value="${order.ORDERS_TCOST }" type="number"/>원</td> <!-- ORDERS_TCOST -->
              </tr>
            </tbody>
          </table>
        </div>
        <!-- 상품정보 끝-->

        <hr style="border: solid 1px black" />

        <!-- 결제 정보 -->
        <div class="row">
          <div class="col-auto mt-3 mb-3">
            <h3
              class="fs-2 fw-semibold mb-0"
            >
              결제 정보
            </h3>
          </div>
        </div>

        <!-- 결제수단 -->
        <div class="row mb-2">
          <label class="col-sm-3 fs-5">결제 수단</label>
          <div class="col-auto text-start">
            <div class="form-check">
              <input
                class="form-check-input"
                type="radio"
                name="kakaopay"
                id="kakaopay"
                checked
              />
              <label class="form-check-label" for="kakaopay">
                카카오페이
              </label>
            </div>
          </div>
        </div>
        <!-- 결제수단 끝-->


        <!-- 주문버튼 -->
        <div class="row justify-content-center text-center mt-5">
          <div class="col-10">
            <button type="button" class="btn btn-primary me-4" name="main">
              메인으로
            </button>
            <button type="button" class="btn btn-danger me-4" name="orderDelete" data-num="${order.ORDERS_NUM}">
              주문취소
            </button>
            <!-- 배송상태가 배송전일 경우에만 표시되도록 작성 -->
           <!--   <button type="button" class="btn btn-warning me-4" name="orderModify" data-num="${order.ORDERS_NUM}">
              주문수정
            </button>-->
          </div>
        </div>
        <!-- 주문버튼 끝-->
      </form>
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='main']").on("click", function(e) { // 메인으로
		e.preventDefault();
		fn_main();
	});
	
	$("button[name='orderDelete']").on("click", function(e) { // 주문취소
		e.preventDefault();
		fn_orderDelete();
	});
	
	$("button[name='orderModify']").on("click", function(e) { // 주문 수정 폼으로
		e.preventDefault();
		fn_orderModify();
	});
	
	function fn_main() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/main");
		comSubmit.submit();
	};
	
	function fn_orderDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/kakaopay/cancel");
		comSubmit.addParam("ORDERS_NUM", ${order.ORDERS_NUM});
		comSubmit.addParam("ORDERS_PRONUM", ${order.ORDERS_PRONUM});
		comSubmit.addParam("tid", localStorage.getItem(${order.ORDERS_NUM}));
		alert("주문 및 결제가 취소되었습니다.");
		comSubmit.submit();
	};
	
	function fn_orderModify() {
		var comSubmit = new ComSubmit("orderForm");
		comSubmit.setUrl("/ns/shop/order/orderModify");
		/* comSubmit.addParam("ORDERS_NUM", ${ORDERS_NUM}); */
		comSubmit.addParam("ORDERS_NUM", ${order.ORDERS_NUM});
		comSubmit.submit();
	};
	
});
</script>
  </body>
</html>
