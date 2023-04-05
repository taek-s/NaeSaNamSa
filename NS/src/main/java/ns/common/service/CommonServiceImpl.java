package ns.common.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.common.dao.CommonDAO;

@Service("commonService")
public class CommonServiceImpl implements CommonService {

	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return commonDAO.selectFileInfo(map);
	}

}
