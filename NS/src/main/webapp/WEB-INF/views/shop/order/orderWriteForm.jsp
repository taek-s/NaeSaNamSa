<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
              배송으로 구매하기
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
                <th scope="row">${goods.GOODS_TITLE }</th> <!-- GOODS_TITLE -->
                <td><fmt:formatNumber value="${goods.GOODS_PRICE }" type="number"/></td> <!-- ORDERS_PRICE -->
                <td><fmt:formatNumber value="${goods.GOODS_DCOST }" type="number"/></td> <!-- ORDERS_DCOST -->
                <td><fmt:formatNumber value="${goods.GOODS_PRICE + goods.GOODS_DCOST}" type="number"/></td> <!-- ORDERS_TCOST -->
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
            <input type="text" class="form-control" value="${member.MEM_NAME }" readonly /> <!-- MEM_NAME -->
          </div>
        </div>
        <!-- 이름 끝-->

        <!-- 휴대전화 -->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">휴대폰 번호</label>
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE1" name="ORDERS_PHONE1" value="${member.MEM_PHONE1 }" minlength="3" maxlength="3"  required/>
          	 <div class="invalid-feedback text-start">
	        	전화번호를 입력해주세요
	      	 </div>
          </div>
          -
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE2" name="ORDERS_PHONE2" value="${member.MEM_PHONE2 }" minlength="3" maxlength="4"  required/>
          	 <div class="invalid-feedback text-start">
	        	전화번호를 입력해주세요
	      	 </div>
          </div>
          -
          <div class="col-2">
            <input type="text" class="form-control" id="ORDERS_PHONE3" name="ORDERS_PHONE3" value="${member.MEM_PHONE3 }" minlength="4" maxlength="4" required/>
           	 <div class="invalid-feedback text-start">
	        	전화번호를 입력해주세요
	      	 </div>
          </div>
        </div>
        <!-- 휴대전화 끝-->
        
        <!-- 배송주소-->
        <div class="row">
          <label class="col-sm-3 col-form-label fs-5">우편번호</label>

          <div class="col-6">
            <input class="form-control" type="text" id="ORDERS_DZIPCODE" name="ORDERS_DZIPCODE" value="${member.MEM_ZIP }" required readonly/>
          	<div class="invalid-feedback text-start">
	        	우편번호를 입력해주세요
	      	 </div>
          </div>

          <div class="col-3">
            <button type="button" class="btn btn-primary" onclick="sample6_execDaumPostcode()">
              우편번호 검색
            </button>
          </div>
        </div>

        <div class="row">
          <label for="inputAddress" class="col-sm-3 col-form-label fs-5" 
            >주소</label
          >
          <div class="col-sm-7">
            <input type="text" class="form-control" id="ORDERS_DADD1" name="ORDERS_DADD1" value="${member.MEM_ADD1 }" required/>
          	 <div class="invalid-feedback text-start">
	        	주소를 입력해주세요
	      	 </div>
          </div>
        </div>

        <div class="row">
          <label for="inputAddress" class="col-sm-3 col-form-label fs-5"
            >상세주소</label
          >
          <div class="col-sm-7">
            <input type="text" class="form-control" id="ORDERS_DADD2" name="ORDERS_DADD2" value="${member.MEM_ADD2 }" required/>
          	<div class="invalid-feedback text-start">
	        	상세주소를 입력해주세요
	      	 </div>
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
              ></textarea>
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
                required
              />
              <label class="form-check-label" for="kakaopay">
                카카오페이 <img src="<%=request.getContextPath() %>/image/payment_icon_yellow_small.jpg" width="50" height="20">
              </label>
              <div class="invalid-feedback text-start">
	        	결제 수단을 선택해주세요
	      	 </div>
            </div>
          </div>
        </div>
        <!-- 결제수단 끝-->

        <!-- 결제안내 -->
        <div class="row mb-2">
          <label class="col-sm-3 col-form-label fs-5">결제 안내</label>
          <div class="col-sm-6">
            <textarea class="form-control" id="inputInfo" cols="5" rows="5" readonly>고객에 온라인 쇼핑몰에서 상품 및 서비스를 신용카드로 진행하는 결제 서비스입니다. 
