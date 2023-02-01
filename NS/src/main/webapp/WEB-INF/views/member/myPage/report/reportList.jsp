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
        	<h2 class="fs-1 fw-semibold">나의 신고 내역</h2>
    </div>
    
	    <table class="table" style="table-layout:fixed">
		  <thead class="table-secondary">
		    <tr>
		      <th scope="col" style="width:56px;">번호</th>
		      <th scope="col" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; width:300px;">신고유형</th>
		      <th scope="col" class="col-auto">제목</th>
		      <th scope="col" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; width:120px;">작성일</th>
		    </tr>
		  </thead>
		  <tbody>		  
		  
		  <c:forEach var="reportList" items="${reportMap}" varStatus="status" begin="0" end="10">
		  	<tr>
		      <th scope="row">${number - status.index}</th>
		      <td>${reportList.REPORT_TYPE}</td>
		      <td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; max-width:200px;" title="${reportList.REPORT_TITLE}"><a href="#" class="text-dark" name="title" data-num="${reportList.REPORT_NUM}">${reportList.REPORT_TITLE}</a></td>
		      <td>${reportList.REPORT_DATE}</td>
		    </tr> 
		  </c:forEach>
		  </tbody>
		</table>
  
   			<!-- 페이징 -->
           <nav aria-label="Page navigation example">
           	  ${reportTotalListPaging.pagingHTML}
			</nav>
			<!-- 페이징 끝-->
    
</div>
  
<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='title']").on("click", function(e) { // 신고 상세보기
		e.preventDefault();
		const num = $(this).attr('data-num');
		console.log(num);
		fn_reportDetail(num);
	});
	
	function fn_reportDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/reportDetail");
		comSubmit.addParam("REPORT_NUM", num);
		comSubmit.submit();
	};
	
});
</script> 

</body>
</html>