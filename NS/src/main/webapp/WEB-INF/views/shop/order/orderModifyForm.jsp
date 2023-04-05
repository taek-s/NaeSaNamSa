<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('ORDERS_DZIPCODE').value = data.zonecode;
                document.getElementById("ORDERS_DADD1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("ORDERS_DADD1").focus();
            }
        }).open();
    }
</script>
  </head>
  <body>
    <div class="container text-start p-5">
      <form
        id="orderForm"
        class="needs-validation" novalidate
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
              주문 수정(배송)
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
                <th scope="col">배송비</th> 
                <th scope="col">최종결제금액</th> 
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">${order.GOODS_TITLE }</th> <!-- GOODS_TITLE -->
                <td><fmt:formatNumber value="${order.ORDERS_PRICE }" type="number"/>원</td> <!-- ORDERS_PRICE -->
                <td><fmt:formatNumber value="${order.ORDERS_DCOST }" type="number"/>원</td> <!-- ORDERS_DCOST -->
                <td><fmt:formatNumber value="${order.ORDERS_TCOST }" type="number"/>원</td> <!-- ORDERS_TCOST -->
              </tr>
            </tbody>
          </table>
        </div>
        <!-- 상품정보 끝-->

        <hr style="border: solid 1px black" />

		<!-- 세션의 회원정보를 가져와서 입력폼에 넣을 수 있음 -->
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
            <input type="text" class="form-control" value="${order.MEM_NAME}" readonly /> <!-- MEM_NAME -->
          </div>
        </div>
        <!-- 이름 끝-->

        <!-- 휴대전화 -->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">휴대폰 번호</label>
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE1" name="ORDERS_PHONE1" pattern="^01([0|1|6|7|8|9])$" minlength="3" maxlength="3" required value="${order.ORDERS_PHONE1}"/>
            <div id="phone-null" class="invalid-feedback">
		      전화번호를 입력해주세요
		  	</div>
		  	<div id="phone-type" class="invalid-feedback">
		      01*의 형식으로 입력해주세요
		  	</div>
          </div>
          -
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE2" name="ORDERS_PHONE2" pattern="[0-9]+" minlength="4" maxlength="4" required value="${order.ORDERS_PHONE2}"/>
            <div class="invalid-feedback">
		      전화번호를 입력해주세요
		  	</div>
          </div>
          -
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE3" name="ORDERS_PHONE3" pattern="[0-9]+" minlength="4" maxlength="4" required value="${order.ORDERS_PHONE3}"/>
            <div class="invalid-feedback">
		      전화번호를 입력해주세요
		  	</div>
          </div>
        </div>

        <!-- 휴대전화 끝-->

        <!-- 배송주소-->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">우편번호</label>

          <div class="col-6">
            <input class="form-control" type="text" id="ORDERS_DZIPCODE" name="ORDERS_DZIPCODE" value="${order.ORDERS_DZIPCODE }" required/>
          </div>

          <div class="col-3">
            <button type="buttom" class="btn btn-primary" onclick="sample6_execDaumPostcode()">
              우편번호 검색
            </button>
          </div>
        </div>

        <div class="row">
          <label for="inputAddress" class="col-sm-3 col-form-label fs-5"
            >주소</label
          >
          <div class="col-sm-6">
            <input type="text" class="form-control" id="ORDERS_DADD1" name="ORDERS_DADD1" value="${order.ORDERS_DADD1 }" required/>
          </div>
        </div>

        <div class="row">
          <label for="inputAddress" class="col-sm-3 col-form-label fs-5"
            >상세주소</label
          >
          <div class="col-sm-6">
            <input type="text" class="form-control" id="ORDERS_DADD2" name="ORDERS_DADD2" value="${order.ORDERS_DADD2 }" required/>
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
            <button type="button" class="btn btn-danger me-4" name="orderDelete"data-num="${order.ORDERS_NUM}">
              주문취소
            </button>
            <!-- 배송상태가 배송전일 경우에만 표시되도록 작성 -->
            <button type="button" class="btn btn-warning me-4" name="orderModify" data-num="${order.ORDERS_NUM}">
              주문수정
            </button>
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
		
		comSubmit.addParam("ORDERS_NUM", ${order.ORDERS_NUM});
		comSubmit.submit();
	};
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

	  // Loop over them and prevent submission
	  $("button[name='orderModify']").on("click", function(e) {  // 주문 수정
		e.preventDefault();
	  
		form.classList.add('was-validated');
		var validate = true;
		
		  let phone1 = $('#ORDERS_PHONE1').val()
	      let phonecheck = /^01([0|1|6|7|8|9])$/;
	      
	      if(phone1 == null || $.trim(phone1) == "") {
	    	  $("#phone-null").show();
			  $("#phone-type").hide();
		      $("#MEM_PHONE1").focus();
		      validate = false;
	      } else if(!phonecheck.test(phone1)) {
	    	  $("#phone-null").hide();
			  $("#phone-type").show();
		      $("#MEM_PHONE1").focus();
		      validate = false;
	      } else {
	    	  $("#phone-null").hide();
			  $("#phone-type").hide();
	      }
	  	
		if (!form.checkValidity()) {
	        e.preventDefault()
	        e.stopPropagation()
	        validate = false;
	    }
		
		if(validate) {
			fn_orderModify();
		}
	  });

	})()
	
});
</script>
  </body>
</html>
