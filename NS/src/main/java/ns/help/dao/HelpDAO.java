package ns.help.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("helpDAO")
public class HelpDAO extends AbstractDAO {

	// 고객센터 메인페이지에 표시될 FAQ 리스트 (최신글 3개만)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMainFAQList(Map<String, Object> map) throws Exception {

		return (List<Map<String, Object>>) selectList("help.selectMainFAQList", map);
	}

	// 고객센터 메인페이지에 표시될 공지사항 (최신글 1개만)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMainNotice(Map<String, Object> map) throws Exception {

		return (List<Map<String, Object>>) selectList("help.selectMainNotice", map);
	}

}
