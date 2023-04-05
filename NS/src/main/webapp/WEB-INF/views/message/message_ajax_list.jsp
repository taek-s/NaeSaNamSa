<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.col-13 {
				white-space:nowrap;
				max-width:100%;
				overflow:hidden;
				text-overflow:ellipsis;
				font-size:12px;
				padding:0 0 0 0px;
				}
	 .h522{
				white-space:nowrap;
				max-width:60%;
				overflow:hidden;
				text-overflow:ellipsis;
				font-size:17px;
				} 
</style> 

<c:forEach var="list" items="${list}" varStatus="status">
   <div class="chat_list_box${list.CHAT_ROOM} chat_list_box">
      <div type="button" class="chat_list" room="${list.CHAT_ROOM}" chatRecvNum="${list.CHAT_RECV_NUM}" chatSendNum="${list.CHAT_SEND_NUM}"  mem_del_gb="${nicknameList[status.index].MEM_DEL_GB}" mem_status="${nicknameList[status.index].MEM_STATUS}">
         <!-- active-chat -->
         <div class="chat_people">
            <div class="chat_img" >
               <a href="#">
                  <img class="img" src="<%=request.getContextPath() %>/image/기본 프사.png" alt="sunil" >
               </a>
            </div>
            <div class="chat_ib">
                <div class="d-flex justify-content-between">
               		<div class="h522">${nicknameList[status.index].MEM_NICKNAME}</div><div class="chat_date" style="font-size:0.5em;">${list.CHAT_SEND_TIME}</div>
            	</div>
           	<div class="d-flex justify-content-between">
            	<div class="col-13">${list.CHAT_CONTENT}</div>
                	<div class="col-2 unread${list.CHAT_ROOM}">
                    	<c:if test="${unreadList[status.index].UNREAD > 0}">
                       <div class="badge bg-danger" style="font-size:0.5em;">${unreadList[status.index].UNREAD}</div>
                   </c:if>
                	</div>
                    
             </div>
            
               <div class="row">
               </div>
            </div>
         </div>
      </div>
   </div>
</c:forEach>