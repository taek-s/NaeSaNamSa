<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<style>
  	pre{
  		background:#E9ECEF;
	    padding:10px;
	    overflow: auto;
	    white-space: pre-wrap;  /* pre tag내에 word wrap */
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
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">댓글 내용</label>
            <textarea class="form-control" id="REPORT_REPLY_CONTENT" name="REPORT_REPLY_CONTENT" rows="10" required></textarea>
          	  <div class="invalid-feedback">
		        신고 내용에 대한 답변을 작성해주세요
		      </div>
          </div>
        </form>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">삭제</button>
        <button type="button" class="btn btn-primary" name="reportReplyWrite" id="reportReplyWrite">댓글등록</button>
        <button type="button" class="btn btn-primary" name="reportReplyModify" id="reportReplyModify">댓글수정</button>
      </div>
      
    </div>
  </div>
</div>
<!-- modal end -->

<div class="container text-start pt-5 pb-5 border bg-light">
	
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

	<div class="row text-center mb-3">
        	<h2 class="fs-1 fw-semibold">신고 내역 상세 보기</h2>
    </div>
    
    <!-- 관리자 전용 삭제 버튼 -->
    <div class="row justify-content-end mb-1">
    	<div class="col-4 text-end">
	  		<button type="button" class="btn-sm btn-primary" name="reportDelete">삭제</button> 
		</div>
    </div>
    <!-- 삭제버튼 끝-->
	
	<!-- 작성일 -->
	<div class="row justify-content-center mb-3">
		<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">작성일
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9 align-self-center text-start fw-semibold">${reportDetailMap.REPORT_DATE}
    	</div>
	</div>
	<!-- 작성일 끝 -->
	    
    <!-- 신고유형 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">유형
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9 align-self-center text-start fw-bold fs-5">${reportDetailMap.REPORT_TYPE}
    	</div>
    </div>
    <!-- 신고유형 끝 -->
    	
    <!-- 닉네임 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">닉네임</div>
    	<div class="col-lg-3 col-md-3 col-sm-3 align-self-center text-start fw-semibold">${reportDetailMap.MEM_NICKNAME}
    	</div>
    	<div class="col-lg-8 col-md-6 col-sm-6"></div>
    </div>
    <!-- 닉네임 끝-->
    
    <!-- 제목 구현 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">제목
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9">
		  <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;" id="REPORT_TITLE" name="REPORT_TITLE" readonly>${reportDetailMap.REPORT_TITLE}</pre>
		</div>
    </div>
    
    <!-- 내용 구현 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">내용
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9">
		  <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;" id="REPORT_CONTENT" name="REPORT_CONTENT" rows="7" style="height:80px" readonly>${reportDetailMap.REPORT_CONTENT}</pre>
		</div>
    </div>
    
    <!-- 관리자 전용 -->
   <c:if test="${session.MEM_ADMIN == 'Y'}">
    <div class="row justify-content-center mt-3">
    	<div class="col-12 text-end">
    	<c:if test="${reportReplyMap.REPORT_REPLY_CONTENT == null}">  <!-- 댓글이 없을 때만 보임 -->
	  		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="댓글작성">댓글달기</button>
	  	</c:if>
	  	
	  	<c:if test="${reportReplyMap.REPORT_REPLY_CONTENT != null}">  <!-- 댓글이 있을 때만 보임 -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="댓글수정">수정</button>
			<button type="button" class="btn btn-primary" id="reportReplyDelete" name="reportReplyDelete">삭제</button>
		</c:if>
		</div>
	 </div>
	</c:if>
	<!-- 관리자 전용 end -->
	
	<!-- 댓글 내용 구현 --> <!-- 댓글이 없을 시 보이지 않음 -->
	<c:if test="${reportReplyMap.REPORT_REPLY_CONTENT != null}"> 
    	<div class="row justify-content-center mt-3 mb-3">
    		<div class="col-lg-1 col-md-3 col-sm-3 text-start" style="font-size:13px">관리자 답변
    		</div>
	    	<div class="col-lg-11 col-md-9 col-sm-9">
			  <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;" id="REPORT_REPLY_CONTENT" name="REPORT_REPLY_CONTENT" rows="7" readonly>${reportReplyMap.REPORT_REPLY_CONTENT}</pre>
			</div>
    	</div>
   </c:if>
   <!-- 댓글 내용 끝-->
	
    	
</div>
    	
<script type="text/javascript">
const exampleModal = document.getElementById('exampleModal'); 
exampleModal.addEventListener('show.bs.modal', event => {
	
  const button = event.relatedTarget;
  console.log(button);
  
  const recipient = button.getAttribute('data-bs-whatever');
  const modalTitle = exampleModal.querySelector('.modal-title');
  

  modalTitle.textContent = recipient;
  
  if(recipient == '댓글작성') {
	  $("button[name='reportReplyWrite']").show();
	  $("button[name='reportReplyModify']").hide();
  } else if(recipient == '댓글수정') {
	  $("button[name='reportReplyWrite']").hide();
	  $("button[name='reportReplyModify']").show();
  }
  
}); // 모달 설정


$(document).ready(function() {
	
	$("button[name='reportDelete']").on("click", function(e) { // 신고 삭제
		e.preventDefault();
		fn_reportDelete();
	});
	
	$("button[name='reportReplyDelete']").on("click", function(e) { // 신고 댓글 삭제
		e.preventDefault();
		fn_reportReplyDelete();
	});
	
	//textarea 내용 길면 칸 커지고, 내용 짧으면 칸 작아지는거,, 안되네,, 왜안될까..어떻게 하는거지
	$("#REPORT_CONTENT").on("propertychange change keyup paste input",function(){
	       $(this)[0].style.height='auto';
	       $(this).height( $(this).prop('scrollHeight'));     
	});
	
	
	function fn_reportDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/reportDelete");
		comSubmit.addParam("REPORT_NUM", ${reportDetailMap.REPORT_NUM});
		comSubmit.submit();
		alert("삭제되었습니다.");
	};
	
	function fn_reportReplyWrite() {
		var comSubmit = new ComSubmit("modalForm");
		comSubmit.setUrl("/ns/admin/reportReplyWrite");
		comSubmit.addParam("REPORT_NUM", ${reportDetailMap.REPORT_NUM});
		comSubmit.addParam("MEM_NUM", ${reportDetailMap.REPORT_WRITER});
		comSubmit.submit();
	};
	
	function fn_reportReplyModify() {
		var comSubmit = new ComSubmit("modalForm");
		comSubmit.setUrl("/ns/admin/reportReplyModify");
		comSubmit.addParam("REPORT_NUM", ${reportDetailMap.REPORT_NUM});
		comSubmit.submit();
	};
	
	function fn_reportReplyDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/reportReplyDelete");
		comSubmit.addParam("REPORT_NUM", ${reportDetailMap.REPORT_NUM});
		comSubmit.submit();
	};
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

	  // Loop over them and prevent submission
		$("button[name='reportReplyWrite']").on("click", function(e) { // 신고 댓글 작성
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let contentval = $('#REPORT_REPLY_CONTENT').val();
		
		//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 666){
			alert("내용을 최대 666글자로 작성해주세요.")
			$('#REPORT_REPLY_CONTENT').focus()
			return false;
		}
		
		fn_reportReplyWrite();
	  });
		  
		  
	  $("button[name='reportReplyModify']").on("click", function(e) { // 신고 댓글 수정
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let contentval = $('#REPORT_REPLY_CONTENT').val();
		
		//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 666){
			alert("내용을 최대 666글자로 작성해주세요.")
			$('#REPORT_REPLY_CONTENT').focus()
			return false;
		}
		
		fn_reportReplyModify();
	  });

	})()
	
});
</script> 
    
</body>