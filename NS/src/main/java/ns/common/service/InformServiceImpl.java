package ns.common.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.common.dao.InformDAO;

@Service("informService")
public class InformServiceImpl implements InformService {

	@Resource(name = "informDAO")
	private InformDAO informDAO;

	// 알림 리스트 조회(알림 리스트는 페이징 X)
	@Override
	public List<Map<String, Object>> informList(Map<String, Object> map) throws Exception {

		return informDAO.informList(map);
	}

	// 알림 확인
	@Override
	public void confirmUpdate(Map<String, Object> map) throws Exception {

		informDAO.confirmUpdate(map);
	}

}
