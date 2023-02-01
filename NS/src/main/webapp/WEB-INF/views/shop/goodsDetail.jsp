<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
  	pre{
	    padding:10px;
	    overflow: auto;
	    white-space: pre-wrap;  /* pre tag내에 word wrap */
	    font-size:15px;
	} 
	
	.textLengthWrap {
				color: #747474;
			  	font-size: 12px;
			  	float:right;
			  	margin-top:10px;
			  	position:relative;
				}	
 	</style>
</head>
<body>

<!-- modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="modalForm" name="modalForm" class="needs-validation1" novalidate>
          <!-- 신고 사유 -->
          <div class="mb-3">
            <div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE1" value="광고(상점 및 타사이트 홍보, 상품 도배)" required>
			  <label class="form-check-label" for="REPORT_TYPE1">
			    광고(상점 및 타사이트 홍보, 상품 도배)
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE2" value="상품 정보 부정확(상품명, 이미지, 가격)" required>
			  <label class="form-check-label" for="REPORT_TYPE2">
			    상품 정보 부정확(상품명, 이미지, 가격)
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE3" value="거래 금지 품목" required>
			  <label class="form-check-label" for="REPORT_TYPE3">
			    거래 금지 품목
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE4" value="사기의심(외부채널 유도)" required>
			  <label class="form-check-label" for="REPORT_TYPE4">
			    사기의심(외부채널 유도)
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE5" value="기타" required>
			  <label class="form-check-label" for="REPORT_TYPE5">
			    기타
			  </label>
			  <div class="invalid-feedback text-start">
		        신고 상세 항목을 선택해주세요
		      </div>
			</div>
          </div>
          <!-- 신고 사유 end -->
        
          <div class="mb-3">
            <label for="report-name" class="col-form-label">신고 제목</label>
            <input type="text" class="form-control" id="REPORT_TITLE" name="REPORT_TITLE" required>
             <div class="invalid-feedback">
		        신고 제목을 작성해주세요
		     </div>
          </div>
          <div class="mb-3">
            <label for="report-name" class="col-form-label">신고 내용</label>
            <textarea class="form-control" id="REPORT_CONTENT" name="REPORT_CONTENT" rows="5" required></textarea>
          	  <div class="invalid-feedback">
		        신고 내용을 작성해주세요
		      </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary btn-sm" name="reportWrite" id="reportWrite">신고</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->

	<!-- 쪽지 Modal창  -->
	<div class="modal fade" id="messageModal"  tabindex="-1" role="dialog"
		aria-labelledby="messageModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					  <h1 class="modal-title fs-5" id="exampleModalLabel">title</h1>
					    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>받는 사람</label>
						<input class="form-control" value="${GOODS.MEM_NICKNAME}" readonly="readonly">
				</div>
					<div class="form-group">
					 <form id="msgModalForm" name="msgModalForm" class="needs-validation2" novalidate>
						<label>메세지</label>
							<div class='textLengthWrap'>
	                  			<span class='textCount'>0</span>
	                			 <span class='textTotal'>/ 666자</span>
	                 		 </div>
						<textarea cols="10" rows="10" class="form-control" name='CHAT_CONTENT' maxlength='666' id='CHAT_CONTENT' placeholder='메세지를 입력...' required></textarea>
						<div class="invalid-feedback text-start">
				        	쪽지 내용을 작성해주세요
				        </div>
					</form>
					</div>
					
				</div>
				<div class="modal-footer">
					 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					 <button type="button" class="btn btn-primary" name="sendChat" id="sendChat">전송</button>
				</div> <!-- /.modal-footer  -->
			</div> 
			<!-- /.modal-content -->
		</div> 
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->



<div class="container text-start">

