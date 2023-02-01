package ns.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("noticeDAO")
public class NoticeDAO extends AbstractDAO {

	// 공지사항 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeList : " + map);

		return (List<Map<String, Object>>) selectList("notice.selectNoticeList", map);
	}

	// 공지사항 총 개수
	public int selectTotalNoticeListCount(Map<String, Object> map) throws Exception {

		return (int) selectOne("notice.selectTotalNoticeListCount", map);
	}

	// 공지사항 상세보기
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeDetail : " + map);

		return (Map<String, Object>) selectOne("notice.selectNoticeDetail", map);
	}
}
