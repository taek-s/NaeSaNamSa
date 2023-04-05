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
                document.getElementById('MEM_ZIP').value = data.zonecode;
                document.getElementById("MEM_ADD1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("MEM_ADD2").focus();
            }
        }).open();
    }
</script>
  </head>
  <body>
  
    <div class="container text-start pt-5 pb-5">
      <div class="row text-center mb-4">
        <h2 class="fs-1 fw-semibold">
          회원 수정
        </h2>
      </div>

      <form id="accountModifyForm" class="needs-validation" novalidate>

        <div class="mb-4 row">
          <label for="staticEmail" class="col-sm-2 col-form-label"
            >닉네임</label
          >
          <div class="col-sm-10">
            <input
              class="form-control"
              type="text"
              value="${MEMBER.MEM_NICKNAME }"
              aria-label="Disabled input example"
              disabled
              readonly
            />
          </div> 
        </div>
        
        <div class="mb-4 row">
          <label for="staticEmail" class="col-sm-2 col-form-label"
            >휴대폰 번호</label
          >
          <div class="col-2">
            <input
              type="text"
              class="form-control"
              aria-label="f"
              value="${MEMBER.MEM_PHONE1}"
              id="MEM_PHONE1"
              name="MEM_PHONE1"
              pattern="^01([0|1|6|7|8|9])$"
              minlength="3"
              maxlength="3"
              required
            />
            <div id="phone-null" class="invalid-feedback">
		      전화번호를 입력해주세요
		  	</div>
		  	<div id="phone-type" class="invalid-feedback">
		      01*의 형식으로 입력해주세요
		  	</div>
          </div>
          -
          <div class="col-2">
            <input
              type="text"
              class="form-control"
              aria-label="m"
              value="${MEMBER.MEM_PHONE2}"
              id="MEM_PHONE2"
              name="MEM_PHONE2"
              pattern="[0-9]+"
              minlength="4"
              maxlength="4"
              required
            />
            <div class="invalid-feedback">
		      전화번호를 입력해주세요
		  	</div>
          </div>
          -
          <div class="col-2">
            <input
              type="text"
              class="form-control"
              placeholder="1111"
              aria-label="e"
              value="${MEMBER.MEM_PHONE3}"
              id="MEM_PHONE3"
              name="MEM_PHONE3"
              pattern="[0-9]+"
              minlength="4"
              maxlength="4"
              required
            />
            <div class="invalid-feedback">
		      전화번호를 입력해주세요
		  	</div>
          </div>
        </div>


        <div class="mb-4 row">
          <label for="staticEmail" class="col-sm-2 col-form-label"
            >우편번호</label
          >

          <div class="col-4">
            <input
              class="form-control"
              type="text"
              value="${MEMBER.MEM_ZIP }"
              aria-label="우편번호"
              id="MEM_ZIP"
              name="MEM_ZIP"
            />
          </div>

          <div class="col-auto">
            <button type="button" class="btn btn-primary" onclick="sample6_execDaumPostcode()">우편번호 검색</button> <!-- 다음API 적용 예정 -->
          </div>
        </div>

        <div class="mb-4 row">
          <label for="inputADD1" class="col-sm-2 col-form-label"
            >주소</label
          >
          <div class="col-sm-10">
            <input type="text" class="form-control" value="${MEMBER.MEM_ADD1 }" id="MEM_ADD1" name="MEM_ADD1" />
          </div>
        </div>

        <div class="mb-4 row">
          <label for="inputADD2" class="col-sm-2 col-form-label"
            >상세주소</label
          >
          <div class="col-sm-10">
            <input type="text" class="form-control" value="${MEMBER.MEM_ADD2 }" id="MEM_ADD2" name="MEM_ADD2" />
          </div>
        </div>

        <div class="row justify-content-end mt-5">
          <button type="button" class="btn btn-secondary col-2 me-3" name="accountModify">
            회원 정보 수정
          </button>

          <button type="button" class="btn btn-secondary col-2" name="myPageMain">취소</button>
        </div>
      </form>
    </div>

<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='myPageMain']").on("click", function(e) {  // 마이페이지 메인으로
		e.preventDefault();
		fn_myPageMain();
	});
	
	function fn_accountModify() {
		var comSubmit = new ComSubmit("accountModifyForm");
		comSubmit.setUrl("/ns/myPage/accountModify");
		comSubmit.addParam("kakao", "Y");
		comSubmit.submit();
	};
	
	function fn_myPageMain() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/main");
		comSubmit.submit();
	};
	
	(() => {
		  'use strict'

		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  const form = document.querySelector('.needs-validation')

		  // Loop over them and prevent submission
		  
		  $("button[name='accountModify']").on("click", function(e) {  // 회원 정보 수정
			  e.preventDefault();
			  form.classList.add('was-validated')
			  var validate = true;
		      
		      let phone1 = $('#MEM_PHONE1').val()
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
		    	  fn_accountModify();
		      }
		   });
		})()
	
});
</script>    
    
  </body>
</html>
