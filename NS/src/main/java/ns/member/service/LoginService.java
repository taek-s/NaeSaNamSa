package ns.member.service;

import java.util.Map;

public interface LoginService {

	// 로그인 체크
	// 입력한 아이디에 해당하는 회원정보를 가져옴
	public Map<String, Object> selectId(Map<String, Object> map) throws Exception;

	// 아이디찾기
	// 이름, 생년월일에 해당하는 아이디 가져옴
	public Map<String, Object> findIdWithBirth(Map<String, Object> map) throws Exception;

	// 비밀번호 찾기
	// 이름, 이메일에 해당하는 비밀번호 가져옴
	public Map<String, Object> findPwWithEmail(Map<String, Object> map) throws Exception;
}
