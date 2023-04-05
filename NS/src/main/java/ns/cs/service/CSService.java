package ns.cs.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface CSService {

	List<Map<String, Object>> selectCSList(Map<String, Object> map) throws Exception;

	void insertCS(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception;

	Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception;

	Map<String, Object> selectCSReplyDetail(Map<String, Object> map) throws Exception;

	void deleteCS(Map<String, Object> map) throws Exception;

	void deleteCSReply(Map<String, Object> map) throws Exception;

	void deleteCSFile(Map<String, Object> map) throws Exception;

	int selectAllCsCount(Map<String, Object> map) throws Exception;

	// 파일보기
	List<Map<String, Object>> selectCSFile(Map<String, Object> map) throws Exception;

}
