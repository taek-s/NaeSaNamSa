<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <div class="container p-5">
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
            FAQ 수정
          </h2>
        </div>
      </div>
      <!-- 타이틀 끝-->
	
	  <!-- 공지사항 작성 -->
	  <form id="faqForm" class="needs-validation" novalidate>
	  <div class="row mb-4">
	  	<div class="form-floating mb-3">
		  <input type="text" class="form-control" id="FAQ_TITLE" name="FAQ_TITLE" value="${faqDetail.FAQ_TITLE}" required>
		  <label for="FAQ_TITLE" class="ms-3"> Title</label>
		  	<div class="invalid-feedback text-start">
	        	제목을 입력해주세요
	      	</div>
		</div>
		<div class="form-floating">
		  <textarea class="form-control" id="FAQ_CONTENT" name="FAQ_CONTENT" style="height: 350px" required>${faqDetail.FAQ_CONTENT}</textarea>
		  <label for="FAQ_CONTENT" class="ms-3"> Content&nbsp;&nbsp;&nbsp;<span class="textCount">0자</span><span class="textTotal">/666자</span></label>
		  	<div class="invalid-feedback text-start">
	        	내용을 입력해주세요
	      	</div>
		</div>
	  </div>
	  </form>
	  <!-- 공지사항 작성 end -->
	  
	  <!-- 등록 취소 버튼 -->
	  <div class="row mb-4 justify-content-center">
	  	<div class="col-12 text-end">
		  	<button class="btn btn-primary me-md-2" type="button" name="adminFAQModify">수정</button>
	        <button class="btn btn-primary" type="button" name="faqList">취소</button>
	    </div>
	  </div>
	  <!-- 등록 취소 버튼 end -->
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='faqList']").on("click", function(e) {  // FAQ 리스트로 돌아가기
		e.preventDefault();
		fn_faqList();
	});
	
	function fn_adminFAQModify() {
		var comSubmit = new ComSubmit("faqForm");
		comSubmit.setUrl("/ns/admin/faqModify");
		comSubmit.addParam("FAQ_NUM", ${faqDetail.FAQ_NUM});
		alert("FAQ 수정이 완료되었습니다.");
		comSubmit.submit();
	};
	
	function fn_faqList() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/help/faqList");
		comSubmit.submit();
	};
	
	$('#FAQ_CONTENT').keyup(function (e) {
		let content = $(this).val();
	    
	    // 글자수 세기
	    if (content.length == 0 || content == '') {
	    	$('.textCount').text('0자');
	    } else {
	    	$('.textCount').text(content.length + '자');
	    }
	    
	    // 글자수 제한
	    if (content.length > 666) {
	    	// 200자 부터는 타이핑 되지 않도록
	        $(this).val($(this).val().substring(0, 666));
	        // 200자 넘으면 알림창 뜨도록
	        alert('글자수는 666자까지 입력 가능합니다.');
	    };
	});
	
	(() => {
		  'use strict'

	// Fetch all the forms we want to apply custom Bootstrap validation styles to
	const form = document.querySelector('.needs-validation')

	// Loop over them and prevent submission
	$("button[name='adminFAQModify']").on("click", function(e) {  // 관리자 공지사항 작성
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	      event.preventDefault()
	      event.stopPropagation()
	      return false;
	  }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let titleval = $('#FAQ_TITLE').val();
		let contentval = $('#FAQ_CONTENT').val();
		
		//제목, 내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
		//제목 최대 133글자 입력 가능 (title 최대 400byte (오라클 기준 한글 1글자당 3byte))
		if(titleval.length > 133){
			alert("제목을 최대 133글자로 작성해주세요.")
			$('#NOTICE_TITLE').focus()
			return false;
		}
		
		//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 666){
			alert("내용을 최대 666글자로 작성해주세요.")
			$('#NOTICE_CONTENT').focus()
			return false;
		}
		
		fn_adminFAQModify();
	});

	})()
	
});


</script>
    
  </body>
</html>
