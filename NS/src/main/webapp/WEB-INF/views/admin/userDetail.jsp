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

      <!--  타이틀 -->
      <div class="row">
        <div class="col">
          <h2
            class="fs-1 fw-semibold"
          >
            회원 관리 상세보기
          </h2>
        </div>
      </div>
      <!-- 타이틀 끝-->

      <hr style="border: solid 1px black" />

      <!-- 회원정보 테이블 -->
	  <!-- MEMBER 테이블 정보 모두 가져오기 -->
      <table class="table">
        <thead>
          <tr>
            <th scope="col" class="col-7">회원 번호</th>
            <th scope="col" class="text-left">${userDetail.MEM_NUM }</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">이메일</th>
            <td class="text-left">${userDetail.MEM_EMAIL }</td>
          </tr>

          <tr>
            <th scope="row">비밀번호</th>
            <td class="text-left">${userDetail.MEM_PW }</td>
          </tr>

          <tr>
            <th scope="row">이름</th>
            <td class="text-left">${userDetail.MEM_NAME }</td>
          </tr>

          <tr>
            <th scope="row">닉네임</th>
            <td class="text-left">${userDetail.MEM_NICKNAME }</td>
          </tr>

          <tr>
            <th scope="row">생년월일</th>
            <td class="text-left">${userDetail.MEM_BIRTH}</td>
          </tr>

          <tr>
            <th scope="row">성별</th>
            <td class="text-left">${userDetail.MEM_GEN }</td>
          </tr>

          <tr>
            <th scope="row">휴대전화</th>
            <td class="text-left">${userDetail.MEM_PHONE }</td>
          </tr>

          <tr>
            <th scope="row">우편번호</th>
            <td class="text-left">${userDetail.MEM_ZIP }</td>
          </tr>

          <tr>
            <th scope="row">집주소</th>
            <td class="text-left">${userDetail.MEM_ADD1 }</td>
          </tr>

          <tr>
            <th scope="row">상세주소</th>
            <td class="text-left">${userDetail.MEM_ADD2 }</td>
          </tr>

          <tr>
            <th scope="row">가입일</th>
            <td class="text-left">${userDetail.MEM_JOINDATE }</td>
          </tr>

          <tr>
            <th scope="row">탈퇴여부</th>
            <td class="text-left">${userDetail.MEM_DEL_GB }</td>
          </tr>
          
          <tr>
            <th scope="row">정지여부</th>
            <td class="text-left">${userDetail.MEM_STATUS }</td>
          </tr>
        </tbody>
      </table>
      <!-- 회원정보 테이블 끝-->

      <hr style="border: solid 1px black" />

      <div class="d-grid gap-2 d-md-flex justify-content-md-center">
      <c:if test="${userDetail.MEM_DEL_GB == 'N'}">
        <button class="btn btn-primary me-md-2" type="button" name="userDelete">회원탈퇴</button>
      </c:if>
      <c:if test="${userDetail.MEM_DEL_GB=='N'&&userDetail.MEM_STATUS=='N'}">
        <button class="btn btn-primary me-md-2" type="button" name="userStop">회원정지</button>
      </c:if>
      <c:if test="${userDetail.MEM_DEL_GB=='N'&&userDetail.MEM_STATUS=='Y'}">
        <button class="btn btn-primary me-md-2" type="button" name="userRestoration">회원복구</button>
      </c:if>
        <button class="btn btn-primary" type="button" name="userList">뒤로가기</button>
      </div>
    </div>
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("button[name='userDelete']").on("click", function(e) {  // 관리자 회원 탈퇴시키기
		e.preventDefault();
		fn_userDelete();
	});
	
	$("button[name='userStop']").on("click", function(e) {  // 관리자 회원 정지시키기
		e.preventDefault();
		fn_userStop();
	});
	
	$("button[name='userRestoration']").on("click", function(e) {  // 관리자 회원 정지시키기
		e.preventDefault();
		fn_userRestoration();
	});
	
	$("button[name='userList']").on("click", function(e) {  // 관리자 회원 관리 리스트 돌아가기
		e.preventDefault();
		fn_userList();
	});
	
	function fn_userDelete() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/userDelete");
		comSubmit.addParam("MEM_NUM", ${userDetail.MEM_NUM}); 
		comSubmit.submit();
	};
	
	function fn_userStop() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/userStop");
		comSubmit.addParam("MEM_NUM", ${userDetail.MEM_NUM}); 
		comSubmit.submit();
	};
	
	function fn_userRestoration() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/userRestoration");
		comSubmit.addParam("MEM_NUM", ${userDetail.MEM_NUM});
		comSubmit.submit();
	};
	
	function fn_userList() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/ns/admin/userList");
		comSubmit.submit();
	};
	
});
</script>
    
  </body>
</html>
