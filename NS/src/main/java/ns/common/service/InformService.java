package ns.common.service;

import java.util.List;
import java.util.Map;

public interface InformService {

	// 알림 리스트 조회(알림 리스트는 페이징 X)
	public List<Map<String, Object>> informList(Map<String, Object> map) throws Exception;

	// 알림 확인
	public void confirmUpdate(Map<String, Object> map) throws Exception;

}
