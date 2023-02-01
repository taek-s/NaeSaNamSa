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
              주문 상세보기(배송)
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
                <th scope="col">주문일자</th> 
                <th scope="col">주문번호</th> 
                <th scope="col">주문금액</th> 
                <th scope="col">배송비</th> 
                <th scope="col">최종결제금액</th> 
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">${order.GOODS_TITLE}</th> <!-- GOODS_TITLE -->
                <td>${order.ORDERS_DATE}&nbsp;${order.ORDERS_TIME}</td> <!-- ORDERS_DATE -->
                <td>${order.ORDERS_NUM}</td> <!-- ORDERS_NUM -->
                <td><fmt:formatNumber value="${order.ORDERS_PRICE}" type="number"/>원</td> <!-- ORDERS_PRICE -->
                <td><fmt:formatNumber value="${order.ORDERS_DCOST}" type="number"/>원</td> <!-- ORDERS_DCOST -->
                <td><fmt:formatNumber value="${order.ORDERS_TCOST}" type="number"/>원</td> <!-- ORDERS_TCOST -->
              </tr>
            </tbody>
          </table>
        </div>
        <!-- 상품정보 끝-->

        <hr style="border: solid 1px black" />

        <!-- 배송지 정보 -->
        <div class="row align-items-center">
          <div class="col-auto mt-3 mb-3">
            <h3
              class="fs-2 fw-semibold mb-0"
            >
              배송지 정보
            </h3>
          </div>
        </div>
        <!-- 배송지 정보 끝-->

        <!-- 이름 -->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">이름</label>
          <div class="col-sm-6">
            <input type="text" class="form-control" value="${order.MEM_NAME}" readonly /> <!-- value="MEM_NAME" -->
          </div>
        </div>
        <!-- 이름 끝-->

        <!-- 휴대전화 -->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">휴대폰 번호</label>
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE1" name="ORDERS_PHONE1" value="${order.ORDERS_PHONE1}" readonly /> <!-- value="ORDERS_PHONE1" -->
          </div>
          -
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE2" name="ORDERS_PHONE2" value="${order.ORDERS_PHONE2}" readonly /> <!-- value="ORDERS_PHONE2" -->
          </div>
          -
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE3" name="ORDERS_PHONE3" value="${order.ORDERS_PHONE3}" readonly /> <!-- value="ORDERS_PHONE3" -->
          </div>
        </div>

        <!-- 휴대전화 끝-->

        <!-- 배송주소-->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">우편번호</label>

          <div class="col-6">
            <input class="form-control" type="text" id="ORDERS_DZIPCODE" name="ORDERS_DZIPCODE" value="${order.ORDERS_DZIPCODE }" readonly /> <!-- value="ORDERS_DZIPCODE" -->
          </div>

        </div>

        <div class="row">
          <label for="inputAddress" class="col-sm-3 col-form-label fs-5"
            >주소</label
          >
          <div class="col-sm-6">
            <input type="text" class="form-control" id="ORDERS_DADD1" name="ORDERS_DADD1" value="${order.ORDERS_DADD1 }" readonly /> <!-- value="ORDERS_DADD1" -->
          </div>
        </div>

        <div class="row">
          <label for="inputAddress" class="col-sm-3 col-form-label fs-5"
            >상세주소</label
          >
          <div class="col-sm-6">
            <input type="text" class="form-control" id="ORDERS_DADD2" name="ORDERS_DADD2" value="${order.ORDERS_DADD2 }" readonly /> <!-- value="ORDERS_DADD2" -->
          </div>
        </div>

        <!-- 배송주소 끝-->

        <!-- 배송메모 -->
        <div class="row align-items-center">
          <div class="col-lg-3">
            <h3 class="fs-5">
              배송 메모
            </h3>
          </div>
          <div class="col-lg-7">
            <div class="form-floating">
              <textarea
                class="form-control"
                id="ORDERS_DMEMO"
                name="ORDERS_DMEMO"
                style="height: 200px"
                readonly
              >${order.ORDERS_DMEMO }</textarea>
              <label for="ORDERS_DMEMO"></label>
            </div>
          </div>
        </div>
        <!-- 배송메모 끝-->

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
                checked disabled
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
            <c:if test="${order.ORDERS_USER == MEM_NUM}">
	            <button type="button" class="btn btn-secondary me-4" name="history">
	              주문내역
	            </button>
	            <!-- 배송상태가 배송전일 경우에만 표시되도록 작성 -->
	            <button type="button" class="btn btn-warning me-4" name="orderModify" data-num="${order.ORDERS_NUM}">
	              주문수정
	            </button>
	        </c:if>
          </div>
        </div>
        <!-- 주문버튼 끝-->
      </form>
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	//주문 상세보기 페이지가 로드될 때, 웹 스토리지에 tid값 저장하기
	$(document).ready(function (){
		//주문번호 받아와서, 웹 스토리지에 key=주문번호, value=tid로 저장
		var orderNum = "${order.ORDERS_NUM}";
		localStorage.setItem("${order.ORDERS_NUM}", '${tid}');
	});
	
	$("button[name='main']").on("click", function(e) { // 메인으로
		e.preventDefault();
		fn_main();
	});
	
	$("button[name='history']").on("click", function(e) { // 주문내역으로
		e.preventDefault();
		fn_history();
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
	
	function fn_history() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myShop/orderHistory");
		comSubmit.submit();
	};
	
	function fn_orderModify() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/order/orderModifyForm");
		
		comSubmit.addParam("ORDERS_NUM", ${order.ORDERS_NUM});
		comSubmit.submit();
	};
	
});
</script>
  </body>
</html>