카드번호 유효기간 등의 신용정보는 안전하게 암호화되어 해당 신용카드사로 전달됩니다.
            </textarea>
          </div>
        </div>
        <!-- 결제안내 끝-->

        <!-- 주문자 동의 -->
        <div class="row mb-2">
          <label class="col-sm-3 fs-5">주문자 동의</label>
          <div class="col-4">
            <div class="form-check">
              <input
                class="form-check-input"
                type="checkbox"
                value=""
                id="agreement1"
                required
              />
              <label class="form-check-label" for="agreement1">
                개인정보 제3자 제공 동의 (필수)
              </label>
              <div class="invalid-feedback text-start">
	        	주문자 동의에 체크해야 결제가 가능합니다
	      	 </div>
            </div>
          </div>
        </div>

        <div class="col-12 mb-3">
          <label for="exampleFormControlTextarea1" class="form-label"></label>
          <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" readonly>
제1조(목적)

이 약관은 내사남사(전자상거래 사업자)가 운영하는 내사남사몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.

※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」


제2조(정의)

①“몰” 이란 내사남사가 재화 또는 용역(이하 “재화등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터등 정보통신설비를 이용하여 재화등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.

②“이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.

③ ‘회원’이라 함은 “몰”에 개인정보를 제공하여 회원등록을 한 자로서, “몰”의 정보를 지속적으로 제공받으며, “몰”이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.

④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.


제3조 (약관등의 명시와 설명 및 개정)

① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호·모사전송번호·전자우편주소, 사업자등록번호, 통신판매업신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 내사남사 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.

② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회·배송책임·환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.

③ “몰”은 전자상거래등에서의소비자보호에관한법률, 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률, 방문판매등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.

④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다.

다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰“은 개정전 내용과 개정후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.

⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간내에 ‘몰“에 송신하여 ”몰“의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.

⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의소비자보호에관한법률, 약관의규제등에관한법률, 공정거래위원회가 정하는 전자상거래등에서의소비자보호지침 및 관계법령 또는 상관례에 따릅니다.


제4조(서비스의 제공 및 변경)

① “몰”은 다음과 같은 업무를 수행합니다.

1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결

2. 구매계약이 체결된 재화 또는 용역의 배송

3. 기타 “몰”이 정하는 업무

②“몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.

③“몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.

④전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</textarea>
        </div>

        <div class="col-10 mb-3">
          <div class="form-check">
            <input
              class="form-check-input"
              type="checkbox"
              value=""
              id="agreement2"
              required
            />
            <label class="form-check-label" for="agreement2">
              위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에
              동의합니다.(필수)
            </label>
            <div class="invalid-feedback text-start">
	        	구매 진행 동의에 체크해야 결제가 가능합니다
	      	 </div>
          </div>
        </div>
        <!-- 주문자 동의 끝-->

        <!-- 주문버튼 -->
        <div class="row justify-content-center">
          <div class="col-3 d-grid mx-auto">
            <button type="button" class="btn btn-secondary fs-4" name="order">
              주문하기
            </button>
          </div>
        </div>
        <!-- 주문버튼 끝-->
      </form>
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	//카카오페이 결제
	function fn_order() {
		var comSubmit = new ComSubmit("orderForm");
		comSubmit.setUrl("/ns/kakaopay");
		
		var orderNum = ${maxOrderNum} + 237;
		
		comSubmit.addParam("GOODS_NUM", ${GOODS_NUM});
		comSubmit.addParam("ORDERS_PRICE", ${goods.GOODS_PRICE});
		comSubmit.addParam("ORDERS_DCOST", ${goods.GOODS_DCOST});
		comSubmit.addParam("ORDERS_TCOST", ${goods.GOODS_DCOST + goods.GOODS_PRICE});
		comSubmit.addParam("GOODS_TITLE", '${goods.GOODS_TITLE}');															
		comSubmit.addParam("ORDERS_NUM", orderNum);
		comSubmit.addParam("ORDERS_USER", ${MEM_NUM});
		comSubmit.addParam("ORDERS_PHONE", '${MEM_PHONE}');
		comSubmit.addParam("sellerNum", ${seller});
		
		comSubmit.submit();
	};
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

	  // Loop over them and prevent submission
	 $("button[name='order']").on("click", function(e) { // 주문하기
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		fn_order();
	  });
		  
	})()
	
});
</script>
  </body>
</html>
