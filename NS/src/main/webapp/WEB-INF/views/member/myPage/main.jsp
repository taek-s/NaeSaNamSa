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
	<div class="row text-center mb-2">
        	<h2 class="fs-1 fw-semibold">마이 페이지</h2>
    </div>
    
    <div class="row mb-2">
    	<svg xmlns="http://www.w3.org/2000/svg" width="110" height="110" fill="currentColor" class="bi bi-person-lines-fill" viewBox="0 0 16 16">
  		<path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
		</svg>
    </div>
 
    
    <div class="row text-center mt-4 mb-4">
    	<!-- <h2 style="font-family: 'Roboto', sans-serif;" class="fs-5 ">00님! 환영합니다!</h2> 임시 삭제 -->
    	<h2 class="fs-5 ">${MEM_NICKNAME}님! 환영합니다!</h2><!-- 실제 적용 -->
    </div>
    
    <div class="row justify-content-center mb-3">
    	<div class="col-auto align-self-center">
     		<a href="/ns/myPage/accountModifyForm" name="modifyForm" class="link-primary fs-5">회원 정보 수정</a>
     	</div>
    </div>
    
    <div class="row justify-content-center mb-3">
    	<div class="col-auto align-self-center">
    		<a href="/ns/myPage/accountMyInfo" name="myInfo" class="link-primary fs-5">나의 정보</a>
    	</div>
    </div>
    
    <div class="row justify-content-center mb-3">
    	<div class="col-auto align-self-center">
     		<a href="/ns/myPage/reportList" name="report" class="link-primary fs-5">나의 신고 내역</a>
     	</div>
    </div>
    
    <div class="row justify-content-center mb-3">
    	<div class="col-auto align-self-center">
     		<a href="/ns/myPage/csList" name="cs"class="link-primary fs-5">나의 문의 내역</a>
     	</div>
    </div>
    
    <div class="row justify-content-center mb-3">
    	<div class="col-auto align-self-center">
    		<a href="/ns/myPage/accountDeleteForm" name="delete" class="link-primary fs-5">회원 탈퇴</a>
    	</div>
    </div>
    
    
    </div>
    
<script type="text/javascript"> 
$(document).ready(function() {
	
	$("a[name='report']").on("click", function(e) {
		e.preventDefault();
		fn_reportList();
	});
	

	$("a[name='cs']").on("click", function(e) {
		e.preventDefault();
		fn_csList();
	});
	
	$("a[name='modifyForm']").on("click", function(e) {
		e.preventDefault();
		fn_modifyForm();
	});
	
	$("a[name='delete']").on("click", function(e) {
		e.preventDefault();
		fn_deleteForm();
	});
	
	$("a[name='myInfo']").on("click", function(e) {
		e.preventDefault();
		fn_myInfo();
	});
	
	function fn_reportList() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/reportList");
		comSubmit.addParam("MEM_NUM", ${MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_csList() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/csList");
		comSubmit.addParam("MEM_NUM", ${MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_modifyForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/accountModifyForm");
		comSubmit.addParam("MEM_NUM", ${MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_deleteForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/accountDeleteForm");
		comSubmit.addParam("MEM_NUM", ${MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_myInfo() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/seller/info");
		comSubmit.addParam("MEM_NUM", ${MEM_NUM});
		comSubmit.submit();
	};
	
});
</script>
</body>
</html>