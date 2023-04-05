<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
h2.fs-5{
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
		    <a class="nav-link link-dark" href="/ns/myShop/sellHistory">판매 내역</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link active" href="/ns/myShop/goodsLikeList">찜목록</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/recentGoodsList">최근 본 상품</a>
		  </li>
		</ul>
	  </div>
  <!-- 내상점 상단 링크 end -->
  
  
    <!-- 찜 목록 -->
  	<div class="row"> <!-- 실제 적용 시 반복문으로 이미지 추가 -->
      <div class="row pb-5" >
	      <c:choose>
	      	<c:when test="${fn:length(likeList) > 0 }">
	      		<c:forEach items="${likeList}" var="like">
			      <!-- 이미지 1번 행 -->
					   		<div class="col-3">
					   			<a href="#" name="title" data-num="${like.GOODS_NUM}">
					   				<img src="/ns/shop/display?fileName=${like.GOODS_THUMBNAIL}" class="img-thumbnail" style="width:200px; height:150px;"/> 
						        </a>
					        </div>
					        
					        <div class="col-3 align-self-center">
					        	<a class="text-dark" href="#" name="title" data-num="${like.GOODS_NUM}">
						        	<div class="row">
						        		  <h2 class="fs-5" title="${like.GOODS_TITLE}">${like.GOODS_TITLE}</h2>
						        	</div>
						        	
						        	<div class="row">
										  <h2 class="fs-6 fw-bold"><fmt:formatNumber value="${like.GOODS_PRICE}" type="number"/>원</h2>
						        	</div>
						        	
						        	<div class="row">
						        		  <h2 class="fs-6 fw-light">${like.GOODS_DATE}</h2>
						        	</div>
						        </a>
					       </div>
			       <!-- 이미지 1번 행 end-->
			       </c:forEach>
			   </c:when>
			</c:choose>
		</div>
     </div>
     
  	<!-- 찜목록 end -->
       
        <!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${myGoodsLikeTotalListPaging.pagingHTML}
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
	
	function fn_goodsDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDetail");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
});
</script>
</body>
</html>