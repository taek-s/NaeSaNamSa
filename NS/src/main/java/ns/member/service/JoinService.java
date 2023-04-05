package ns.member.service;

import java.util.Map;

public interface JoinService {

	// 회원가입 처리
	void insertMember(Map<String, Object> map) throws Exception;

	// 이메일 중복확인
	Map<String, Object> selectEmailCheck(Map<String, Object> map) throws Exception;

	// 닉네임 중복확인
	Map<String, Object> selectNickCheck(Map<String, Object> map) throws Exception;

	// 회원탈퇴 후 7일 지났는지 여부 확인
	int selectDelCount(Map<String, Object> map) throws Exception;

	// 회원탈퇴 이력 확인
	int selectDelGB(Map<String, Object> map) throws Exception;

	// 탈퇴한 회원 재가입 시 DEL_GB 변경
	void updateDelGB(Map<String, Object> map) throws Exception;

	// 카카오 전용 회원 전화번호 가져오기
	Map<String, Object> selectMemPhone(Map<String, Object> map) throws Exception;

}
