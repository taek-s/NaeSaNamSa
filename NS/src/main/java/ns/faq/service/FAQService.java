package ns.faq.service;

import java.util.List;
import java.util.Map;

public interface FAQService {
	// FAQ 리스트
	List<Map<String, Object>> selectFAQList(Map<String, Object> map) throws Exception;

	// FAQ 총 개수
	int selectTotalFAQListCount(Map<String, Object> map) throws Exception;

	// FAQ 상세보기
	Map<String, Object> selectFAQDetail(Map<String, Object> map) throws Exception;

}
