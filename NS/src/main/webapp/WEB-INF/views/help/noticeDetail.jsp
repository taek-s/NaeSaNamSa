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
            공지사항
          </h2>
        </div>
      </div>
      <!-- 타이틀 끝-->

      <div class="card text-start">
        <div class="card-header fw-bold fs-4">${noticeDetail.NOTICE_TITLE}</div> <!-- NOTICE_TITLE -->
        <div class="card-header text-muted">${noticeDetail.NOTICE_DATE} ${noticeDetail.NOTICE_TIME}</div> <!-- NOTICE_DATE -->
        <div class="card-body">
          <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;">${noticeDetail.NOTICE_CONTENT}</pre>
          <c:if test="${MEM_ADMIN == 'Y'}">
	          <div class="d-grid gap-2 d-md-flex justify-content-md-end">
	            <button class="btn btn-primary me-md-2" type="button" name="adminNoticeModifyForm">수정</button>
	            <button class="btn btn-primary" type="button" name="adminNoticeDelete">삭제</button>
	          </div>
          </c:if>
        </div>
      </div>
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='adminNoticeModifyForm']").on("click", function(e) {  // 관리자 공지사항 수정 폼
		e.preventDefault();
		fn_adminNoticeModifyForm();
	});
	
	$("button[name='adminNoticeDelete']").on("click", function(e) {  // 관리자 공지사항 삭제
		e.preventDefault();
		fn_adminNoticeDelete();
	});
	
	function fn_adminNoticeModifyForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/noticeModifyForm");
		comSubmit.addParam("NOTICE_NUM", ${noticeDetail.NOTICE_NUM});
		comSubmit.submit();
	};
	
	function fn_adminNoticeDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/noticeDelete");
		comSubmit.addParam("NOTICE_NUM", ${noticeDetail.NOTICE_NUM});
		comSubmit.submit();
	};
	
});
</script>
    
  </body>
</html>
