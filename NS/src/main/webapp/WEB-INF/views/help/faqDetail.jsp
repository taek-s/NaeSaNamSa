<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
  <style>
  	pre{
	    padding:10px;
	    overflow: auto;
	    white-space: pre-wrap; /* pre tag내에 word wrap */
	}  
  </style>
    <meta charset="UTF-8" />
  </head>
  <body>
    <div class="container text-start p-5">
      <!-- 뒤로가기  -->
      <a href="javascript:history.back();" class="text-dark">
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
      <div class="row mb-4">
        <div class="col">
          <h2
            class="fs-1 fw-semibold"
          >
            자주 묻는 질문
          </h2>
        </div>
      </div>
      <!-- 타이틀 끝-->

	  <!-- FAQ 상세보기 (제목, 내용) -->
      <div class="card text-start">
        <div class="card-header fw-bold fs-4">${faqDetail.FAQ_TITLE}</div> <!-- FAQ_TITLE -->
        <div class="card-body">
          <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif; font-size:15px">${faqDetail.FAQ_CONTENT}</pre>
          
          <c:if test="${MEM_ADMIN == 'Y'}"> <!-- 관리자인 경우에만, FAQ 수정/삭제 버튼 표시 -->
	          <div class="d-grid gap-2 d-md-flex justify-content-md-end">
	            <button class="btn btn-primary me-md-2" type="button" name="adminFAQModifyForm">수정</button>
	            <button class="btn btn-primary" type="button" name="adminFAQDelete">삭제</button>
	          </div>
	      </c:if>
        </div>
      </div>
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='adminFAQModifyForm']").on("click", function(e) {  // 관리자 FAQ 수정 폼
		e.preventDefault();
		fn_adminFAQModifyForm();
	});
	
	$("button[name='adminFAQDelete']").on("click", function(e) {  // 관리자 FAQ 삭제
		e.preventDefault();
		fn_adminFAQDelete();
	});
	
	function fn_adminFAQModifyForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/faqModifyForm");
		comSubmit.addParam("FAQ_NUM", ${faqDetail.FAQ_NUM});  //FAQ 수정폼으로 FAQ_NUM 넘기기
		comSubmit.submit();
	};
	
	function fn_adminFAQDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/faqDelete");
		comSubmit.addParam("FAQ_NUM", ${faqDetail.FAQ_NUM}); //FAQ 삭제시 FAQ_NUM 넘기기
		alert("FAQ 삭제가 완료되었습니다.")
		comSubmit.submit();
	};
	
});
</script>
    
  </body>
</html>
