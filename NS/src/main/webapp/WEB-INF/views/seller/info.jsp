<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<style>
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
        <form id="modalForm" name="modalForm" class="needs-validation" novalidate>
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
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE2" value="거래 금지 품목" required>
			  <label class="form-check-label" for="REPORT_TYPE2">
			    거래 금지 품목
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE2" value="사기의심(외부채널 유도)" required>
			  <label class="form-check-label" for="REPORT_TYPE2">
			    사기의심(외부채널 유도)
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="REPORT_TYPE" id="REPORT_TYPE2" value="기타" required>
			  <label class="form-check-label" for="REPORT_TYPE2">
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
            <label for="report-name" class="col-form-label">댓글 내용</label>
            <textarea class="form-control" id="REPORT_CONTENT" name="REPORT_CONTENT" rows="5" required></textarea>
         	<div class="invalid-feedback">
		        신고 내용을 작성해주세요
		     </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" name="reportWrite" id="reportWrite">신고</button>
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
						<input class="form-control" value="${sellerInfo.MEM_NICKNAME}" readonly="readonly">
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
				        쪽지 내용을 작성해주세요.
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
  
      <div class="container pt-5 pb-5">
        <!-- 판매자 닉네임 -->
        <div class="row d-flex mb-2">
          <div class="col-auto ">
            <h2
              class="fs-1 fw-semibold mb-0 align-self-center"
            >
              ${sellerInfo.MEM_NICKNAME }<!-- 판매자 닉네임 -->
            </h2> <!-- MEM_NICKNAME -->
          </div>
          <div id="recommendDiv" class="col-auto">
            <p class="h3 ms-4 mb-0 align-self-center">
		        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
					<path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
				</svg>
				${recommendCount.RECOMMEND_COUNT}<!-- MEM_RECOMMEND -->
            </p>
          </div>
        </div> 
        <!-- 판매자 닉네임  끝 -->

		<c:if test="${sellerInfo.MEM_NUM != memNum}">
        <!-- 쪽지보내기+신고하기+추천하기 버튼 -->
        <div class="row justify-content-start">
          <div class="dropdown col-auto btn-lg d-flex justify-content-end pe-0">
            <button
              type="button"
              class="btn-sm btn-secondary" name="msgModal"
              data-bs-toggle="modal" data-bs-target="#messageModal" data-bs-whatever="쪽지 보내기"
            >
              쪽지 보내기
            </button>
          </div>

          <div class="dropdown col-auto btn-lg d-flex justify-content-end pe-0">
            <button
              type="button"
              class="btn-sm btn-secondary"
              data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="신고하기"
            >
              신고하기
            </button>
          </div>

          <div id="recommendBtnDiv" class="dropdown col-auto btn-lg d-flex justify-content-end pe-0">
            <c:if test="${isLike == 0 }">
            <button type="button" class="btn-sm btn-primary btn-block" id="addRecommend" name="recommend">추천하기</button>
            <button type="button" class="btn-sm btn-danger btn-block mt-0 d-none" id="deleteRecommend" name="unRecommend">추천취소</button>
            </c:if> 
             <c:if test="${isLike == 1 }">
            <button type="button" class="btn-sm btn-primary btn-block d-none" id="addRecommend" name="recommend">추천하기</button>
            <button type="button" class="btn-sm btn-danger btn-block mt-0" id="deleteRecommend" name="unRecommend">추천취소</button>
            </c:if>   
          </div>
        </div>
        <!-- 쪽지보내기+신고하기+추천하기 버튼 끝-->
        </c:if>

        <!-- 카테고리 드랍다운 -->
        <div class="row justify-content-end">
          <div class="dropdown col-md-2 btn-lg d-flex justify-content-end">
            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink"  data-bs-toggle="dropdown" aria-expanded="false" > 카테고리</a>

            <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
              <li><a class="dropdown-item" href="/ns/seller/info?goodsTstatus=&MEM_NUM=${sellerInfo.MEM_NUM }">전체</a></li>
              <li><a class="dropdown-item" href="/ns/seller/info?goodsTstatus=N&MEM_NUM=${sellerInfo.MEM_NUM }">판매중</a></li>
              <li><a class="dropdown-item" href="/ns/seller/info?goodsTstatus=Y&MEM_NUM=${sellerInfo.MEM_NUM }">판매 완료</a></li>
              <li><a class="dropdown-item" href="/ns/seller/info?goodsTstatus=ING&MEM_NUM=${sellerInfo.MEM_NUM }">거래중</a></li>
            </ul>
          </div>
        </div>
        <!-- 카테고리 드랍다운 끝-->

        <!-- 판매자 판매상품 리스트-->
        <!-- Section-->
        <section class="">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                <c:choose>
                <c:when test="${fn:length(seller) > 0 }">
                	<c:forEach items="${seller }" var="info">
	                    <div class="col mb-5">
	                    	<a class="text-dark" href="#" data-num="${info.GOODS_NUM}" name="title"> <!-- data-num="${GOODS_NUM}" -->
		                        <div class="card h-100">
		                            <!-- Product image-->
		                            <img class="card-img-top" src="/ns/shop/display?fileName=${info.GOODS_THUMBNAIL }" alt="..." width="270" height="200" /> 
		                            <!-- Product details-->
		                            <div class="card-body ps-2 pe-2 pt-4 pb-4 d-flex justify-content-center">
		                                <div class="text-center align-self-center">
		                                    <!-- Product name-->
		                                 
		                                    <h5 class="fw-normal">${info.GOODS_TITLE }</h5> 
		                                    <!-- Product price-->
		                                 	 <p class="fw-bold"><fmt:formatNumber value="${info.GOODS_PRICE }" type="number"/>원</p> 
		                                   	<p class="fw-light mb-0">${info.GOODS_DATE }</p>
		                                </div>
		                            </div>
		                        </div>
		                    </a>
	                    </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                	판매자가 등록한 상품이 없거나 조건에 맞는 상품 결과가 존재하지 않습니다
                </c:otherwise>
                </c:choose>
                </div>
            </div>
        </section>
        <!-- Section end -->
        <!-- 상품리스트 끝 -->

        <!-- 페이징 -->
        <nav aria-label="Page navigation example">
          ${sellerInfoListPaging.pagingHTML }
        </nav>
        <!-- 페이징 끝-->

		<c:if test="${sellerInfo.MEM_NUM != memNum}">
		<hr style="border: solid 1px black" />
        <!-- 후기창 -->
        <div class="row mb-2 mt-4">
          <div class="col">
            <h2
              class="fs-1 fw-semibold"
            >
              판매자에 대한 후기
            </h2>
            <h6>
            	&nbsp;※판매자에 대한 후기 작성은 해당 판매자가 등록한 상품을 구매한 이력이 있어야 가능합니다
            </h6>
          </div>
        </div>

			<c:if test="${canReview }">
				<form id="reviewForm">
		        <div class="form-floating mb-2">
		          <textarea
		            class="form-control"
		            placeholder="Leave a comment here"
		            id="REVIEW_CONTENT"
		            style="height: 200px"
		            name="REVIEW_CONTENT"
		          ></textarea>
		          <label for="floatingTextarea2">내용을 입력해 주세요</label>
		        </div>
		
		        <div class="dropdown col-12 justify-content-end text-end mt-4">
		          <button
		            type="button"
		            class="btn btn-secondary"
		            name="reviewWrite"
		          >
		            후기 남기기
		          </button>
		        </div>
		        </form>
		    </c:if>
        <!-- 후기창 끝-->
		</c:if>
		
		<hr style="border: solid 1px black" />

        <!-- 후기리스트 -->
        <form id="reviewForm">
        <div id="reviewDiv">
        <c:forEach var="reviewList" items="${reviewListMap}">
        <div class="row">
          <div class="input-group mb-3">
            <span class="input-group-text" id="inputGroup-sizing-default"
              >${reviewList.MEM_NICKNAME}</span> <!-- REVIEW_WRITER -->
              
              <c:choose>
	              <c:when test="${memNum == reviewList.REVIEW_WRITER }">
					<textarea
		              class="form-control col-10 reviewContent" 
		              
		             >${reviewList.REVIEW_CONTENT}
		            </textarea> <!-- REVIEW_CONTENT -->
		   		</c:when>
	             
	             <c:otherwise>
	             	<textarea
		              class="form-control col-10"
		              disabled
		              readonly
		             >${reviewList.REVIEW_CONTENT}
		             </textarea> <!-- REVIEW_CONTENT -->
	             </c:otherwise>
             </c:choose>
             
             
            <span class="input-group-text">
            <div class="row-2">
            	${reviewList.REVIEW_DATE}&nbsp;${reviewList.REVIEW_TIME}<br/>
            	
            		
            	<c:if test="${memNum == reviewList.REVIEW_WRITER }">
            		
            		<button class="btn btn-secondary btn-sm" type="button" class="btn btn-secondary btn-block" name="modifyReview" data-num="${reviewList.REVIEW_NUM}">수정</button>
          			<button class="btn btn-secondary btn-sm" type="button" class="btn btn-secondary btn-block" name="deleteReview" data-num="${reviewList.REVIEW_NUM}">삭제</button>
          				
          		</c:if>
          		</div>
            </span><!-- REVIEW_DATE -->
           
          		
          </div>
        </div>
        </c:forEach>
        </div>
        </form>
        <!-- 후기리스트 끝-->

        <!-- 페이징 -->
        <nav aria-label="Page navigation example">
             ${sellerReviewTotalListPaging.pagingHTML}
		</nav>
		<!-- 페이징 끝-->
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
	
	if(page_history == 'recommend') {
		
		const MEM_NUM = '${sellerInfo.MEM_NUM }';
		const recommendJson = {"MEM_NUM":MEM_NUM};
		
		$.ajax({
			type : 'post',
			url : '/ns/seller/recommendCount',
			data : JSON.stringify(recommendJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#recommendDiv").empty();
				str = "<p class='h3 ms-4 mb-0 align-self-center'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-hand-thumbs-up-fill' viewBox='0 0 16 16'>";
				str += "<path d='M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z'/>";
				str += "</svg>";
				str += data.RECOMMEND_COUNT;
				str += "</p>";
				$("#recommendDiv").append(str);
				
				$("#addRecommend").addClass("d-none");
				$("#deleteRecommend").removeClass("d-none");
				
			},
			error : function() {
				alert("오류 발생");
			}
		});
		
	} else if(page_history == 'unrecommend') {
		
		const MEM_NUM = '${sellerInfo.MEM_NUM }';
		const recommendJson = {"MEM_NUM":MEM_NUM};
		
		$.ajax({
			type : 'post',
			url : '/ns/seller/recommendCount',
			data : JSON.stringify(recommendJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#recommendDiv").empty();
				str = "<p class='h3 ms-4 mb-0 align-self-center'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-hand-thumbs-up-fill' viewBox='0 0 16 16'>";
				str += "<path d='M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z'/>";
				str += "</svg>";
				str += data.RECOMMEND_COUNT;
				str += "</p>";
				$("#recommendDiv").append(str);
				
				$("#deleteRecommend").addClass("d-none");
				$("#addRecommend").removeClass("d-none");
				
			},
			error : function() {
				alert("오류 발생");
			}
		});
	}
	
	$("a[name='title']").on("click", function(e) { // 상품 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");
		fn_goodsDetail(num);
	});
	
	$("button[name='recommend']").on("click", function(e) {  // 추천하기
		e.preventDefault();
		fn_recommend();
	});
	
	$("button[name='unRecommend']").on("click", function(e) {  // 추천취소
		e.preventDefault();
		fn_unRecommend();
	});
	
	$("button[name='reviewWrite']").on("click", function(e) { // 후기 남기기
		e.preventDefault();
		fn_reviewWrite();
	});
	
	$("button[name='modifyReview']").on("click", function(e) { // 리뷰 수정
		e.preventDefault();
		var num = $(this).attr("data-num");
		fn_modifyReview(num);
	});
	
	$("button[name='deleteReview']").on("click", function(e) { // 리뷰 삭제
		e.preventDefault();
		var num = $(this).attr("data-num");
		fn_deleteReview(num);
	});
	
	$("button[name='msgModal']").on("click", function(e) {  // 쪽지 버튼 클릭
		e.preventDefault();
		fn_validate();
	});
	
	function fn_reportWrite() {
		var comSubmit = new ComSubmit("modalForm");
		comSubmit.setUrl("/ns/myPage/reportWrite");
		comSubmit.addParam("REPORT_PRONUM", ${sellerInfo.MEM_NUM});  //임시 삭제
		comSubmit.submit();
	};
	
	function fn_goodsDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/shop/goodsDetail");
		comSubmit.addParam("GOODS_NUM", num);
		comSubmit.submit();
	};
	
	function fn_reviewWrite() {
		var content = $("#REVIEW_CONTENT").val();
		var json = {"REVIEW_MEMNUM":${sellerInfo.MEM_NUM }, "REVIEW_CONTENT":content};
		
		$("#reviewForm")[0].reset()  //입력폼 리셋
		
		$.ajax({
			type : 'post',
			url : '/ns/seller/reviewWrite',
			data : JSON.stringify(json),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				location.href='/ns/seller/info?pgr=1&goodsTstatus=' + '${sellerReviewTotalListPaging.goodsTstatus}' + '&MEM_NUM=' + ${sellerReviewTotalListPaging.sellerMemNum} + '&pg=' + ${sellerReviewTotalListPaging.pg};
			},
			error : function() {
				alert("오류 발생");
			}
		});
	
	};
	
	function fn_recommend() {
		
		const MEM_NICKNAME = '${sellerInfo.MEM_NICKNAME }';
		const MEM_NUM = '${sellerInfo.MEM_NUM }';
		const RECOMMEND_NUM = '${memNum}';
		const recommendJson = {"MEM_NICKNAME":MEM_NICKNAME,"MEM_NUM":MEM_NUM,"RECOMMEND_NUM":${memNum}};
		
		$.ajax({
			type : 'post',
			url : '/ns/seller/recommend',
			data : JSON.stringify(recommendJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#recommendDiv").empty();
				str = "<p class='h3 ms-4 mb-0 align-self-center'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-hand-thumbs-up-fill' viewBox='0 0 16 16'>";
				str += "<path d='M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z'/>";
				str += "</svg>";
				str += data.RECOMMEND_COUNT;
				str += "</p>";
				$("#recommendDiv").append(str);
				
				$("#addRecommend").addClass("d-none");
				$("#deleteRecommend").removeClass("d-none");
				
			},
			error : function() {
				alert("오류 발생");
			}
		});
		
		let hashUrl = '';
	    if(document.URL.indexOf('#') > -1){
	        let url = document.URL.substring(0, document.URL.indexOf('#'))
	        hashUrl = url + '#'+ 'recommend';
	    } else {
	        hashUrl = document.URL += '#' + 'recommend';
	    }
	    window.location.replace(hashUrl);
	};
	
	function fn_unRecommend() {
		
		const MEM_NICKNAME = '${sellerInfo.MEM_NICKNAME }';
		const MEM_NUM = '${sellerInfo.MEM_NUM }';
		const RECOMMEND_NUM = '${memNum}';
		const recommendJson = {"MEM_NICKNAME":MEM_NICKNAME,"MEM_NUM":MEM_NUM,"RECOMMEND_NUM":${memNum}};
		
		$.ajax({
			type : 'post',
			url : '/ns/seller/unRecommend',
			data : JSON.stringify(recommendJson),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				$("#recommendDiv").empty();
				str = "<p class='h3 ms-4 mb-0 align-self-center'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-hand-thumbs-up-fill' viewBox='0 0 16 16'>";
				str += "<path d='M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z'/>";
				str += "</svg>";
				str += data.RECOMMEND_COUNT;
				str += "</p>";
				$("#recommendDiv").append(str);
				
				$("#deleteRecommend").addClass("d-none");
				$("#addRecommend").removeClass("d-none");
				
			},
			error : function() {
				alert("오류 발생");
			}
		});
		
		let hashUrl = '';
	    if(document.URL.indexOf('#') > -1){
	        let url = document.URL.substring(0, document.URL.indexOf('#'))
	        hashUrl = url + '#'+ 'unrecommend';
	    } else {
	        hashUrl = document.URL += '#' + 'unrecommend';
	    }
	    window.location.replace(hashUrl);
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
	      comSubmit.addParam("CHAT_RECV_NUM", ${sellerInfo.MEM_NUM});
	      comSubmit.addParam("CHAT_SEND_NUM", ${memNum});
	      comSubmit.addParam("viewName", "messageList");
	      comSubmit.submit();
	};
	
	//리뷰 수정
	function fn_modifyReview(num) {
		var content = $(".reviewContent").val();
		var modifyJson = {"REVIEW_CONTENT":content, "REVIEW_NUM":num};
				
				$.ajax({
					type : 'post',
					url : '/ns/seller/updateModifyReview',
					data : JSON.stringify(modifyJson),
					contentType : "application/json; charset=utf-8",
					success : function(data) {
						alert("수정완료");
						$('#reviewDiv').load(location.href+' #reviewDiv'); //reviewDiv만 새로고침
					},
						error : function() {
							alert("오류 발생");
						}
					});
				
		};
	
	//리뷰 삭제
	function fn_deleteReview(num) {
		
		var review = {"REVIEW_NUM":num};
		
		$.ajax({
			type : 'post',
			url : '/ns/seller/deleteReview',
			data : JSON.stringify(review),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				//$('#reviewDiv').load(location.href+' #reviewDiv'); //reviewDiv만 새로고침
				location.href='/ns/seller/info?pgr=1&goodsTstatus=' + '${sellerReviewTotalListPaging.goodsTstatus}' + '&MEM_NUM=' + ${sellerReviewTotalListPaging.sellerMemNum} + '&pg=' + ${sellerReviewTotalListPaging.pg};
				},
				error : function() {
					alert("오류 발생");
				}
			});
		
	};
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

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
	  const form2 = document.querySelector('.needs-validation2')

	  // Loop over them and prevent submission
		$("button[name='sendChat']").on("click", function(e) {  // 쪽지보내기
		e.preventDefault();
		form2.classList.add('was-validated')
		
		if (!form2.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		fn_confirmMessage(); //confirm창 띄우기
	  });

	})()
	
});
</script>
  </body>
</html>
