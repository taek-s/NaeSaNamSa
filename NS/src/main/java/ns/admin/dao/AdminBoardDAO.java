package ns.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("adminBoardDAO")
public class AdminBoardDAO extends AbstractDAO {

	// 공지사항 삭제 - update()
	public void deleteNotice(Map<String, Object> map) throws Exception {
		System.out.println("deleteNotice 파라미터 : " + map);

		update("adminBoard.deleteNotice", map);
	}

	// FAQ 삭제 - update()
	public void deleteFAQ(Map<String, Object> map) throws Exception {
		System.out.println("deleteFAQ 파라미터 : " + map);

		update("adminBoard.deleteFAQ", map);
	}

	// 공지사항 작성 - insert()
	public void insertNotice(Map<String, Object> map) throws Exception {
		System.out.println("insertNotice 파라미터 : " + map);

		insert("adminBoard.insertNotice", map);
	}

	// FAQ 작성 - insert()
	public void insertFAQ(Map<String, Object> map) throws Exception {
		System.out.println("insertFAQ 파라미터 : " + map);

		insert("adminBoard.insertFAQ", map);
	}

	// 공지사항 상세보기 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectNoticeDetail", map);
	}

	// FQA 상세보기 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFAQDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectFAQDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectFAQDetail", map);
	}

	// 공지사항 수정 - update()
	public void updateNoticeModify(Map<String, Object> map) throws Exception {
		System.out.println("updateNoticeModify 파라미터 : " + map);

		update("adminBoard.updateNoticeModify", map);
	}

	// FAQ 수정 - update()
	public void updateFAQModify(Map<String, Object> map) throws Exception {
		System.out.println("updateFAQModify 파라미터 : " + map);

		update("adminBoard.updateFAQModify", map);
	}

	// 고객센터 문의 리스트 조회(한페이지 10개) - selectPagingList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAdminCSList(Map<String, Object> map) throws Exception {
		System.out.println("selectAdminCSList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("adminBoard.selectAdminCSList", map);
	}

	// 고객센터 문의 총 게시글 수
	public int selectAdminCSCount(Map<String, Object> map) throws Exception {
		System.out.println("selectAdminCSCount 파라미터 : " + map);

		return (int) selectOne("adminBoard.selectAdminCSCount", map);
	}

	// 고객센터 문의 상세조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectCSDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectCSDetail", map);
	}

	// 고객센터 문의 댓글 작성 - insert()
	public void insertCSReply(Map<String, Object> map) throws Exception {
		System.out.println("insertCSReply 파라미터 : " + map);

		insert("adminBoard.insertCSReply", map);
	}

	// 고객센터 문의 댓글 상세 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCSReplyDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectCSReplyDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectCSReplyDetail", map);
	}

	// 고객센터 문의 댓글 수정 - update()
	public void updateCSReply(Map<String, Object> map) throws Exception {
		System.out.println("updateCSReply 파라미터 : " + map);

		update("adminBoard.updateCSReply", map);
	}

	// 고객센터 문의 댓글 삭제 - update()
	public void deleteCSReply(Map<String, Object> map) throws Exception {
		System.out.println("deleteCSReply 파라미터 : " + map);

		update("adminBoard.deleteCSReply", map);
	}

	// 고객센터 문의 삭제 - update()
	public void deleteCS(Map<String, Object> map) throws Exception {
		System.out.println("deleteCS 파라미터 : " + map);

		update("adminBoard.deleteCS", map);
	}

	// 고객센터 문의 삭제시, 첨부파일 삭제 - update()
	public void deleteCSFile(Map<String, Object> map) throws Exception {
		System.out.println("deleteCSFile 파라미터 : " + map);

		update("adminBoard.deleteCSFile", map);
	}

	// 신고 리스트 조회(한페이지 10개) - selectPagingList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAdminReportList(Map<String, Object> map) throws Exception {
		System.out.println("selectAdminReportList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("adminBoard.selectAdminReportList", map);
	}

	// 신고글 총 게시글 수
	public int selectAdminReportCount(Map<String, Object> map) throws Exception {
		System.out.println("selectAdminReportCount 파라미터 : " + map);

		return (int) selectOne("adminBoard.selectAdminReportCount", map);
	}

	// 신고글 상세보기 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectReportDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectReportDetail", map);
	}

	// 신고글 댓글 작성 - insert()
	public void insertReportReply(Map<String, Object> map) throws Exception {
		System.out.println("insertReportReply 파라미터 : " + map);

		insert("adminBoard.insertReportReply", map);
	}

	// 신고글 댓글 상세보기 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportReplyDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectReportReplyDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectReportReplyDetail", map);
	}

	// 신고글에 작성한 댓글 수정 - update()
	public void updateReportReply(Map<String, Object> map) throws Exception {
		System.out.println("updateReportReply 파라미터 : " + map);

		update("adminBoard.updateReportReply", map);
	}

	// 신고글 삭제 - update()
	public void deleteReport(Map<String, Object> map) throws Exception {
		System.out.println("deleteReport 파라미터 : " + map);

		update("adminBoard.deleteReport", map);
	}

	// 신고글에 작성했던 댓글 삭제 - update()
	public void deleteReportReply(Map<String, Object> map) throws Exception {
		System.out.println("deleteReportReply 파라미터 : " + map);

		update("adminBoard.deleteReportReply", map);
	}

	// 상품 삭제 - update()
	public void deleteGoods(Map<String, Object> map) throws Exception {
		System.out.println("deleteGoods 파라미터 : " + map);

		update("adminBoard.deleteGoods", map);
	}

	// 상품 삭제시, 상품 이미지 삭제 - update()
	public void deleteGoodsImage(Map<String, Object> map) throws Exception {
		System.out.println("deleteGoodsImage 파라미터 : " + map);

		update("adminBoard.deleteGoodsImage", map);
	}

}
