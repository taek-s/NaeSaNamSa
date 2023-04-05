<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>

<script>
function fn_inform22(num) {
	var informNum = num;
	var dataJson = {"INFORM_NUM":informNum};
	$.ajax({
		type : 'post',
		url : '/ns/inform/value',
		data : JSON.stringify(dataJson),
		contentType : 'application/json; charset-utf-8',
		dataType : 'json',
		success : function(data) {
		},
		error : function() {
			alert('오류 발생');
		}
	});
};

(function getInform() {$.ajax({
    type: 'post',
    url: '/ns/inform',
    dataType: 'json',
    success: function(data) {
        if (data.length == 0) {
            $("#informUl").append("<li>새로운 알림이 없습니다</li>");
        } else {
            for (var i = 0; i < data.length; i++) {
                str = "<li id=inform_'";
                str += i;
                str += "'><a class='dropdown-item informLink' onclick='return fn_inform22(";
                str += data[i].INFORM_NUM;
                str += ");' href='";

                if (data[i].INFORM_TYPE == 1) {
                    str += "/ns/myShop/sellHistory"
                }

                if (data[i].INFORM_TYPE == 2) {
                    str += "/ns/help/noticeDetail?NOTICE_NUM=";
                    str += data[i].INFORM_PRONUM;
                }

                if (data[i].INFORM_TYPE == 3) {
                    str += "/ns/myPage/csDetail?CS_NUM=";
                    str += data[i].INFORM_PRONUM;
                }

                if (data[i].INFORM_TYPE == 4) {
                    str += "/ns/myPage/reportDetail?REPORT_NUM=";
                    str += data[i].INFORM_PRONUM;
                }

                if (data[i].INFORM_TYPE == 5) {
                    str += "/ns/message/list";
                }

                str += "'>";
                str += data[i].INFORM_CONTENT;
                str += "</a></li>";
                $("#informUl").append(str);
            }
        }
    },
    error:function(){
    	
    }
    
});
})();
</script>


<style>
	.informLink{
				white-space:nowrap;
				overflow:hidden;
				text-overflow:ellipsis;
				}
</style>



<header>
  <!-- nav1 시작 -->
  <div class="px-3 py-2">
    <div class="ms-0 me-0">
      <div
        class="row d-flex align-items-center justify-content-center text-center"
      >
      	<div class="col-auto">
         <a
           href="/ns/main"
           class="align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none"
         >
           <img
             src="<%=request.getContextPath() %>/resources/image/mainLogo.png"
             class="img-thumbnail"
             alt="Logo"
             style="height:200px; width:auto; border:none;"
           />
         </a>
     </div>
     <div class="col-auto">
         <ul
           class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small"
         >
           <li>
             <a href='/ns/shop/goodsWriteForm' class="nav-link text-dark fw-bold">
               <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-coin d-block mx-auto mb-2" viewBox="0 0 16 16">
			    <path d="M5.5 9.511c.076.954.83 1.697 2.182 1.785V12h.6v-.709c1.4-.098 2.218-.846 2.218-1.932 0-.987-.626-1.496-1.745-1.76l-.473-.112V5.57c.6.068.982.396 1.074.85h1.052c-.076-.919-.864-1.638-2.126-1.716V4h-.6v.719c-1.195.117-2.01.836-2.01 1.853 0 .9.606 1.472 1.613 1.707l.397.098v2.034c-.615-.093-1.022-.43-1.114-.9H5.5zm2.177-2.166c-.59-.137-.91-.416-.91-.836 0-.47.345-.822.915-.925v1.76h-.005zm.692 1.193c.717.166 1.048.435 1.048.91 0 .542-.412.914-1.135.982V8.518l.087.02z"/>
	    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
	    <path d="M8 13.5a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11zm0 .5A6 6 0 1 0 8 2a6 6 0 0 0 0 12z"/>
	  </svg>
               판매하기
             </a>
           </li>
           <li>
             <a
               href="#"
               class="nav-link dropdown-toggle text-dark fw-bold"
               id="navbarDropdown"
               role="button"
               data-bs-toggle="dropdown"
               aria-expanded="false"
             >
               <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-shop d-block mx-auto mb-2" viewBox="0 0 16 16">
				<path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z"/>
	  </svg>
               내상점
             </a>
             <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
               <li><a class="dropdown-item" href="/ns/myShop">상품관리</a></li>
               <li><a class="dropdown-item" href="/ns/myShop/orderHistory">주문 내역</a></li>
               <li><a class="dropdown-item" href="/ns/myShop/sellHistory">판매 내역</a></li>
               <li><a class="dropdown-item" href="/ns/myShop/goodsLikeList">찜목록</a></li>
               <li><a class="dropdown-item" href="/ns/myShop/recentGoodsList">최근 본 상품</a></li>
             </ul>
           </li>
           <li>
             <a href="/ns/message/list" class="nav-link text-dark fw-bold">
               <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-envelope d-block mx-auto mb-2" viewBox="0 0 16 16">
				<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
	  </svg>
               메시지
             </a>
           </li>
           <li>
             <a href="/ns/myPage" class="nav-link text-dark fw-bold">
               <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-file-person d-block mx-auto mb-2" viewBox="0 0 16 16">
	    <path d="M12 1a1 1 0 0 1 1 1v10.755S12 11 8 11s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
	    <path d="M8 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
	  </svg>
               마이페이지
             </a>
           </li>
         </ul>
       </div>
