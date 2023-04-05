<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
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
</style>
</head>
<body>
  
 	 	<!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5">
            
            <!-- 버튼 두개 -->
            <div class="row justify-content-end">
	            <div class="dropdown col-auto btn-lg d-flex justify-content-end">
				  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
				    가격대
				  </a>
				
				  <ul class="dropdown-menu" aria-labelledby="가격대" >
				    <li><a class="dropdown-item" href="#" name="priceType">전체</a></li>
				    <li><a class="dropdown-item" href="#" name="priceType" data-num="A">~30000원</a></li>
				    <li><a class="dropdown-item" href="#" name="priceType" data-num="B">~60000원</a></li>
				    <li><a class="dropdown-item" href="#" name="priceType" data-num="C">~100000원</a></li>
				    <li><a class="dropdown-item" href="#" name="priceType" data-num="D">100000원 이상</a></li>
				  </ul>
				</div>
				
				<div class="dropdown col-auto btn-lg d-flex justify-content-end">
				  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
				    판매상태
				  </a>
				
				  <ul class="dropdown-menu" aria-labelledby="판매상태">
				    <li><a class="dropdown-item" href="#" name="tstatusType">전체</a></li>
				    <li><a class="dropdown-item" href="#" name="tstatusType" data-num="N">판매중</a></li>
				    <li><a class="dropdown-item" href="#" name="tstatusType" data-num="Y">판매완료</a></li>
				    <li><a class="dropdown-item" href="#" name="tstatusType" data-num="ING">거래중</a></li>
				  </ul>
				</div>
         	</div>   
         	<!-- 버튼 두개 끝-->   
            
            
            
            <!-- 상품리스트 -->
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                
                <c:choose>
                <c:when test="${fn:length(list) > 0}">
                	<c:forEach items="${list }" var="goods">
	                    <div class="col mb-5">
	                    	<a class="text-dark" href="#" name="title" data-num="${goods.GOODS_NUM }">
		                        <div class="card h-100">
		                            <!-- Product image-->
		                            <img class="card-img-top" src="/ns/shop/display?fileName=${goods.GOODS_THUMBNAIL }" alt="..." width="270" height="200" />
		                            <!-- Product details-->
		                            <div class="card-body ps-2 pe-2 pt-4 pb-4 d-flex justify-content-center">
		                                <div class="text-center align-self-center">
		                                    <!-- Product name-->
		                                    <h5 class="fw-normal">${goods.GOODS_TITLE }</h5>
		                                    <!-- Product price-->
		                                    <p class="fw-bold"><fmt:formatNumber value="${goods.GOODS_PRICE }" type="number"/>원</p>
		                                    <p class="fw-bold"> ${goods.MEM_NICKNAME }</p>
		                                    <p class="fw-light mb-0">${goods.GOODS_DATE }</p>
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
            </div>
            <!-- 상품리스트 끝 -->
            
           <!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${goodsTotalListPaging.pagingHTML }
			</nav>
			<!-- 페이징 끝-->
			 
			 
        </section>
        <!-- Section end -->
        
<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='title']").on("click", function(e) { // 상품 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");
		fn_goodsDetail(num);
	});
	
	$("a[name='priceType']").on("click", function(e) { // 가격대로 검색
		e.preventDefault();
		var priceType = $(this).attr("data-num");
		fn_priceType(priceType);
	});
	
	$("a[name='tstatusType']").on("click", function(e) { // 판매상태로 검색
		e.preventDefault();
		const tstatusType = $(this).attr("data-num");
		fn_tstatusType(tstatusType);
	});
	
	function fn_goodsDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDetail");
		comSubmit.addParam("GOODS_NUM", num);
		
		//임시로 파라미터 전송(세션 관련) - 추후 코드 수정 필요
		comSubmit.addParam("GOODS_TITLE", 'Test title');
		comSubmit.addParam("GOODS_PRICE", 10000);
		comSubmit.addParam("GOODS_THUMBNAIL", '썸네일');
		
		comSubmit.submit();
	};
	
	function fn_priceType(priceType) {
		var comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/ns/shop/totalList");
		comSubmit.addParam("priceType", priceType);
		comSubmit.submit();
	};
	
	function fn_tstatusType(tstatusType) {
		var comSubmit = new ComSubmit("searchForm");
		comSubmit.setUrl("/ns/shop/totalList");
		comSubmit.addParam("tstatusType", tstatusType);
		comSubmit.submit();
	};
	
});
</script>
        
</body>
</html>