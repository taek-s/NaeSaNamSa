package ns.notice.service;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	// 공지사항 리스트
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	// 공지사항 총 개수
	int selectTotalNoticeListCount(Map<String, Object> map) throws Exception;

	// 공지사항 상세보기
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception;
}
