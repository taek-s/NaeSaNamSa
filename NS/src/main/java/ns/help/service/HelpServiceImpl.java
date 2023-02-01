package ns.help.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.help.dao.HelpDAO;

@Service("helpService")
public class HelpServiceImpl implements HelpService {

	@Resource(name = "helpDAO")
	private HelpDAO helpDAO;

	// 고객센터 메인페이지에 표시될 FAQ 리스트 (최신글 3개만)
	@Override
	public List<Map<String, Object>> selectMainFAQList(Map<String, Object> map) throws Exception {

		return helpDAO.selectMainFAQList(map);
	}

	// 고객센터 메인페이지에 표시될 공지사항 (최신글 1개만)
	@Override
	public List<Map<String, Object>> selectMainNotice(Map<String, Object> map) throws Exception {

		return helpDAO.selectMainNotice(map);
	}

}
