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
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>

<title>내사남사</title>
</head>
<body>
	<!-- header -->
	<tiles:insertAttribute name="header"/>
	<!-- header end -->
	
	<%@ include file="../include/include-body.jspf" %>
	
	<!-- body1 --> 
	<!-- <div style="background-color:#fff0f0;"> -->
	<tiles:insertAttribute name="body1"/>
	<!-- </div> -->
	<!-- body1 end -->
	
	<!-- footer --> 
	<tiles:insertAttribute name="footer"/>
	<!-- footer end -->
</body>
</html>