<hr class="ms-5 me-5" style="border:solid 1px black">
    <!-- 상품 상세보기 상단 -->
    <div class="row pt-5 pb-3 ms-5 me-5">
    	<!-- 상품 썸네일 -->
   		<div class="col-5 text-center align-self-center mainThumbnail">
	   		<div class="row text-center justify-content-center">
	   			<a href="javascript:viewLarge('/ns/shop/display?fileName=${GOODS.GOODS_THUMBNAIL}')" name="image" data-num="${GOODS.GOODS_THUMBNAIL}">
	            <img src="/ns/shop/display?fileName=${GOODS.GOODS_THUMBNAIL}" class="img-thumbnail" style="width: auto; height: 350px;"/></a>
	        </div>
        </div>
        <!-- 상품 썸네일 end -->
        
        <!-- 상품 정보 -->
        <div class="col-7">
        	<div>
        		 <!-- 구매자 전용 판매자 닉네임 -->
        		 <c:if test="${member.MEM_NUM != GOODS.MEM_NUM }">
        			 <div class="col-lg-12 text-lg-end text-md-end text-sm-end">작성자 :&nbsp;<a href="#" class="link-primary" name="seller">${GOODS.MEM_NICKNAME}</a>&emsp;
        		 <!-- 구매자 전용 판매자 닉네임 end -->	
        		 	
	       		 	<!-- 구매자 전용 신고하기 버튼 -->
	       		    <c:if test="${member.MEM_NUM != GOODS.MEM_NUM && member.MEM_NUM !=null}">
	       		  		<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="신고하기">신고</button>
	       		    </c:if>
	       		    <!-- 구매자 전용 신고하기 버튼 end -->
	       		    
	       		    <!-- 관리자 전용 상품 삭제 버튼 -->
	       			<c:if test="${member.MEM_ADMIN == 'Y' }">
	        			<button type="button" class="btn btn-danger btn-sm" name="adminGoodsDelete">상품 삭제</button>
	       		 	</c:if>
	       		    <!-- 관리자 전용 상품 삭제 버튼 end -->
       		  	  </div>
       		   </c:if>
        		 
			   <!-- 상품 수정 버튼 -->
       	 	   <div class="col-lg-12 text-lg-end text-md-end text-sm-end">
       		   		<c:if test="${member.MEM_NUM == GOODS.MEM_NUM && GOODS.GOODS_TSTATUS == '판매중'}">
       		   			<button type="button" class="btn btn-secondary btn-sm" name="goodsModify" data-goodsNum="${GOODS.GOODS_NUM}">수정</button>
       		   		</c:if>
       		   		<!-- 상품 삭제 버튼 -->
       		   		<c:if test="${member.MEM_NUM == GOODS.MEM_NUM && GOODS.GOODS_TSTATUS == '판매중'}">
       		   			<button type="button" class="btn btn-secondary btn-sm" name="goodsDelete" data-goodsNum="${GOODS.GOODS_NUM}">삭제</button>
       		   		</c:if>
       		   </div>
       		   
       		   		
        	</div>
    
    		<br/><br/><br/>
        	<div class="row mb-4">
        		<div class="col-lg-12 col-md-12">
        		  <h5 class="fs-6 fw-semibold">ㆍ상품명&emsp;&emsp;${GOODS.GOODS_TITLE}</h5>
        		 </div>
        	</div>
        	
        	<div class="row d-flex mb-4">
        		<div class="col-auto pe-0">
        		  <h5 class="fs-6 fw-semibold">ㆍ가격&emsp;&emsp;&emsp;<fmt:formatNumber value="${GOODS.GOODS_PRICE }" type="number"/>원</h5>
        		</div>
        	</div>
        	
        	<div class="row mb-4">
        		  <h5 class="fs-6 fw-semibold">ㆍ상품상태&emsp;&nbsp;${GOODS.GOODS_STATUS}</h5>
        	</div>
        	
        	<!-- 찜 수, 조회수, 상품 등록일 -->
        	<div class="row mb-4">
        		  <div id="goodsLikeDiv" class="col-lg-3 align-self-center">
        		  	<p class="h6">
        		  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
  					<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
					</svg>&nbsp;${GOODSLIKE.GOODS_LIKE_COUNT}
					</p>
				  </div>
				  
        		  <div class="col-lg-3 align-self-center">
	        		  <p class="h6">
	        		  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
						<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
						<path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
					  </svg>&nbsp;${GOODS.GOODS_COUNT}
	        		  </p>
        		  </div>
        		  
        		  <div class="col-lg-5">
	        		  <p class="h6">
	        		  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-fill" viewBox="0 0 16 16">
	  					<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
					  </svg>&nbsp;${GOODS.GOODS_DATE}&emsp;
	        		  </p>
        		  </div>
        	</div>
        	
      
        	<!-- 판매자 전용 -->
        	<c:if test="${member.MEM_NUM == GOODS.MEM_NUM }">
        	<div class="row">
		    	<div class="col-lg-8">
		  			<button type="button" class="btn btn-secondary btn-block" name="myShopMain">내 상품 관리</button>
		  		</div>
		  	
		  	<c:if test="${GOODS.GOODS_TSATUS == '판매중'}">
		  		<div class="col-lg-4">
		  			<button type="button" class="btn btn-secondary btn-block" name="goodsDelete">상품 삭제</button>
		  		</div>
		  	</c:if>
    		</div>
    		</c:if>
    		<!-- 판매자 전용 end -->
    		
    		<!-- 구매자 전용 -->
    		<c:if test="${member.MEM_NUM != GOODS.MEM_NUM }">
        	<div class="row">
		    	<div id="goodsLikeBtnDiv" class="col-lg-3 col-sm-6 mb-1 text-center">
		    		<!-- 해당 상품을 이미 찜했다면 찜취소 버튼이 나와야 함 -->
		    		<c:if test="${isLike == 0 }">
		  				<button type="button" class="btn btn-secondary btn-sm btn-block" id="addGoodsLike" name="addGoodsLike">찜하기</button>
		  				<button type="button" class="btn btn-danger mt-0 d-none btn-sm btn-block" id="deleteGoodsLike" name="deleteGoodsLike">찜취소</button>
		  			</c:if>
		  			<c:if test="${isLike == 1 }">
		  				<button type="button" class="btn btn-secondary d-none btn-sm btn-block" id="addGoodsLike" name="addGoodsLike">찜하기</button>
		  				<button type="button" class="btn btn-danger mt-0 btn-sm btn-block" id="deleteGoodsLike" name="deleteGoodsLike">찜취소</button>
		  			</c:if>
		  			
		  			<%-- <button type="button" class="btn btn-secondary btn-sm ms-4"
					 data-bs-toggle="modal" data-bs-target="#messageModal" data-bs-whatever="쪽지 보내기" style="width:80px">쪽지</button>
					 
					 <c:if test="${GOODS.GOODS_TSTATUS == '판매중'}">
			  			<button type="button" class="btn btn-secondary btn-sm ms-4" name="directOrder" style="width:80px">직거래</button>
			  			<button type="button" class="btn btn-secondary btn-sm ms-4" name="shippingOrder" style="width:80px">택배</button>
		  		     </c:if> --%>
		  			
		  		</div>
		  		
		  		<c:if test="${member.MEM_NUM != null}">
		  		<div class="col-lg-3 col-sm-6 mb-1">
		  			<button type="button" class="btn btn-secondary btn-sm btn-block" name="msgModal"
					 data-bs-toggle="modal" data-bs-target="#messageModal" data-bs-whatever="쪽지 보내기">쪽지</button>
		  		</div>
		  		</c:if>
		  		
		  		<!-- 상품 상태가 판매중일때만 구매버튼 표시 -->
		  		<c:if test="${GOODS.GOODS_TSTATUS == '판매중'}">
			  		<div class="col-lg-3 col-sm-6 mb-1">
			  			<button type="button" class="btn btn-secondary btn-sm btn-block" name="directOrder">직거래</button>
			  		</div>
			  		
			  		<div class="col-lg-3 col-sm-6 mg-1">
			  			<button type="button" class="btn btn-secondary btn-sm btn-block" name="shippingOrder">택배</button>
			  		</div>
		  		</c:if>
    		</div>
    		</c:if>
    		<!-- 구매자 전용 end -->
    		
        </div>
        <!-- 상품 정보 end-->
    </div>
    <!-- 상품 상세보기 상단 end -->
    
    
    <hr class="ms-5 me-5" style="border:solid 1px black">
    
    
    <!-- 상품 상세보기 하단 -->
    <div class="row ms-5 me-5">
    	<h6 class="fs-4 fw-semibold">상품 설명</h6>
    </div>
    
    <div class="row ms-5 me-5">
    	<pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;" readonly>${GOODS.GOODS_CONTENT }</pre>
    </div>
    <!-- 상품 상세보기 하단 end -->
    
    
    <hr class="ms-5 me-5" style="border:solid 1px black">
  
  
  	<!-- 상품 이미지 -->
  	<div class="col"> <!-- 실제 적용 시 반복문으로 이미지 추가 -->
      
      <!-- 이미지 1번 행 -->
      <div class="row pb-5 ms-5 me-5">
	      <div class="row pt-4">
	      	<c:choose>
	      		<c:when test="${fn:length(GOODSIMG) > 0 }">
	      			<c:forEach items="${GOODSIMG }" var="img">
				      	<div class="col-lg-3 col-md-3 col-sm-6">
				      	<%--이미지 누르거나, 혹은 [크게보기] 버튼 눌렀을 때 이미지 새 창으로 확대해서 보기위해 viewLarge()함수 사용 --%>
						<a href="javascript:viewLarge('/ns/shop/display?fileName=${img.GOODS_IMAGE_STD}')" name="image" data-num="${img.GOODS_IMG_STD}">
				      		<img src="/ns/shop/display?fileName=${img.GOODS_IMAGE_STD}" class="img-thumbnail" style="width:200px; height:200px;"/></a>
				      	</div>
				    </c:forEach>
			    </c:when>
			    <c:otherwise>
			    	등록된 이미지가 없습니다.
			    </c:otherwise>
		    </c:choose>
	      </div>
      </div>
      
    </div>
  	<!-- 상품 이미지 end -->
  </div>

