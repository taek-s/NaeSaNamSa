package ns.message.service;

import java.util.List;
import java.util.Map;

public interface MessageService {

	List<Map<String, Object>> messageList(Map<String, Object> map) throws Exception;

	Map<String, Object> getOtherNickname(Map<String, Object> map) throws Exception;

	Map<String, Object> countUnread(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> roomContentList(Map<String, Object> map) throws Exception;

	void messageReadChk(Map<String, Object> map) throws Exception;

	void messageSendInlist(Map<String, Object> map) throws Exception;

	int maxRoom(Map<String, Object> map) throws Exception;

	int existChat(Map<String, Object> map) throws Exception;

	int selectRoom(Map<String, Object> map) throws Exception;

}