</div>
    </div>
  </div>
  <!-- nav1 끝 -->

<!-- nav2 시작 -->
<div class="row justify-content-center pb-4" style="border-bottom:1px solid #CDCDCD">
   
   <div class="col-8 align-self-center mb-2">
       <form
         class="col-12 col-lg-auto mb-2 mb-lg-0 me-lg-auto d-flex"
         role="search"
         action="/ns/shop/totalList"
         method="post"
         id="searchForm"
       >
       
       <div class="nav-scroller me-2 align-self-center col-sm-2">
    	<select class="form-select form-select-md" aria-label="카테고리" name="categoryType">
		  <option selected>전체상품</option>
		  <option value="T" <c:out value="${goodsTotalListPaging.categoryType eq 'T' ? 'selected' :''}"/>>상의</option>
		  <option value="B" <c:out value="${goodsTotalListPaging.categoryType eq 'B' ? 'selected' :''}"/>>하의</option>
		  <option value="S" <c:out value="${goodsTotalListPaging.categoryType eq 'S' ? 'selected' :''}"/>>신발</option>
		  <option value="A" <c:out value="${goodsTotalListPaging.categoryType eq 'A' ? 'selected' :''}"/>>악세사리</option>
		</select>
    </div>
       
       <div class="input-group">
         <input
           type="search"
           class="form-control align-self-center"
           placeholder="상품명 입력"
           aria-label="Search"
           name="keyword"
           value="<c:out value="${goodsTotalListPaging.keyword}"/>"
         />
         
         <button type="submit" class="btn btn-outline-secondary">
         	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
			<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
			</svg>
		</button>
		</div>
       </form>
   </div>
    
   <div class="col-auto align-self-center mb-2">
       <div class="text-end">
           <c:choose>
           	<c:when test="${session_MEM_ID == null}">
              <button type="button" class="btn btn-secondary me-4" name="loginSelect">
                로그인
              </button>
             </c:when>
             <c:otherwise>
              <button type="button" class="btn btn-secondary me-4" name="logout">
                로그아웃
              </button>
              
              <div class="btn-group">
		  <button type="button" name="inform" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
		    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell-fill" viewBox="0 0 16 16">
			  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
			</svg>
		  </button>
		  <ul id="informUl" class="dropdown-menu text-center" style="width:300px;">
		  </ul>
		</div>
		
          </c:otherwise>
           </c:choose>
        </div>
    </div>
</div>
   <!-- nav2 끝 -->
  
</header>

<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='loginSelect']").on("click", function(e) { // 로그인 선택
		e.preventDefault();
		fn_loginSelect();
	});
	
	$("button[name='logout']").on("click", function(e) { // 로그아웃
		e.preventDefault();
		fn_logout();
	});
	
	function fn_loginSelect() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl('/ns/loginSelect');
		comSubmit.submit();
	};
	
	function fn_logout() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl('/ns/logout');
		comSubmit.submit();
	};

	
	
	
});


</script>
