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
              회원 관리 리스트
            </h2>
          </div>
   
        </div>
        <!-- 타이틀 끝-->

        <hr style="border: solid 1px black" />

 
        <!-- 공지사항 테이블 링크 -->
        
        <table class="table">
		  <thead>
		    <tr>
		      <th scope="col">회원 번호</th>
		      <th scope="col">이메일</th>
		      <th scope="col">이름</th>
		      <th scope="col">닉네임</th>
		      <th scope="col">가입일</th>
		      <th scope="col">탈퇴여부</th>     
		    </tr>
		  </thead>
		  <tbody>
		  
		 <c:choose>
		 	<c:when test="${fn:length(userList) > 0 }">
		 		<c:forEach items="${userList}" var="user">
		 			<tr>
				      <th scope="row">${user.MEM_NUM }</th> <!-- MEM_NUM -->
					      <td><a href="#" name="memDetail" data-num="${user.MEM_NUM }">${user.MEM_EMAIL }</a></td> <!-- MEM_EMAIL -->
					      <td>${user.MEM_NAME }</td> <!-- MEM_NAME -->
					      <td>${user.MEM_NICKNAME }</td> <!-- MEM_NICKNAME -->
					      <td>${user.MEM_JOINDATE }</td> <!-- MEM_JOINDATE -->
					      <td>${user.MEM_DEL_GB }</td> <!-- MEM_DEL_GB -->
				      
		   		 	</tr>
		 		</c:forEach>
		 	</c:when>
		 </c:choose>
		      
		  </tbody>
		</table>
		
		<!-- 공지사항 테이블 링크 끝-->

        <hr style="border: solid 1px black " />
        
        
		
	 <!-- 검색창 -->
     <form id="searchForm">
     <div class="row justify-content-center">
        <div class="input-group col-6 mb-3">
        <select class="form-select col-3" name="searchType" id="searchType">
          <option selected>선택</option>
          <option value="num" <c:out value="${adminUserListPaging.searchType eq 'num' ? 'selected' : ''}"/>>회원 번호</option>
          <option value="email" <c:out value="${adminUserListPaging.searchType eq 'email' ? 'selected' : '' }"/>>이메일</option>
          <option value="name" <c:out value="${adminUserListPaging.searchType eq 'name' ? 'selected' : '' }" />>이름</option>
          <option value="nickname" <c:out value="${adminUserListPaging.searchType eq 'nickname' ? 'selected' : '' }" />>닉네임</option>
          <option value="joindate" <c:out value="${adminUserListPaging.searchType eq 'joindate' ? 'selected' : '' }" />>가입일('YY/MM/DD')</option>
          <option value="del_gb" <c:out value="${adminUserListPaging.searchType eq 'del_gb' ? 'selected' : '' }" />>탈퇴여부</option>
        </select>
        <input type="text" class="form-control" aria-label="Text input with dropdown button" id="keyword" name="keyword" value="${adminUserListPaging.keyword }" >
        <button class="btn btn-outline-secondary" type="submit" id="search" name="search" >검색</button>
      </div>
     </div>
     </form>
     <!-- 검색창 end -->
        
        <!-- 페이징 -->
          <nav aria-label="Page navigation example">
           	  ${adminUserListPaging.pagingHTML}
			</nav>
		<!-- 페이징 끝-->
    </div>

<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='memDetail']").on("click", function(e) {  // 관리자 회원 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");
		fn_memDetail(num);
	});
	
	
	function fn_memDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/userDetail");
		comSubmit.addParam("MEM_NUM", num);
		comSubmit.submit();
	};
	
	$("button[name='search']").on("click", function(e) { //회원 검색
		e.preventDefault();
	
		//검색조건이 회원 번호일 경우, 숫자로만 입력하도록 설정
		if ($("#searchType").val() == 'num'){
			let keyword = $("#keyword").val();
			if(!(keyword >= 0 && keyword < 999)){
				alert("숫자로 입력해주세요");
				return false;
			}
		}
		
		fn_searchMember();
	});
	
	function fn_searchMember(){  //회원검색
		var comSubmit = new ComSubmit();
		let keyword = $("#keyword").val();
		comSubmit.setUrl("/ns/admin/userList");
		comSubmit.addParam("keyword", keyword);
		comSubmit.addParam("searchType", $("#searchType").val());
		comSubmit.submit();	
	};
	
});
</script>

  </body>
</html>