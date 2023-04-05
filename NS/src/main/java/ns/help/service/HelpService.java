package ns.help.service;

import java.util.List;
import java.util.Map;

public interface HelpService {

	// 고객센터 메인페이지에 표시될 FAQ 리스트 (최신글 3개만)
	public List<Map<String, Object>> selectMainFAQList(Map<String, Object> map) throws Exception;

	// 고객센터 메인페이지에 표시될 공지사항 (최신글 1개만)
	public List<Map<String, Object>> selectMainNotice(Map<String, Object> map) throws Exception;

}
