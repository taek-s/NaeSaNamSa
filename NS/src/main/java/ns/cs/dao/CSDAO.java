package ns.cs.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("CSDAO")
public class CSDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCSList(Map<String, Object> map) throws Exception {
		System.out.println("selectCSList 파라미터 : " + map);
		return (List<Map<String, Object>>) selectList("cs.selectCSList", map);
	}

	public int selectAllCsCount(Map<String, Object> map) throws Exception {
		return (int) selectOne("cs.selectAllCsCount", map);
	}

	public void insertCS(Map<String, Object> map) throws Exception {
		insert("cs.insertCS", map);
	}

	public void insertCSFile(Map<String, Object> map) throws Exception {
		insert("cs.insertCSFile", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("cs.selectCSDetail", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCSReplyDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("cs.selectCSReplyDetail", map);
	}

	public void deleteCS(Map<String, Object> map) throws Exception {
		update("cs.deleteCS", map);
	}

	public void deleteCSReply(Map<String, Object> map) throws Exception {
		update("cs.deleteCSReply", map);
	}

	public void deleteCSFile(Map<String, Object> map) throws Exception {
		update("cs.deleteCSFile", map);
	}

	// 파일보기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCSFile(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectOne("cs.selectCSFile", map);
	}

}