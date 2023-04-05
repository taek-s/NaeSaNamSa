<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 <style>
.textLengthWrap {
				color: #747474;
			  	font-size: 12px;
			  	float:right;
			  	right:100;
			  	position:relative;
				}	
</style>
<c:forEach var="list" items="${list}">
      <c:if test="${map.MEM_NUM ne list.CHAT_SEND_NUM}">
      <!-- 받은 메세지 -->
      <div class="incoming_msg">
         <div class="incoming_msg_img">
         	<c:choose>
         		<c:when test="${map.MEM_STATUS=='Y' || map.MEM_DEL_GB=='Y'}">
                	<img class="img" src="<%=request.getContextPath() %>/image/기본 프사.png" alt="sunil">
		        </c:when>
		      	<c:otherwise>
		      		<a href="/ns/seller/info?MEM_NUM=${list.CHAT_SEND_NUM}">
		      			<img class="img" src="<%=request.getContextPath() %>/image/기본 프사.png" alt="sunil">
		      		</a>
		      	</c:otherwise>
		     </c:choose> 		
         </div>
         <div class="received_msg">
            <div class="received_withd_msg" style="word-break:break-all;">
               <p>${list.CHAT_CONTENT}</p>
               <span class="time_date"> ${list.CHAT_SEND_TIME}</span>
            </div>
         </div>
      </div>
      </c:if>
      

      <!-- 보낸 메세지 -->   
      <c:if test="${map.MEM_NUM eq list.CHAT_SEND_NUM}">
      <div class="outgoing_msg" style="word-break:break-all;">
         <div class="sent_msg">
            <p>${list.CHAT_CONTENT}</p>
            <span class="time_date"> ${list.CHAT_SEND_TIME}</span>
         </div>
      </div>
      </c:if>

</c:forEach>