package ns.main.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.main.dao.MainDAO;

@Service("mainService")
public class MainServiceImpl implements MainService {

	@Resource(name = "mainDAO")
	private MainDAO mainDAO;

	@Override
	public List<Map<String, Object>> selectNewGoodsList(Map<String, Object> map) throws Exception {
		return mainDAO.selectNewGoodsList(map);
	}

}
