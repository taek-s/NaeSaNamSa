package ns.notice.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.notice.dao.NoticeDAO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	Logger log = Logger.getLogger(getClass());

	@Resource(name = "noticeDAO")
	private NoticeDAO noticeDAO;

	// 공지사항 리스트
	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {

		return noticeDAO.selectNoticeList(map);
	}

	// 공지사항 총 개수
	@Override
	public int selectTotalNoticeListCount(Map<String, Object> map) throws Exception {

		return noticeDAO.selectTotalNoticeListCount(map);
	}

	// 공지사항 상세보기
	@Override
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {

		return noticeDAO.selectNoticeDetail(map);
	}
}