<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>

<!-- findId modal -->
<div class="modal fade" id="findIdModal" tabindex="-1" aria-labelledby="findIdModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="findIdModalLabel">아이디 찾기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="findIdmodalForm" name="findIdmodalForm" class="needs-validation2" novalidate>
      <div class="modal-body">
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label top">이름</label>
            <input type="text" class="form-control" id="MEM_NAME1" name="MEM_NAME1" required>
            <div class="invalid-feedback">
		        이름을 입력해주세요.
		    </div>
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label bottom">생년월일</label>
            <input type="date" class="form-control" id="MEM_BIRTH" name="MEM_BIRTH" required> <!-- 아이디찾기 혹은 비밀번호 찾기 선택에 따라 input type이 달라지도록 작성 필요 -->
            <div class="invalid-feedback">
		        생년월일을 입력해주세요.
		    </div>
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label top">연락처</label>
            <input type="text" class="form-control" id="MEM_PHONE" name="MEM_PHONE" required>
            <div class="invalid-feedback">
		        가입하신 휴대폰번호를 입력해주세요.
		    </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary findId" name="findId" id="findId">아이디 찾기</button>
      </div>
      </form>
    </div>
  </div>
</div>
<!-- modal end -->

<!-- findPw modal -->
<div class="modal fade" id="findPwModal" tabindex="-1" aria-labelledby="findPwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="findPwModalLabel">비밀번호 찾기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="findPwmodalForm" name="findPwmodalForm" class="needs-validation3" novalidate>
      <div class="modal-body">
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label top">이름</label>
            <input type="text" class="form-control" id="MEM_NAME2" name="MEM_NAME2" required>
            <div class="invalid-feedback">
		        이름을 입력해주세요
		    </div>
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label bottom">이메일</label>
            <input type="email" class="form-control" id="MEM_EMAIL" name="MEM_EMAIL" required> <!-- 아이디찾기 혹은 비밀번호 찾기 선택에 따라 input type이 달라지도록 작성 필요 -->
            <div class="invalid-feedback">
		        이메일을 입력해주세요
		    </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary findPw" name="findPw" id="findPw">비밀번호 찾기</button>
      </div>
      </form>
    </div>
  </div>
</div>
<!-- modal end -->

<!-- findIdResult modal -->
<div class="modal fade" id="findIdResultModal" aria-hidden="true" aria-labelledby="findIdResultModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="findIdResultModalToggleLabel">아이디 찾기 결과</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body findIdResultDiv">
        회원 정보가 없습니다.
      </div>
      <div class="modal-footer">
     	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button class="btn btn-primary" data-bs-target="#findPwModal" data-bs-toggle="modal">비밀번호 찾기</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->

<!-- findPwResult modal -->
<div class="modal fade" id="findPwResultModal" aria-hidden="true" aria-labelledby="findPwResultModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="findPwResultModalToggleLabel">비밀번호 찾기 결과</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body findPwResultDiv">
        회원 정보가 없습니다.
      </div>
      <div class="modal-footer">
     	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->

<main class="form-signin w-50 m-auto pt-5 pb-5 text-center">
  <form action="/ns/login" method="post" name="myform" class="needs-validation1" novalidate>
    <img src="<%=request.getContextPath() %>/image/logo.png" width="100" height="100"/>
    <h1 class="h3 mb-3 fw-normal">ID/PW 로그인</h1>

    <div class="form-floating mb-2">
      <input type="email" name="mem_email" id="mem_email" class="form-control" id="floatingInput" placeholder="name@example.com" required/>
      <label for="floatingInput">Email address</label>
	      <div class="invalid-feedback text-start">
		        아이디를 입력해주세요
		  </div>
	      
    </div>
    <div class="form-floating mb-2">
      <input type="password" name="mem_pw" id="mem_pw" class="form-control" id="floatingPassword" placeholder="Password" required/>
      <label for="floatingPassword">Password</label>
	      <div class="invalid-feedback text-start">
		        비밀번호를 입력해주세요
		  </div>
    </div>

    <div class="checkbox mb-3">
      <label>
        <input type="checkbox" name="loginCheck" value="remember-me"> 로그인 상태 유지
      </label>
    </div>
   <!--  <button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button> -->
    <button class="w-100 btn btn-lg btn-primary" type="submit" name="login">로그인</button>
    
    <nav class="nav justify-content-center mt-4">
		<ul class="nav justify-content-center">
		  <li class="nav-item">
		    <a class="nav-link fs-5" aria-current="page" href="#" data-bs-toggle="modal" data-bs-target="#findPwModal">비밀번호 찾기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link fs-5 disabled" href="#">|</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link fs-5" href="#" data-bs-toggle="modal" data-bs-target="#findIdModal">아이디 찾기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link fs-5 disabled" href="#">|</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link fs-5" href="/ns/joinForm">회원가입</a>
		  </li>
		</ul>
	</nav>
	
  </form>
</main>

<script>
	
