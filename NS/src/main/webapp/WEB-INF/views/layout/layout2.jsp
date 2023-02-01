<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@ include file="../include/include-head.jspf" %>
<style>
.table th, .table td {
text-align: center;
vertical-align: middle!important;
}
body, h1, h2, h3, h4, h5, h6, p, .h6, a {
font-family: 'Gowun Dodum', sans-serif;
}
</style>


<title>내사남사</title>
</head>
<body>
	
	<%@ include file="../include/include-body.jspf" %>
	
	<!-- body1 --> 
	<!-- <div style="background-color:#fff0f0;"> -->
	<tiles:insertAttribute name="body2"/>
	<!-- </div> -->
	<!-- body1 end -->
	
</body>
</html>