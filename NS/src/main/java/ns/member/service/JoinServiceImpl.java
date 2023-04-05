package ns.member.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.member.dao.JoinDAO;

@Service("joinService")
public class JoinServiceImpl implements JoinService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "joinDAO")
	private JoinDAO joinDAO;

	@Override
	// 회원가입 성공
	public void insertMember(Map<String, Object> map) throws Exception {
		// MEM_GEN
		// 주민등록번호 뒷자리 꺼내서 문자열로 변환
		String gen = (String) map.get("MEM_GEN");

		if (gen.equals("1") || gen.equals("3")) {
			map.put("MEM_GEN", "남"); // 1, 3이면 "남"으로 맵의 값을 바꿈

		} else if (gen.equals("2") || gen.equals("4")) {
			map.put("MEM_GEN", "여"); // 2, 4면 "여"로 맵의 값을 바꿈
		}

		// MEM_PHONE
		String phone = "";

		List<Object> list = new ArrayList<Object>();

		list.add(map.get("MEM_PHONE1"));
		list.add(map.get("MEM_PHONE2"));
		list.add(map.get("MEM_PHONE3"));

		for (int i = 0; i < list.size(); i++) {
			phone += (String) list.get(i);
			// 번호를 합쳐 하나의 문자열로 만듦
		}

		map.put("MEM_PHONE", phone); // 하나의 문자열로 합쳐진 번호를 맵에 저장

		joinDAO.insertMember(map);
	}

	@Override
	// 이메일 중복체크
	public Map<String, Object> selectEmailCheck(Map<String, Object> map) throws Exception {

		return joinDAO.selectEmailCheck(map);
	}

	// 닉네임 중복체크
	@Override
	public Map<String, Object> selectNickCheck(Map<String, Object> map) throws Exception {

		return joinDAO.selectNickCheck(map);
		// 입력받은 닉네임에 해당하는 닉네임을 DB에서 가져와 map에 저장

	}

	// 회원탈퇴 후 7일 지났는지 여부 확인
	@Override
	public int selectDelCount(Map<String, Object> map) throws Exception {

		return joinDAO.selectDelCount(map);
	}

	@Override
	public int selectDelGB(Map<String, Object> map) throws Exception {

		return joinDAO.selectDelGB(map);
	}

	@Override
	public void updateDelGB(Map<String, Object> map) throws Exception {

		joinDAO.updateDelGB(map);
	}

	@Override
	public Map<String, Object> selectMemPhone(Map<String, Object> map) throws Exception {

		return joinDAO.selectMemPhone(map);
	}

}