$(document).ready(function() {  
	// 아이디, 비밀번호 찾기 결과가 화면에 바로 노출되려면 fn_findId() fn_findPw() 함수에
	// ajax를 추가하여 수정 필요, 현재 결과 페이지는 임시
	
	//로그인, 아이디찾기, 비밀번호 찾기 유효성 검증 관련 버튼 click은 맨 아래쪽에 로직있음
	
});	

	function fn_checkLogin() {

		   var formData = new FormData();
	       var MEM_EMAIL = $('#mem_email').val();
	       var MEM_PW = $('#mem_pw').val();
	       var useCookie = $('input:checkbox[name="checkbox_name"]').is(":checked");
	     //  var loginData = {"MEM_EMAIL" : MEM_EMAIL, "MEM_PW": MEM_PW };
	         
	        formData.append("MEM_EMAIL", MEM_EMAIL);
	        formData.append("MEM_PW", MEM_PW);
	     
	     if($('input:checkbox[name="loginCheck"]').is(":checked") == true ) {
	    	  formData.append("useCookie", true);
	      }
	      
	        $.ajax({
	            url:"<c:url value='/login'/>",
	            type:'post',
	            data:formData,
	            processData:false,
	            contentType:false,
	            success:function(data) {
	            	
	               if(data == "emailfail") {
	                  alert("존재하지 않는 아이디입니다.");
	               } else if(data == "pwfail") {
	                  alert("비밀번호가 일치하지 않습니다.");
	               } else if(data == "success"){
	            	   location.href="<c:url value='/main'/>";
	               } else if(data == "suspended") {
	            	   alert("활동이 중지되어 로그인 하실 수 없습니다. \n관리자에게 문의하세요.");
	               }
	               
	            },
	            error:function() {
	               alert("에러입니다.");
	            }
	            
	         }); 
	};
	
	function fn_findId() { //아이디찾기
	
	       var MEM_NAME = $('#MEM_NAME1').val();
	       var MEM_BIRTH = $('#MEM_BIRTH').val();
	       var MEM_PHONE = $('#MEM_PHONE').val();
	       var findData = {"MEM_NAME" : MEM_NAME, "MEM_BIRTH": MEM_BIRTH, "MEM_PHONE": MEM_PHONE};
	       
	         
	        $.ajax({
	            url:"<c:url value='/findId'/>",
	            type:'post',
	            data:findData,
	            success:function(data) {
	            	if(data != null) {
	            		$(".findIdResultDiv").empty();
	            		$(".findIdResultDiv").append(MEM_NAME+"님의 아이디는 "+data["MEM_EMAIL"]+" 입니다.");
	            		$("#findIdModal").modal("hide");
	            		$("#findIdResultModal").modal("show");
	            	}
	            },
	            error:function() {
	            	$(".findIdResultDiv").empty();
            		$(".findIdResultDiv").append("입력하신 정보와 일치한 회원정보가 없습니다.");
            		$("#findIdModal").modal("hide");
            		$("#findIdResultModal").modal("show");
	            }
	         }); 
	};
		
	function fn_findPw() { //비밀번호찾기
		
	       var MEM_NAME = $('#MEM_NAME2').val();
	       var MEM_EMAIL = $('#MEM_EMAIL').val();
	       var findData = {"MEM_NAME" : MEM_NAME, "MEM_EMAIL": MEM_EMAIL};
	         
	        $.ajax({
	            url:"<c:url value='/findPw'/>",
	            type:'post',
	            data:findData,
	            success:function(data) {
	            	if(data != null) {
	            		$(".findPwResultDiv").empty();
	            		$(".findPwResultDiv").append(MEM_NAME+"님의 비밀번호는 "+data["MEM_PW"]+" 입니다.");
	            		$("#findPwModal").modal("hide");
	            		$("#findPwResultModal").modal("show");
	            	}
	            },
	            error:function() {
	            	$(".findPwResultDiv").empty();
            		$(".findPwResultDiv").append("입력하신 정보와 일치한 회원정보가 없습니다.");
            		$("#findPwModal").modal("hide");
            		$("#findPwResultModal").modal("show");
	            }
	            
	         }); 
	  
	};
	
	
	function begin() {
		document.myform.mem_email.focus();
	};

	// 로그인 버튼 누를 시, 유효성 검증
	// Example starter JavaScript for disabling form submissions if there are invalid fields
	(() => {
	  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form1 = document.querySelector('.needs-validation1');
	  const form2 = document.querySelector('.needs-validation2');
	  const form3 = document.querySelector('.needs-validation3');
	 

	  // Loop over them and prevent submission
	  $("button[name='login']").on("click", function(e) {  // 로그인 버튼 누르면
		e.preventDefault();
		form1.classList.add('was-validated')
		
		if (!form1.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		fn_checkLogin();
		});
	  
	  $("button[name='findId']").on("click", function(e) { // 아이디 찾기 
			e.preventDefault();
			form2.classList.add('was-validated')
			
			if (!form2.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		        return false;
		    }
		  
			fn_findId();
		  });
	  
	  $("button[name='findPw']").on("click", function(e) {  // 비밀번호 찾기
			e.preventDefault();
			form3.classList.add('was-validated')
			
			if (!form3.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		        return false;
		    }
		  	
			fn_findPw();
		  });
	  
	  

	})()	
	
	
</script>
</body>
</html>