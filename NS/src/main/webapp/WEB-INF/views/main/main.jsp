<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	h5.fw-normal{
				white-space:nowrap;
				overflow:hidden;
				text-overflow:ellipsis;
				max-width:200px;
				display:block;
				}
	p.fw-bold{
				white-space:nowrap;
				overflow:hidden;
				text-overflow:ellipsis;
				max-width:200px;
				display:block;
				}
	.carousel-item {
		height: 300px;
		min-height: 300px;
		background: no-repeat center center scroll;
		-webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		background-size: cover;
	}
</style>
</head>
<body>
  
<div class="row justify-content-center">
	<div id="carouselExampleControls" class="carousel slide carousel-fade" data-bs-ride="carousel" style="width:80%;" >
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="<%=request.getContextPath()%>/image/slide_img1.jpg" class="d-block w-100" alt="..." style="height:300px;">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=request.getContextPath()%>/image/slide_img2.jpg" class="d-block w-100" alt="..." style="height:300px;">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=request.getContextPath()%>/image/slide_img3.jpg" class="d-block w-100" alt="..." style="height:300px;">
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>
  </div>
  
  <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                     <c:choose>
		                <c:when test="${fn:length(list) > 0}">
		                	<c:forEach items="${list }" var="goods">
			                    <div class="col mb-5">
			                    	<a class="text-dark" href="#" name="title" data-num="${goods.GOODS_NUM }">
				                        <div class="card h-100">
				                            <!-- Product image-->
				                            <img class="card-img-top" src="/ns/shop/display?fileName=${goods.GOODS_THUMBNAIL}" alt="..." width="270" height="300" />
				                            <!-- Product details-->
				                            <div class="card-body ps-2 pe-2 pt-4 pb-4 d-flex justify-content-center">
				                                <div class="text-center align-self-center">
				                                    <!-- Product name-->
				                                    <h5 class="fw-normal">${goods.GOODS_TITLE}</h5>
				                                    <!-- Product price-->
				                                    <p class="fw-bold"><fmt:formatNumber value="${goods.GOODS_PRICE }" type="number"/>원</p>
				                                    <p class="fw-bold"> ${goods.MEM_NICKNAME}</p>
				                                    <p class="fw-light mb-0">${goods.GOODS_DATE}</p>
				                                </div>
				                            </div>
				                        </div>
				                    </a>
			                    </div>
			                </c:forEach>
		                </c:when>
		                <c:otherwise>
		                	등록된 상품이 없습니다.
		                </c:otherwise>
		             </c:choose>
                </div>
            </div>
        </section>
        <!-- Section end -->
        
<script type="text/javascript">
$(document).ready(function() {
	
	var loginFail = '${loginFail}';
	if(loginFail != null && loginFail != "") {
		alert("탈퇴 후 재가입은 7일 후에 가능합니다.");
	}
	
	$("a[name='title']").on("click", function(e) { // 상품 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");
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