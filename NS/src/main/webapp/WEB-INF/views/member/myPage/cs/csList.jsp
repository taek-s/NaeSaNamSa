<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<div class="container text-center pt-5 pb-5">
	<div class="row text-center mb-3">
        	<h2 class="fs-1 fw-semibold">나의 문의 내역</h2>
    </div>
    
    <div class="row justify-content-end mb-3">
    	<div class="col-auto">
        	<button type="button" class="btn btn-secondary" name="csWriteForm">문의 작성</button>
        </div>
    </div>
    
	    <table class="table" style="table-layout:fixed">
		   <thead class="table-secondary">
		    <tr>
		      <th scope="col" style="width:56px;">번호</th>
		      <th scope="col">제목</th>
		      <th scope="col" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; width:150px;">작성일</th>
		    </tr>
		  </thead>
		  <tbody>
		  
		  <c:choose>
        	<c:when test="${fn:length(csList) > 0}">
			  <c:forEach var="csList" items="${csList}" varStatus="status" begin="0" end="10">
			  	 <tr>
			      <th scope="row">${number - status.index}</th> 
			      <td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; max-width:200px;" title="${csList.CS_TITLE}"><a href="#" class="text-dark" name="title" data-num="${csList.CS_NUM}">${csList.CS_TITLE }</a></td>
			      <td>${csList.CS_DATE }</td>
			   		</tr>
			    </c:forEach>
		      </c:when>
         	</c:choose>
		    
		  </tbody>
		</table>
</div>
				<!-- 페이징 -->
	            <nav aria-label="Page navigation example">
	           	  ${csListPaging.pagingHTML}
				</nav>
				<!-- 페이징 끝-->

  
<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='title']").on("click", function(e) { // 고객센터 문의 상세보기
		e.preventDefault();
		const num = $(this).attr('data-num');
		fn_csDetail(num);
	});
	
	$("button[name='csWriteForm']").on("click", function(e) { // 고객센터 문의 작성 폼
		e.preventDefault();
		fn_csWriteForm();
	});
	
	function fn_csDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/csDetail");
		comSubmit.addParam("CS_NUM", num);
		comSubmit.submit();
	};
	
	function fn_csWriteForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/csWriteForm");
		comSubmit.submit();
	};
	
});
</script> 

</body>
</html>