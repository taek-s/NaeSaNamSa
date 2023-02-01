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
	    white-space: pre-wrap; /* pre tag내에 word wrap */
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
        <button type="button" class="btn-close" daqjsta-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="modalForm" name="modalForm" class="needs-validation" novalidate>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">댓글 내용</label>
            <textarea class="form-control" id="CS_REPLY_CONTENT" name="CS_REPLY_CONTENT" rows="10" required></textarea>
          	 <div class="invalid-feedback text-start">
	        	고객 문의에 대한 답변을 입력해주세요
	      	 </div>
          
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" name="csReplyWrite" id="csReplyWrite">댓글등록</button>
        <button type="button" class="btn btn-primary" name="csReplyModify" id="csReplyModify">댓글수정</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->

<div class="container text-start pt-5 pb-5 border bg-light">
	<!-- 뒤로가기  -->
      <a href="/ns/myPage/csList" class="text-dark">
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
        	<h2 class="fs-1 fw-semibold">문의 내역 상세 보기</h2>
    </div>
    
    <!-- 삭제버튼 -->
    <div class="row justify-content-end mb-1">
    	<div class="col-4 text-end">
	  		<button type="button" class="btn-sm btn-primary" name="csDelete">삭제</button> <!-- 같이 쓰기 -->
		</div>
    </div>
    <!-- 삭제버튼 끝-->
    
	<!-- 작성일 -->
	<div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">작성일
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9 align-self-center text-start fw-semibold">${csDetail.CS_DATE}
    	</div>
	</div>    
	<!-- 작성일 끝 -->
    	
    <!-- 닉네임 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">닉네임</div>
    	<div class="col-lg-3 col-md-3 col-sm-3 align-self-center text-start fw-semibold">${csDetail.MEM_NICKNAME}</div>
    	<div class="col-lg-8 col-md-6 col-sm-6"></div>
    </div>
    <!-- 닉네임 끝-->
    
    <!-- 제목 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">제목
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9">
    	  <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;" id="CS_TITLE" name="CS_TITLE" value="${csDetail.CS_TITLE}" readonly>${csDetail.CS_TITLE}</pre>
		</div>
    </div>
    <!-- 제목 끝 -->
    	
    <!-- 내용 -->
    <div class="row justify-content-center mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 align-self-center text-start" style="font-size:13px">내용
    	</div>
    	<div class="col-lg-11 col-md-9 col-sm-9">
		  <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;" id="CS_CONTENT" name="CS_CONTENT" rows="7" readonly>${csDetail.CS_CONTENT}</pre>
		</div>
    </div>
    <!-- 내용 끝-->
    
    <!-- 파일 다운로드 -->
    <div class="row justify-content-center mt-3">
    	<div class="col-1"></div>
    	<div class="col-5 text-start">
			<a href="#" name="fileDownload">${csDetail.FILES_ORGNAME }</a>
		</div>
		<div class="col-6"></div>
    </div>
    <!-- 파일 다운로드 END -->
    	
    <!-- 관리자 전용 -->
    <c:if test="${map.MEM_ADMIN == 'Y'}">
    <div class="row justify-content-center mt-3">
    	<div class="col-12 text-end">
    	<c:if test="${csReplyDetail.CS_REPLY_CONTENT == null}">
	  		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="댓글작성">댓글달기</button> <!-- 댓글이 없을 때만 보임 -->
	  	</c:if>
	  	<c:if test="${csReplyDetail.CS_REPLY_CONTENT != null}">
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="댓글수정">수정</button> <!-- 댓글이 있을 때만 보임 -->
			<button type="button" class="btn btn-primary" id="csReplyDelete" name="csReplyDelete">삭제</button> <!-- 댓글이 있을 때만 보임 -->
		</c:if>
		</div>
	</div>
	</c:if>
	<!-- 관리자 전용 end -->
	
	<!-- 댓글 내용 --> <!-- 댓글이 없을 시 보이지 않음 -->
	<c:if test="${csReplyDetail.CS_REPLY_CONTENT != null}">
    <div class="row justify-content-center mt-3 mb-3">
    	<div class="col-lg-1 col-md-3 col-sm-3 text-start" style="font-size:13px">관리자 답변
    		</div>
	    	<div class="col-lg-11 col-md-9 col-sm-9">
		  <pre class="card-text" style="font-family: 'Gowun Dodum', sans-serif;"id="CS_REPLY_CONTENT" name="CS_REPLY_CONTENT" rows="7" readonly>${csReplyDetail.CS_REPLY_CONTENT}</pre>
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
	  $("button[name='csReplyWrite']").show();
	  $("button[name='csReplyModify']").hide();
  } else if(recipient == '댓글수정') {
	  $("button[name='csReplyWrite']").hide();
	  $("button[name='csReplyModify']").show();
  }
  
}); // 모달 설정


$(document).ready(function() {
	
	$("button[name='csDelete']").on("click", function(e) { // 고객센터 문의 삭제
		e.preventDefault();
		fn_csDelete();
	});
	
	$("button[name='csReplyDelete']").on("click", function(e) { // 고객센터 문의 댓글 삭제
		e.preventDefault();
		fn_csReplyDelete();
	});
	
	$("a[name='fileDownload']").on("click", function(e) { // 파일 다운로드
		e.preventDefault();
		fn_fileDownload();
	});
	
	function fn_csDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/csDelete");
		comSubmit.addParam("CS_NUM", ${csDetail.CS_NUM});
		comSubmit.submit();
	};
	
	function fn_csReplyWrite() {
		var comSubmit = new ComSubmit("modalForm");
		comSubmit.setUrl("/ns/admin/csReplyWrite");
		comSubmit.addParam("CS_NUM", ${csDetail.CS_NUM});
		comSubmit.addParam("MEM_NUM", ${csDetail.MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_csReplyModify() {
		var comSubmit = new ComSubmit("modalForm");
		comSubmit.setUrl("/ns/admin/csReplyModify");
		comSubmit.addParam("CS_NUM", ${csDetail.CS_NUM});
		comSubmit.submit();
	};
	
	function fn_csReplyDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/csReplyDelete");
		comSubmit.addParam("CS_NUM", ${csDetail.CS_NUM});
		comSubmit.submit();
	};
	
	function fn_fileDownload() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/common/fileDownload");
		comSubmit.addParam("FILES_NUM", ${csDetail.FILES_NUM});
		comSubmit.submit();
	};
	
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

	  // Loop over them and prevent submission
	 $("button[name='csReplyWrite']").on("click", function(e) { // 고객센터 문의 댓글 작성
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let contentval = $('#CS_REPLY_CONTENT').val();
		
		//내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
		//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 666){
			alert("내용을 최대 666글자로 작성해주세요.")
			$('#CS_REPLY_CONTENT').focus()
			return false;
		}
		
		fn_csReplyWrite();
	  });
		  
	  $("button[name='csReplyModify']").on("click", function(e) { // 고객센터 문의 댓글 수정
		e.preventDefault();
		form.classList.add('was-validated')
		
		if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	        return false;
	    }
		
		//입력한 제목과 내용을 각각 변수에 저장
		let contentval = $('#CS_REPLY_CONTENT').val();
		
		//내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
		//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
		if(contentval.length > 666){
			alert("내용을 최대 666글자로 작성해주세요.")
			$('#CS_REPLY_CONTENT').focus()
			return false;
		}
		
		fn_csReplyModify();
	  });

	})()
	
});
</script> 
    
</body>