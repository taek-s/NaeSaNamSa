<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%@ include file="/WEB-INF/views/include/include-head.jspf" %>

<title>내사남사 인덱스</title>
</head>
<body class="ms-5">
	<%-- <jsp:forward page="/main" /> --%>
	<h2>main</h2>
	<a href="/ns/main">메인페이지</a> <br/>
	
	<hr>
	<h2>member</h2>
	<a href="/ns/loginSelect">로그인 - 로그인 선택</a> <br/>
	<a href="/ns/loginForm">로그인 - ID/PW로 시작하기</a> <br/>

	
	<hr>
	<h2>myShop</h2>
	<a href="/ns/myShop/">내상점 - 메인(상품관리)</a> <br/>
	<a href="/ns/myShop/history">내상점 - 주문/판매 내역 조회</a> <br/>
	<a href="/ns/myShop/goodsLikeList">내상점 - 찜목록</a> <br/>
	<a href="/ns/myShop/recentGoodsList">내상점 - 최근 본 상품</a> <br/>
	
	
	<hr>
	<h2>shop</h2>
	<a href="/ns/shop/totalList" name="post">상품 - 상품 전체 리스트</a> <br/>
	<a href="/ns/shop/goodsWriteForm">상품 - 상품 등록 폼</a> <br/>
	<a href="/ns/shop/goodsDetail">상품 - 상품 상세보기</a> <br/>
	<a href="/ns/shop/goodsModifyForm" name="post">상품 - 상품 수정 폼</a> <br/>
	
	
	<hr>
	<h2>order</h2>
	<a href="/ns/shop/order/orderWriteForm">주문 - 주문 작성 폼</a> <br/>
	<a href="/ns/shop/order/orderDetail">주문 - 주문 상세보기</a> <br/>
	<a href="/ns/shop/order/orderModifyForm">주문 - 주문 수정 폼</a> <br/>
	
	
	<hr>
	<h2>message</h2>
	<a href="/ns/message/list">쪽지함 - 받은 쪽지 리스트</a> <br/>
	
	
	<hr>
	<h2>myPage</h2>
	<a href="/ns/myPage">마이페이지 - 비밀번호 확인 폼</a> <br/>
	<a href="/ns/myPage/main">마이페이지 - 메인</a> <br/>
	<a href="/ns/myPage/accountModifyForm">마이페이지 - 회원정보 수정 폼</a> <br/>
	<a href="/ns/myPage/reportList">마이페이지 - 신고 내역 조회</a> <br/>
	<a href="/ns/myPage/reportDetail">마이페이지 - 신고 상세보기</a> <br/>
	<a href="/ns/myPage/csList">마이페이지 - 고객센터 문의 조회</a> <br/>
	<a href="/ns/myPage/csWriteForm">마이페이지 - 고객센터 문의 작성 폼</a> <br/>
	<a href="/ns/myPage/csDetail">마이페이지 - 고객센터 문의 상세보기</a> <br/>
	<a href="/ns/myPage/accountDeleteForm">마이페이지 - 회원탈퇴 폼</a> <br/>
	
	<hr>
	<h2>help</h2>
	<a href="/ns/help/main">고객센터 - 메인</a> <br/>
	
	
<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='post']").on("click", function(e) { // post로 요청
		e.preventDefault();
		fn_post($(this));
	});
	
	function fn_post(obj) {
		var comSubmit = new ComSubmit();
		var url = obj.attr('href')
		comSubmit.setUrl(url);
		comSubmit.submit();
	};
	
});
</script>
</body>
</html>