<script type="text/javascript">
//신고 모달 설정
const exampleModal = document.getElementById('exampleModal'); 
exampleModal.addEventListener('show.bs.modal', event => {
	
  const button = event.relatedTarget;
  console.log(button);
  
  const recipient = button.getAttribute('data-bs-whatever');
  const modalTitle = exampleModal.querySelector('.modal-title');
  

  modalTitle.textContent = recipient;
  
  
}); // 모달 설정

//쪽지 모달 설정
const messageModal = document.getElementById('messageModal'); 
messageModal.addEventListener('show.bs.modal', event => {
   
  const button = event.relatedTarget;
  console.log(button);
  
  const recipient = button.getAttribute('data-bs-whatever');
  const modalTitle = messageModal.querySelector('.modal-title');
  

  modalTitle.textContent = recipient;
  
}); // 모달 설정

$(document).ready(function() {
	
	let page_history = document.URL.substring(document.URL.indexOf('#')+1);
	
	if(page_history == 'like') {
		
		const LIKE_GOODS_NUM = '${GOODS.GOODS_NUM}';
		const addGoodsLikeJson = {"LIKE_GOODS_NUM":LIKE_GOODS_NUM};
		
		$.ajax({
			type : 'post',
			url : '/ns/shop/goodsDetail/goodslikeCount',
			data : JSON.stringify(addGoodsLikeJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#goodsLikeDiv").empty();
				str = "<p class='h6'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColo' class='bi bi-heart-fill' viewBox='0 0 16 16'>";
				str += "<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>";
				str += "</svg>";
				str += data.count;
				str += "</p>";
				$("#goodsLikeDiv").append(str); 
				
				$("#addGoodsLike").addClass("d-none");
				$("#deleteGoodsLike").removeClass("d-none");
				
			},
			error : function() {
				alert("오류 발생");
			}
		});
		
		
	} else if(page_history == 'unlike') {
		
		const LIKE_GOODS_NUM = '${GOODS.GOODS_NUM}';
		const addGoodsLikeJson = {"LIKE_GOODS_NUM":LIKE_GOODS_NUM};
		
		$.ajax({
			type : 'post',
			url : '/ns/shop/goodsDetail/goodslikeCount',
			data : JSON.stringify(addGoodsLikeJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#goodsLikeDiv").empty();
				str = "<p class='h6'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColo' class='bi bi-heart-fill' viewBox='0 0 16 16'>";
				str += "<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>";
				str += "</svg>";
				str += data.count;
				str += "</p>";
				$("#goodsLikeDiv").append(str); 
				
				$("#addGoodsLike").removeClass("d-none");
				$("#deleteGoodsLike").addClass("d-none");
			},
			error : function() {
				alert("오류 발생");
			}
		});
	}
	
	
	$("button[name='adminGoodsDelete']").on("click", function(e) {  // 관리자 상품 삭제
		e.preventDefault();
		fn_adminGoodsDelete();
	});
	
	$("a[name='seller']").on("click", function(e) {  // 구매자 전용 판매자 상세보기
		e.preventDefault();
		fn_sellerInfo();
	});
	
	$("button[name='myShopMain']").on("click", function(e) {  // 판매자 전용 내상점 메인(상품관리)
		e.preventDefault();
		fn_myShopMain();
	});
	
	$("button[name='goodsDelete']").on("click", function(e) {  // 판매자 전용 상품 삭제
		e.preventDefault();
		fn_goodsDelete();
	});
	
	$("button[name='addGoodsLike']").on("click", function(e) {  // 구매자 전용 찜하기
		e.preventDefault();
		fn_addGoodsLike();
	});
	
	$("button[name='deleteGoodsLike']").on("click", function(e) {  // 구매자 전용 찜취소
		e.preventDefault();
		fn_deleteGoodsLike();
	});
	
	$("button[name='directOrder']").on("click", function(e) {  // 구매자 전용 직거래로 구매
		e.preventDefault();
		fn_directOrder();
	});
	
	$("button[name='shippingOrder']").on("click", function(e) {  // 구매자 전용 택배로 구매
		e.preventDefault();
		fn_shippingOrder();
	});
	
	$("button[name='image']").on("click", function(e) {  // 이미지 클릭
		e.preventDefault();
		const imageNum = $(this).attr("data-num");		
		fn_imageClick(imageNum);
	});
	
	$("button[name='goodsModify']").on("click", function(e) {  // 상품 수정
		e.preventDefault();
		const goodsNum = $(this).attr("data-goodsNum");		
		fn_goodsModify(goodsNum);
	});
	
	$("button[name='goodsDelete']").on("click", function(e) {  // 상품 삭제
		e.preventDefault();
		const goodsNum = $(this).attr("data-goodsNum");		
		fn_goodsDelete(goodsNum);
	});
	
	$("button[name='msgModal']").on("click", function(e) {  // 쪽지 버튼 클릭
		e.preventDefault();
		fn_validate();
	});
	
	function fn_adminGoodsDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/goodsDelete");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.submit();
	};
	
	function fn_sellerInfo() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/seller/info");
		comSubmit.addParam("MEM_NUM", ${GOODS.MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_myShopMain() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myShop");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.submit();
	};
	
	function fn_goodsDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDelete");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.submit();
	};
	
	function fn_addGoodsLike() {
		
		const LIKE_GOODS_NUM = '${GOODS.GOODS_NUM}';
		const LIKE_MEM_EMAIL = '${member.MEM_EMAIL}';
		const addGoodsLikeJson = {"LIKE_GOODS_NUM":LIKE_GOODS_NUM,"LIKE_MEM_EMAIL":LIKE_MEM_EMAIL};
		
		$.ajax({
			type : 'post',
			url : '/ns/shop/goodsDetail/goodsLike',
			data : JSON.stringify(addGoodsLikeJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#goodsLikeDiv").empty();
				str = "<p class='h6'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColo' class='bi bi-heart-fill' viewBox='0 0 16 16'>";
				str += "<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>";
				str += "</svg>";
				str += data.count;
				str += "</p>";
				$("#goodsLikeDiv").append(str); 
				
				$("#addGoodsLike").addClass("d-none");
				$("#deleteGoodsLike").removeClass("d-none");
				
			},
			error : function() {
				alert("오류 발생");
			}
		});
		
		let hashUrl = '';
	    if(document.URL.indexOf('#') > -1){
	        let url = document.URL.substring(0, document.URL.indexOf('#'))
	        hashUrl = url + '#'+ 'like';
	    } else {
	        hashUrl = document.URL += '#' + 'like';
	    }
	    window.location.replace(hashUrl);
	    
	};
	
	function fn_deleteGoodsLike() {
		
		const LIKE_GOODS_NUM = '${GOODS.GOODS_NUM}';
		const LIKE_MEM_EMAIL = '${member.MEM_EMAIL}';
		const addGoodsLikeJson = {"LIKE_GOODS_NUM":LIKE_GOODS_NUM,"LIKE_MEM_EMAIL":LIKE_MEM_EMAIL};
		
		$.ajax({
			type : 'post',
			url : '/ns/shop/goodsDetail/goodsUnlike',
			data : JSON.stringify(addGoodsLikeJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#goodsLikeDiv").empty();
				str = "<p class='h6'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColo' class='bi bi-heart-fill' viewBox='0 0 16 16'>";
				str += "<path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>";
				str += "</svg>";
				str += data.count;
				str += "</p>";
				$("#goodsLikeDiv").append(str); 
				
				$("#addGoodsLike").removeClass("d-none");
				$("#deleteGoodsLike").addClass("d-none");
			},
			error : function() {
				alert("오류 발생");
			}
		});
		
		let hashUrl = '';
	    if(document.URL.indexOf('#') > -1){
	        let url = document.URL.substring(0, document.URL.indexOf('#'))
	        hashUrl = url + '#'+ 'unlike';
	    } else {
	        hashUrl = document.URL += '#' + 'unlike';
	    }
	    window.location.replace(hashUrl);
	};
	
	function fn_directOrder() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/order/orderWriteForm2");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.addParam("sellerNum", ${GOODS.MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_shippingOrder() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/order/orderWriteForm");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.addParam("sellerNum", ${GOODS.MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_reportWrite() {
	      var comSubmit = new ComSubmit("modalForm");
	      comSubmit.setUrl("/ns/myPage/reportWrite");
	      comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM}); 
	      comSubmit.addParam("REPORT_PRONUM", ${GOODS.MEM_NUM}); //판매자 회원번호
	      comSubmit.submit();
	};
	
	function fn_confirmMessage() { //쪽지 전송 전 confirm창 띄우기
		if(confirm("메세지를 전송하시겠습니까?")) {
			fn_sendChat();
		} else {
			return false;
		}		
	};
	
	function fn_validate() { //쪽지 입력 글자수 표시, 글자수 제한
		   $('#CHAT_CONTENT').keyup(function () {
		  	  var inputLength = $(this).val().length;
		  	   
		  	  $('.textCount').html(inputLength);
		  	  
		  	  if(inputLength > 666) {
		  		  alert("내용을 최대 666글자로 작성해주세요.");
		  		  $('#CHAT_CONTENT').focus();
		  	      return false;
		  	  }
		    });
	};
		
	   
	function fn_sendChat() { //쪽지 보내기
		var comSubmit = new ComSubmit("msgModalForm");
		comSubmit.setUrl("/ns/message/messageSendInlist");
		comSubmit.addParam("CHAT_RECV_NUM", ${GOODS.MEM_NUM});
		comSubmit.addParam("CHAT_SEND_NUM", ${member.MEM_NUM});
		comSubmit.addParam("viewName", "messageList");
		comSubmit.submit();
	};
	
	function fn_goodsModify(){ //상품 수정
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsModifyForm");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.submit();
	};
	
	function fn_goodsDelete(){ //상품 삭제
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDelete");
		comSubmit.addParam("GOODS_NUM", ${GOODS.GOODS_NUM});
		comSubmit.submit();
	};
	
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation1')

	  // Loop over them and prevent submission
		$("button[name='reportWrite']").on("click", function(e) {  // 구매자 전용 신고하기
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let titleval = $('#REPORT_TITLE').val();
		let contentval = $('#REPORT_CONTENT').val();
		
		//제목, 내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
		//제목 최대 133글자 입력 가능 (title 최대 400byte (오라클 기준 한글 1글자당 3byte))
		if(titleval.length > 133){
			alert("제목을 최대 133글자로 작성해주세요.")
			$('#REPORT_TITLE').focus()
			return false;
		}
		
		//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 666){
			alert("내용을 최대 666글자로 작성해주세요.")
			$('#REPORT_CONTENT').focus()
			return false;
		}
		
		fn_reportWrite();
	  });
	})();
	
	//유효성 검사
	(() => {
		  'use strict'	  
	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form1 = document.querySelector('.needs-validation2')

	  // Loop over them and prevent submission
		$("button[name='sendChat']").on("click", function(e) {  // 채팅 보내기
		e.preventDefault();
		form1.classList.add('was-validated')
		
		if (!form1.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		fn_confirmMessage(); //confirm창 띄우기
	  });
	})()
	
	
});

<%-- 이미지 크게보기위한 스크립트 함수 --%>
function viewLarge(imageNum){ 	
window.open(imageNum,"_blank", "width=400, height=400, left=50, top=50, scrollbars=no, titlebar=no, resizable=no, fullscreen=no");
}
</script>

</body>
</html>