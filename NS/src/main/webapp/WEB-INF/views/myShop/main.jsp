<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
td.title22{
white-space:nowrap;
overflow:hidden;
text-overflow:ellipsis;
max-width:200px;
}
tr.tr22{
position:static;
}

</style>
</head>
<body>


<div class="container text-start">
  
  <!-- 내상점 상단 링크 -->
  <div class="row pt-4 pb-4" >
	    <ul class="nav nav-tabs" style="font-size:15px;">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="/ns/myShop">상품 관리</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/orderHistory">주문 내역</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/sellHistory">판매 내역</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/goodsLikeList">찜목록</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link link-dark" href="/ns/myShop/recentGoodsList">최근 본 상품</a>
		  </li>
		</ul>
	  </div>
  <!-- 내상점 상단 링크 end -->
  
  <!-- 상품명 겅색창 + dropbox -->
  <form action="#" method="post" role="search">
  	<div class="row mb-3">
          	<div class="col-auto">
          	<!-- 상품 검색 키워드가 있거나, ''이 아닐경우, 검색창에 keyword 출력 (페이지 이동해도 keyword 유지) -->
          		<input
	              type="search"
	              class="form-control"
	              placeholder="상품명 입력"
	              value="${myGoodsTotalListPaging.keyword}"
	              aria-label="Search"
	              style="width: 200px; height: 30px; font-size: 15px"
	              name="keyword" id="keyword"
	            />
            </div>
            
            <div class="col-lg-2">
            	<button type="submit" name="goodsSearch" class="btn-sm btn-primary">검&nbsp;색</button>
            </div>
            
            <div class="col-auto">
		      <select name="goodsTstatus" id ="goodsTstatus" class="form-select form-select-sm" aria-label="상태">
				  <option selected>판매 상태</option>
				  <option value="N" <c:out value="${myGoodsTotalListPaging.goodsTstatus eq 'N' ? 'selected' :''}"/>>판매중</option>
				  <option value="Y" <c:out value="${myGoodsTotalListPaging.goodsTstatus eq 'Y' ? 'selected' :''}"/>>판매 완료</option>
				  <option value="ING" <c:out value="${myGoodsTotalListPaging.goodsTstatus eq 'ING' ? 'selected' :''}"/>>거래중</option>
			  </select>
		    </div>
   	</div>
   </form>
   <!-- 상품명 겅색창 + dropbox end -->
          
          
          <!-- 상품관리 테이블 -->
          <div class="row">      
          	<table class="table" style="font-size:13px">
			  <thead class="table-secondary">
			    <tr class="tr22">
			      <th scope="col" style="width:100px;">사진</th>
			      <th scope="col" style="width:120px;">판매상태</th>
			      <th scope="col" style="width:180px;">상품명</th>
			      <th scope="col" style="width:100px;">가격</th>
			      <th scope="col" style="width:40px;">찜</th>
			      <th scope="col" style="width:80px;">최근수정일</th>
			      <th scope="col" style="width:90px;">수정</th>
			    </tr>
			  </thead>
			  <tbody> <!-- 반복문으로 상품 정보 가져오기 -->
				  <c:choose>
				  	<c:when test="${fn:length(goodsList) > 0}">
				  		<c:forEach items="${goodsList}" var="goods">
						    <tr>
						      <td><a href="#" name="image" data-numImage="${goods.GOODS_NUM}"><img src="/ns/shop/display?fileName=${goods.GOODS_THUMBNAIL}" class="img-thumbnail" style="width: auto; height: 150px;"/></a></td>
						      <td>${goods.GOODS_TSTATUS}</td>
						      <td class="title22" title="${goods.GOODS_TITLE}"><a class="text-dark" href="#" name="title" data-num="${goods.GOODS_NUM}">${goods.GOODS_TITLE}</a></td>
						      <td><fmt:formatNumber value="${goods.GOODS_PRICE}" type="number"/>원</td>
						      <td>${goods.GOODS_LIKE_COUNT}</td> <!-- 찜 횟수 -->
						      <td>${goods.GOODS_DATE}<br>${goods.GOODS_TIME}</td>
						      <td>
						      	<!-- 수정버튼은 GOODS_TSTATUS가 '판매중'일때만, 삭제버튼은 GOODS_TSTATUS가 '판매중'일 때만 -->
						      	<c:if test="${goods.GOODS_TSTATUS =='판매중'}">
						      		<button type="button" class="btn-sm btn-warning" name="goodsModify" data-num="${goods.GOODS_NUM}">수정</button>
						      		<button type="button" class="btn-sm btn-danger" name="goodsDelete" data-num="${goods.GOODS_NUM}">삭제</button>
						      	</c:if>
						      </td>
						    </tr> 
						 </c:forEach>
					    </c:when>
					</c:choose>
				 </tbody>
			  </table>
			</div>	
			
		  <!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${myGoodsTotalListPaging.pagingHTML}
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
	
	$("a[name='image']").on("click", function(e) { // 상품 상세보기
		e.preventDefault();
		const num = $(this).attr('data-numImage');
		console.log(num);
		fn_goodsDetail(num);
	});
	
	$("button[name='goodsModify']").on("click", function(e) { // 상품 수정
		e.preventDefault();
		const num = $(this).attr('data-num');
		console.log(num);
		fn_goodsModifyForm(num);
	});
	
	$("button[name='goodsDelete']").on("click", function(e) {  // 상품 삭제
		e.preventDefault();
		const num = $(this).attr('data-num');
		console.log(num);
		alert("상품 삭제가 완료되었습니다.");
		fn_goodsDelete(num);
	});
	
	
	$("button[name='goodsSearch']").on("click", function(e) { //상품명 검색
		e.preventDefault();
		fn_goodsSearch();
	});
	
	
	function fn_goodsDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDetail");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
	function fn_goodsModifyForm(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsModifyForm");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
	function fn_goodsDelete(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDelete");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
	
	function fn_goodsSearch(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myShop");
		comSubmit.addParam("keyword",$('#keyword').val() );
		comSubmit.addParam("goodsTstatus",$('#goodsTstatus').val() );
		comSubmit.submit();	
	}
	
});
</script>
</body>

</html>