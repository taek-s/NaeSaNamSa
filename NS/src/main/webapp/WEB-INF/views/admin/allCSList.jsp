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
        <a href="/ns/admin/main" class="text-dark">
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
              고객센터 문의 리스트
            </h2>
          </div>
   
        </div>
        <!-- 타이틀 끝-->

        <hr style="border: solid 1px black" />

 
        <!-- 고객센터 문의 리스트 테이블 -->
        <table class="table" style="table-layout:fixed">
		  <thead>
		    <tr>
		      <th scope="col" style="width:56px;">번호</th>
		      <th scope="col" class="col-auto">제목</th>
		      <th scope="col" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; width:155px;">닉네임</th>
      		  <th scope="col" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; width:120px;">작성날짜</th>
		          
		    </tr>
		  </thead>
		  <tbody>
		  <c:choose>
		  	<c:when test="${fn:length(csList) > 0}">
		  		<c:forEach items="${csList}" var="cs" varStatus="status" begin="0" end="10">
				    <tr>
				      <th scope="row">${number - status.index}</th>
				      <td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; max-width:200px;" title="${cs.CS_TITLE}"><a href="#" name="csDetail" data-num="${cs.CS_NUM}">${cs.CS_TITLE}</a>
				      <td><a href="#" name="userDetail" data-userMemNum="${cs.MEM_NUM}">${cs.MEM_NICKNAME}</a>
				      <td>${cs.CS_DATE}</td>
				    </tr>
			    </c:forEach>
		    </c:when>
		  </c:choose> 
		      
		  </tbody>
		</table>
		<!-- 고객센터 문의 리스트 테이블 end -->

        <hr style="border: solid 1px black " />
        
		<!-- 검색창 -->
     <form>
     <div class="row justify-content-center">
        <div class="input-group col-8 mb-3">
        <select class="form-select col-3" id="searchType" name="searchType">
          <option selected>선택</option>
          <option value="title" <c:out value="${adminCSTotalListPaging.searchType eq 'title' ? 'selected' :''}"/>>제목</option>
          <option value="content" <c:out value="${adminCSTotalListPaging.searchType eq 'content' ? 'selected' : ''}" />>내용</option>
          <option value="nickname" <c:out value="${adminCSTotalListPaging.searchType eq 'nickname' ? 'selected' : ''}" />>닉네임</option>
          
        </select>
        <input type="text" class="form-control" aria-label="Text input with dropdown button"
        		id="keyword" name="keyword" value="${adminCSTotalListPaging.keyword }">
        <button class="btn btn-outline-secondary" type="button" id="button-addon2" name="csSearch">검색</button>
      </div>
     </div>
     </form>
     <!-- 검색창 end -->
        
        <!-- 페이징 -->
            
            
           <nav aria-label="Page navigation example">
			  ${adminCSTotalListPaging.pagingHTML}
			</nav>
			
			 <!-- 페이징 끝-->

        
      
    </div>  
<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='csDetail']").on("click", function(e) {  // 고객센터 문의 상세보기
		e.preventDefault();
	
		const csNum = $(this).attr("data-num");
		fn_csDetail(csNum);
	});
	
	$("a[name='userDetail']").on("click", function(e) {  // 관리자 회원 상세보기
		e.preventDefault();
	
		const csUserMemNum = $(this).attr("data-userMemNum");
		fn_userDetail(csUserMemNum);
	});
	
	$("button[name='csSearch']").on("click", function(e){  //관리자 전체 cs 리스트 검색
		e.preventDefault();
		fn_csSearch();
	});
	
	
	function fn_csDetail(csNum) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/myPage/csDetail");
		comSubmit.addParam("CS_NUM", csNum);
		comSubmit.submit();
	};
	
	function fn_userDetail(csUserMemNum) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/userDetail");
		comSubmit.addParam("MEM_NUM", csUserMemNum);
		comSubmit.submit();
	};
	
	function fn_csSearch(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/csList");
		comSubmit.addParam("keyword", $('#keyword').val());
		comSubmit.addParam("searchType", $('#searchType').val());
		comSubmit.submit();
	}
	
	
});
</script>

  </body>
</html>