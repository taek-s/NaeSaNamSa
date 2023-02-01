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
        <a href="/ns/main" class="text-dark">
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
              무엇을 도와드릴까요?
            </h2>
          </div>
        </div>
        <!-- 타이틀 끝-->

        <hr style="border: solid 1px black" />

        <!--  최신 공지사항 링크 --> 
        <div class="row flex-column" style="background-color:#F6F6F6;">
          <div class="col-auto mt-3 mb-3">
          	<span class="fw-bold me-2 text-success">공지</span>
          	<c:choose>
          		<c:when test="${fn:length(mainNoticeList) > 0}">
          			<c:forEach items="${mainNoticeList}" var="notice"> 
			            <a href="/ns/main" 
			              class="fw-lignt link-dark"
			              data-num="${notice.NOTICE_NUM}"
			              name="noticeDetail"
			            >${notice.NOTICE_TITLE}
			            </a>
			        </c:forEach>
			    </c:when>
			    <c:otherwise>
			    	등록된 공지사항이 없습니다.
			    </c:otherwise>
            </c:choose>
          </div>
        </div>
        <!-- 최신 공지사항 링크 끝-->

		
        <!-- 공지사항 faq 고객센터문의 신고 이미지링크 -->
        <div class="row pt-1 pb-4">
        	<div class="col-3 text-center fs-4">
        		<a href="/ns/help/noticeList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/공지2.jpg" width=80%; height=90%; class="mx-auto d-block justify-content-center"/>
        			<span class="h6 fw-bold">공지사항</span>
        		</a>
			</div>
        	
        	<div class="col-3 text-center fs-4">
        		<a href="/ns/help/faqList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/faq.jpg" width=80%; height=90%; class="mx-auto d-block"/>
        			<span class="h6 fw-bold">FAQ</span>
        		</a>
        	</div>
        	
        	<div class="col-3 text-center fs-4">
        		<a href="/ns/myPage/csList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/cs.jpg" width=75%; height=90%; class="mx-auto d-block"/>
        			<span class="h6 fw-bold">고객센터 문의</span>
        		</a>
        	</div>
        	
        	<div class="col-3 text-center fs-4">
        		<a href="/ns/myPage/reportList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/신고.jpg" width=70%; height=90%; class="mx-auto d-block"/>
        			<span class="h6 fw-bold">신고</span>
        		</a>
        	</div>
        
        </div>
        <!-- 공지사항 faq 고객센터문의 신고 이미지링크 끝 -->

        <hr style="border: solid 1px black " />

        <!-- faq링크 -->
        <div class="row">
          <div class="col-auto mt-3 mb-3">
            <h3
              class="fs-2 fw-semibold mb-0"
            >
              여기서 빠르게 해결하세요
            </h3>
          </div>
        </div>
		
		<c:choose>
			<c:when test="${fn:length(faqList) > 0}">
				<c:forEach items="${faqList}" var="faq">
			        <div class="row flex-column">
			          <div class="col-auto mt-3 mb-3 fs-5">
			          	<span class="fw-bold me-2 text-success">Q</span>
			            <a href="#" 
			              class="fw-normal link-dark"
			              data-num="${faq.FAQ_NUM }"
			              name="faqDetail"
			            >
			              ${faq.FAQ_TITLE}
			            </a>
			          </div>
			        </div>
		        </c:forEach>
		    </c:when>
		    <c:otherwise>
		    	조회된 FAQ가 없습니다.
		    </c:otherwise>
        </c:choose>
         <!-- faq링크 끝-->
    </div>

<script type="text/javascript">
$(document).ready(function() {
	
	
	$("a[name='noticeDetail']").on("click", function(e) {  // 최신 공지사상 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");
		fn_noticeDetail(num);
	});
	
	$("a[name='faqDetail']").on("click", function(e){  //최신 FAQ 상세보기
		e.preventDefault();
	
		const num = $(this).attr("data-num");
		fn_faqDetail(num);
	});
	
	function fn_noticeDetail(num) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/help/noticeDetail");
		comSubmit.addParam("NOTICE_NUM", num);
		comSubmit.addParam("MEM_ADMIN", '${MEM_ADMIN}');
		comSubmit.submit();
	};
	
	function fn_faqDetail(num){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/help/faqDetail");
		comSubmit.addParam("FAQ_NUM", num);
		comSubmit.addParam("MEM_ADMIN", '${MEM_ADMIN}');
		comSubmit.submit();
	}
	
	
});
</script>

  </body>
</html>
