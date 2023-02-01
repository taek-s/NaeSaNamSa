package ns.faq.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.faq.dao.FAQDAO;

@Service("faqService")
public class FAQServiceImpl implements FAQService {

	@Resource(name = "faqDAO")
	private FAQDAO faqDAO;

	// FAQ 리스트
	@Override
	public List<Map<String, Object>> selectFAQList(Map<String, Object> map) throws Exception {
		return faqDAO.selectFAQList(map);
	}

	// FAQ 총 개수
	@Override
	public int selectTotalFAQListCount(Map<String, Object> map) throws Exception {

		return faqDAO.selectTotalFAQListCount(map);
	}

	// FAQ 상세보기
	@Override
	public Map<String, Object> selectFAQDetail(Map<String, Object> map) throws Exception {

		return faqDAO.selectFAQDetail(map);
	}
}
