<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<div class="container text-start pt-5 pb-5">

	<div class="row d-flex justify-content-center mb-4">
		<div class="col-auto">
    		<img src="<%=request.getContextPath() %>/image/logo.png" width="100" height="100"/>
    	</div>
    </div>

	<div class="row text-center mb-4">
        <h2 class="fs-1 fw-semibold">내사남사 로그인</h2>
    </div>
    
    <div class="row text-center mb-3 justify-content-center">
    	<div class="col-4">
    		<button type="button" class="btn btn-warning btn-block" name="kakaoLogin"
    		onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=b3fcf64864d96f4d4de5224fb6d56b33&redirect_uri=http://localhost:8080/ns/loginKakao&response_type=code'">
    		카카오로 시작하기</button>
    	</div>
    </div>
    
    <div class="row text-center mb-3 justify-content-center">
	    <div class="col-4">
	    	<button type="button" class="btn btn-success btn-block" name="naverLogin">네이버로 시작하기</button>
	    </div>
    </div>
    
    <div class="row text-center mb-3 justify-content-center">
	    <div class="col-4">
	    	<button type="button" class="btn btn-dark btn-block" name="login">ID/PW로 시작하기</button>
	    </div>
    </div>
    
    
    </div>
 
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='login']").on("click", function(e) {  // ID/PW로 시작하기
		e.preventDefault();
		fn_loginForm();
	});
	
	$("button[name='naverLogin']").on("click", function(e) {  // naver로 로그인
		e.preventDefault();
		fn_naverLogin();
	});
	
	
	function fn_loginForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/loginForm");
		comSubmit.submit();
	};
	
	function fn_naverLogin() {
		var comSubmit = new ComSubmit();
		
		var str = 'https://nid.naver.com/oauth2.0/authorize?response_type=code&'; // naver에 요청
		str += 'client_id=3kvMcStoYugzaUkMxzep&'; // client_id
		str += 'state=rjswnTlsms30tkf&'; // 보안 관련 임의값
		str += 'redirect_uri=http://localhost:8080/ns/loginNaver'; // 콜백 URL
		
		comSubmit.setUrl(str);
		comSubmit.submit();
	};
	
	
	
});
</script>

</body>
</html>