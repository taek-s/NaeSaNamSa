<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <div class="container text-start pt-5 pb-5">
      <div class="row text-center mb-3">
        <h2 class="fs-1 fw-semibold">
          회원 가입 완료
        </h2>
      </div>

      <div class="card text-center">
        <div class="card-header" style="border-bottom:none;">
            <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person-check-fill" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M15.854 5.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L12.5 7.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
			  <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			</svg>
        </div>
        <div class="card-body">
          <h5 class="card-title fs-4">회원가입이 완료 되었습니다.</h5>
          <p class="card-text fs-4">${MEM_NAME}님의 회원가입을 축하합니다!</p>

          <div class="row mb-5"></div>

          <a href="/ns/loginForm" class="btn btn-primary me-3">로그인</a>
          <a href="/ns/main" class="btn btn-primary">메인으로</a>

          <div class="row mb-5"></div>
        </div>
      </div>
    </div>
  </body>
</html>
