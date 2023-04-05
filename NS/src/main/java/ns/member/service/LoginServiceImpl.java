package ns.member.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.member.dao.LoginDAO;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "loginDAO")
	private LoginDAO loginDAO;

	@Override
	public Map<String, Object> selectId(Map<String, Object> map) throws Exception {

		return loginDAO.selectId(map);
	}

	@Override
	public Map<String, Object> findIdWithBirth(Map<String, Object> map) throws Exception {

		return loginDAO.findIdWithBirth(map);
	}

	@Override
	public Map<String, Object> findPwWithEmail(Map<String, Object> map) throws Exception {

		return loginDAO.findPwWithEmail(map);
	}

}
