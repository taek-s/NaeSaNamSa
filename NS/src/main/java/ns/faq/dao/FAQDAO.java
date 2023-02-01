package ns.faq.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("faqDAO")
public class FAQDAO extends AbstractDAO {

	// FAQ 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFAQList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("faq.selectFAQList", map);
	}

	// FAQ 총 개수
	public int selectTotalFAQListCount(Map<String, Object> map) throws Exception {

		return (int) selectOne("faq.selectTotalFAQListCount", map);
	}

	// FAQ 상세보기
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFAQDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("faq.selectFAQDetail", map);
	}

}
