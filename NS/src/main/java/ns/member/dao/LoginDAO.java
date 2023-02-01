package ns.member.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("loginDAO")
public class LoginDAO extends AbstractDAO {

	// 로그인 체크
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectId(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("login.selectId", map);
		// 이메일에 해당하는 회원정보를 가져옴

	}

	// 아이디찾기
	@SuppressWarnings("unchecked")
	public Map<String, Object> findIdWithBirth(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("login.findIdWithBirth", map);
		// 이름과 생년월일에 해당하는 아이디 가져오기
	}

	// 비밀번호 찾기
	public Map<String, Object> findPwWithEmail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("login.findPwWithEmail", map);
		// 이름과 이메일에 해당하는 비밀번호 가져오기
	}

}
