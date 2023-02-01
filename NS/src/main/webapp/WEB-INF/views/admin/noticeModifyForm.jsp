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
            공지사항 수정
          </h2>
        </div>
      </div>
      <!-- 타이틀 끝-->
	
	  <!-- 공지사항 수정 (기존 공지사항 제목, 내용 가져오기) -->
	  <form id="noticeForm" class="needs-validation" novalidate>
	  <div class="row mb-4">
	  	<div class="form-floating mb-3">
		  <input type="text" class="form-control" id="NOTICE_TITLE" name="NOTICE_TITLE" value="${noticeDetail.NOTICE_TITLE}" required> 
		  <label for="NOTICE_TITLE" class="ms-3"> Title</label>
		</div>
		<div class="form-floating">
		  <textarea class="form-control" id="NOTICE_CONTENT" name="NOTICE_CONTENT" style="height:350px" required>${noticeDetail.NOTICE_CONTENT}</textarea>
		  <label for="NOTICE_CONTENT" class="ms-3"> Content&nbsp;&nbsp;&nbsp;<span class="textCount">0자</span><span class="textTotal">/1333자</span></label>
		</div>
	  </div>
	  </form>
	  <!-- 공지사항 수정 end -->
	  
	  <!-- 등록 취소 버튼 -->
	  <div class="row mb-4 justify-content-center">
	  	<div class="col-12 text-end">
		  	<button class="btn btn-primary me-md-2" type="button" name="adminNoticeModify">수정</button>
	        <button class="btn btn-primary" type="button" name="noticeList">취소</button>
	    </div>
	  </div>
	  <!-- 등록 취소 버튼 end -->
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='noticeList']").on("click", function(e) {  // 공지사항 리스트로 돌아가기
		e.preventDefault();
		fn_noticeList();
	});
	
	function fn_adminNoticeModify() {
		var comSubmit = new ComSubmit("noticeForm");
		comSubmit.setUrl("/ns/admin/noticeModify");
		comSubmit.addParam("NOTICE_NUM", ${noticeDetail.NOTICE_NUM});
		alert("공지사항 수정이 완료되었습니다.");
		comSubmit.submit();
	};
	
	function fn_noticeList() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/help/noticeList");
		comSubmit.submit();
	};
	
	$('#NOTICE_CONTENT').keyup(function (e) {
		let content = $(this).val();
	    
	    // 글자수 세기
	    if (content.length == 0 || content == '') {
	    	$('.textCount').text('0자');
	    } else {
	    	$('.textCount').text(content.length + '자');
	    }
	    
	    // 글자수 제한
	    if (content.length > 1333) {
	    	// 1334자 부터는 타이핑 되지 않도록
	        $(this).val($(this).val().substring(0, 1333));
	        // 1333자 넘으면 알림창 뜨도록
	        alert('글자수는 1333자까지 입력 가능합니다.');
	    };
	});
	
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

	  // Loop over them and prevent submission
	  $("button[name='adminNoticeModify']").on("click", function(e) {  // 관리자 공지사항 작성
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let titleval = $('#NOTICE_TITLE').val();
		let contentval = $('#NOTICE_CONTENT').val();
		
		//제목, 내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
		//제목 최대 133글자 입력 가능 (title 최대 400byte (오라클 기준 한글 1글자당 3byte))
		if(titleval.length > 133){
			alert("제목을 최대 133글자로 작성해주세요.")
			$('#NOTICE_TITLE').focus()
			return false;
		}
		
		//내용 최대 1333글자 입력 가능 (content 최대 4000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 1333){
			alert("내용을 최대 1333글자로 작성해주세요.")
			$('#NOTICE_CONTENT').focus()
			return false;
		}
		
		fn_adminNoticeModify();
	  });

	})()
	
});
</script>
    
  </body>
</html>
