package ns.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("mainDAO")
public class MainDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNewGoodsList(Map<String, Object> map) throws Exception {
		return selectList("main.selectNewGoodsList", map);
	}
}
