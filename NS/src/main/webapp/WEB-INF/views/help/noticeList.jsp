<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <div class="container text-start p-5">
      <!-- 뒤로가기  -->
      <a href="/ns/help/main" class="text-dark">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="65"
          height="75"
          fill="currentColor"
          class="bi bi-arrow-left"
          viewBox="0 0 16 16"
        >
          <path
            fill-rule="evenodd"
            d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"
          />
        </svg>
      </a>
      <!-- 뒤로가기  끝-->

      <!--  타이틀 -->
      <div class="row">
        <div class="col">
          <h2
            class="fs-1 fw-semibold"
          >
            공지사항
          </h2>
        </div>
      </div>
	  <!-- 타이틀 끝-->
	  
	  <!-- 관리자 전용 작성하기 버튼. NoticeController에서 올린 memAdmin값 가져와서 Y이면 관리자니까, 작성하기 버튼 표시 -->
	  <c:if test="${MEM_ADMIN == 'Y'}">
	      <div class="row justify-content-end">
	        <div class="dropdown col-md-2 btn-lg d-flex justify-content-end">
	          <button
	            type="button"
	            class="btn btn-primary btn-block"
	            name="adminNoticeWriteForm"
	          >
	            작성하기
	          </button>
	        </div>
	      </div>
	  </c:if>
      <!-- 관리자 전용 작성하기 버튼 end -->

      <!-- 공지사항 테이블 링크 -->
      <table class="table" style="table-layout:fixed">
        <thead>
          <tr>
            <th scope="col" style="width:90px;">번호</th>
            <th scope="col">제목</th>
            <th scope="col" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; width:150px;">날짜</th>
          </tr>
        </thead>
        <tbody>
        <!-- 공지사항 리스트 반복문으로 출력 (글 번호, 제목, 작성날짜) -->
        <c:choose>
        	<c:when test="${fn:length(noticeList) > 0}">
        		<c:forEach items="${noticeList}" var="notice" varStatus="status" begin="0" end="10">
		          <tr>
				  <th scope="row">${number - status.index}</th> 
		          	<td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; max-width:200px;" title="${notice.NOTICE_TITLE}"><a href="#" name="title" class="text-dark" data-num="${notice.NOTICE_NUM}">${notice.NOTICE_TITLE}</a></td> <!-- NOTICE_TITLE -->
		            <td>${notice.NOTICE_DATE}</td> <!-- NOTCIE_DATE -->
		          </tr>  
		    	</c:forEach>
			</c:when>
         </c:choose>
        </tbody>
      </table>
      <!-- 공지사항 테이블 링크 끝-->
	  
	  <!-- 검색창 (제목, 내용으로 검색) -->
	  <form>
	  <div class="row justify-content-center">
	  	<div class="input-group col-8 mb-3">
		  <select class="form-select col-3" id="searchType" name="searchType">
		    <option selected>선택</option>
		    <option value="title" <c:out value="${searchType eq 'title' ? 'selected' :''}"/>>제목</option>
		    <option value="content" <c:out value="${searchType eq 'content' ? 'selected' :''}"/>>내용</option>
		  </select>
		  
		  <input type="text" class="form-control" aria-label="Text input with dropdown button" value="${noticeTotalListPaging.keyword}"
		  		 name="keyword" id="keyword"> 
		  <button class="btn btn-outline-secondary" type="button" id="button-addon2" name="noticeSearch">검색</button>
		</div>

	  </div>
	  </form>
	  <!-- 검색창 end -->

	
      <!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${noticeTotalListPaging.pagingHTML}
			</nav>
	 <!-- 페이징 끝-->
      
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='adminNoticeWriteForm']").on("click", function(e) {  // 관리자 공지사항 작성 폼
		e.preventDefault();
		fn_adminNoticeWriteForm();
	});
	
	$("a[name='title']").on("click", function(e) {  // 공지사항 상세보기
		e.preventDefault();
	
		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
		fn_noticeDetail(num); //fn_noticeDetail()함수 매개변수로 num 전송
	});
	
	$("button[name='noticeSearch']").on("click", function(e){  //공지사항 검색
		e.preventDefault();
		fn_noticeSearch();
	});
	
	function fn_adminNoticeWriteForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/noticeWriteForm");
		comSubmit.submit();
	};
	
	function fn_noticeDetail(num) {  //num 매개변수로 넣기
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/help/noticeDetail");
		comSubmit.addParam("NOTICE_NUM", num); //num을 NOTICE_NUM 파라미터 값으로 전송
		comSubmit.addParam("MEM_ADMIN", '${MEM_ADMIN}'); //상세보기 페이지로 MEM_ADMIN 파라미터값 전송
		comSubmit.submit();
	};
	
	function fn_noticeSearch(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/help/noticeList");
		comSubmit.addParam("keyword", $('#keyword').val());
		comSubmit.addParam("searchType", $('#searchType').val());
		comSubmit.submit();
	}
	
});
</script>
  </body>
</html>
