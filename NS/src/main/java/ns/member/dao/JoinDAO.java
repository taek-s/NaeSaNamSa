package ns.member.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("joinDAO")
public class JoinDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNickCheck(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("join.selectNickCheck", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEmailCheck(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("join.selectEmailCheck", map);
	}

	public void insertMember(Map<String, Object> map) throws Exception {
		insert("join.insertMember", map);
	}

	public int selectDelCount(Map<String, Object> map) throws Exception {
		return (int) selectOne("join.selectDelCount", map);
	}

	public int selectDelGB(Map<String, Object> map) throws Exception {
		return (int) selectOne("join.selectDelGB", map);
	}

	public void updateDelGB(Map<String, Object> map) throws Exception {
		selectOne("join.updateDelGB", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMemPhone(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("join.selectMemPhone", map);
	}

}
