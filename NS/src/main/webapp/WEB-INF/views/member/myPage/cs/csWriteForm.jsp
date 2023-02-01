<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<div class="container text-center pt-5 pb-5 border bg-light">
	<div class="row text-center mb-3">
        	<h2 class="fs-1 fw-semibold">고객센터 문의하기</h2>
    </div>
    
    <form id="csWriteForm" enctype="multipart/form-data" class="needs-validation" novalidate>
    <!-- 제목 -->
    <div class="row justify-content-center mb-4">
    	<div class="col-2 align-self-center text-center">제목
    	</div>
    	<div class="col-9">
		  <input type="text" class="form-control" id="CS_TITLE" name="CS_TITLE" placeholder="제목을 입력해주세요" required>
		  <div class="invalid-feedback text-start">
        	제목을 입력해주세요
      	  </div>
		</div>
		
    </div>
    <!-- 제목 끝 -->
    	
    <!-- 내용 -->
    <div class="row justify-content-center mb-4">
    	<div class="col-2 align-self-center text-center">내용
    	</div>
    	<div class="col-9">
		  <textarea class="form-control" id="CS_CONTENT" name="CS_CONTENT" rows="9" required></textarea>
			<div class="invalid-feedback text-start">
        		내용을 입력해주세요
      		</div>
		</div>
		
    </div>
    <!-- 내용 끝-->
    
    <!-- 파일 업로드 -->
    <div class="row justify-content-center mt-3">
    	<div class="col-2 align-self-center text-end"></div>
    	<div class="col-4">
			<input class="form-control" type="file" id="csImgUpload" name="csImgUpload">
		</div>
		<div class="col-5 align-self-center text-end"></div>
    </div>
    <!-- 파일 업로드 END -->
    	
    <!-- 버튼 -->
    <div class="row justify-content-center mt-3">
    	<div class="col-11 text-end">
	  		<button type="button" class="btn btn-primary" name="csWrite">등록</button>
			<button type="button" class="btn btn-primary" onclick="javascript:history.back()">취소</button>
		</div>
	</div>
	<!-- 버튼 end -->
	</form>
	
    	
</div>
    	
<script type="text/javascript">

$(document).ready(function() {
	
	
	
	function fn_csForm() {
		var formData = new FormData(document.getElementById("csWriteForm"));
		var fileInput = document.getElementById("csImgUpload"); //id로 파일 태그를 호출
        var files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
        
        for (var i = 1; i < files.length; i++) {
            formData.append('file-'+i, files[i]); //업로드한 파일을 하나하나 읽어서 FormData 안에 넣는다.
        }
        
        $.ajax({
            url: "/ns/myPage/csWrite",
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            dataType: 'text',
            success: function(result){
            	fn_csDetail(result);
          },
          error: function(xhr,textStatus,error){
                                  
              console.log("textStatus: "+xhr.status+", error: "+error);
              alert("예상치 못한 오류가 발생했습니다.");
              
          }
      });
        
	};
	
	function fn_csDetail(result) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/csDetail");
		comSubmit.addParam("CS_NUM", result);
		comSubmit.submit();
	};
	
	//유효성 검사
	(() => {
		  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')

	  // Loop over them and prevent submission
	  $("button[name='csWrite']").on("click", function(e) { // 고객센터 문의 작성
			e.preventDefault();
			form.classList.add('was-validated')
			
			if (!form.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		        return false;
		    }
			
			//입력한 제목과 내용을 각각 변수에 저장
			let titleval = $('#CS_TITLE').val();
			let contentval = $('#CS_CONTENT').val();
			
			//제목, 내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
			//제목 최대 133글자 입력 가능 (title 최대 400byte (오라클 기준 한글 1글자당 3byte))
			if(titleval.length > 133){
				alert("제목을 최대 133글자로 작성해주세요.")
				$('#CS_TITLE').focus()
				return false;
			}
			
			//내용 최대 666글자 입력 가능 (content 최대 2000byte (오라클 기준 한글 1글자당 3byte))
			if(contentval.length > 666){
				alert("내용을 최대 666글자로 작성해주세요.")
				$('#CS_CONTENT').focus()
				return false;
			}
			
			fn_csForm();
		  });

	})()
	
});
</script> 
    
</body>