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
              관리자 전용 페이지
            </h2>
          </div>
        </div>
        <!-- 타이틀 끝-->

        <hr style="border: solid 1px black" />
		
        <!-- 공지사항 faq 고객센터문의 이미지링크 -->
        <div class="row pt-1 pb-4">
        	<div class="col-4 text-center fs-4">
        		<a href="/ns/help/noticeList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/공지2.jpg" width=50%; height=90%; class="mx-auto d-block justify-content-center"/>
        			<span class="h6 fw-bold">공지사항</span>
        		</a>
			</div>
        	
        	<div class="col-4 text-center fs-4">
        		<a href="/ns/help/faqList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/faq.jpg" width=50%; height=90%; class="mx-auto d-block"/>
        			<span class="h6 fw-bold">FAQ</span>
        		</a>
        	</div>
        	
        	<div class="col-4 text-center fs-4">
        		<a href="/ns/admin/csList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/cs.jpg" width=50%; height=90%; class="mx-auto d-block"/>
        			<span class="h6 fw-bold">고객센터 문의</span>
        		</a>
        	</div>
        </div>
        
        <div class="row pt-1 pb-4">
        	<div class="col-6 text-center fs-4">
        		<a href="/ns/admin/reportList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/신고.jpg" width=40%; height=80%; class="mx-auto d-block justify-content-center"/>
        			<span class="h6 fw-bold">신고</span>
        		</a>
			</div>
        	
        	<div class="col-6 text-center fs-4">
        		<a href="/ns/admin/userList" class="text-dark">
        			<img src="<%=request.getContextPath() %>/image/회원관리2.png" width=40%; height=80%; class="mx-auto d-block"/>
        			<span class="h6 fw-bold">회원관리</span>
        		</a>
        	</div>
        </div>
        <!-- 공지사항 faq 고객센터문의 이미지링크 끝 -->

        <hr style="border: solid 1px black " />
    </div>
    

  </body>
</html>
