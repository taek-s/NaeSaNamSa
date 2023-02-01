package ns.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminBoardService {

	// 공지사항 삭제
	void deleteNotice(Map<String, Object> map) throws Exception;

	// FAQ 삭제
	void deleteFAQ(Map<String, Object> map) throws Exception;

	// 공지사항 작성
	void insertNotice(Map<String, Object> map) throws Exception;

	// FAQ 작성
	void insertFAQ(Map<String, Object> map) throws Exception;

	// 공지사항 상세보기
	Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception;

	// FQA 상세보기
	Map<String, Object> selectFAQDetail(Map<String, Object> map) throws Exception;

	// 공지사항 수정
	void updateNoticeModify(Map<String, Object> map) throws Exception;

	// FAQ 수정
	void updateFAQModify(Map<String, Object> map) throws Exception;

	// 고객센터 문의 리스트 조회(한페이지 10개)
	List<Map<String, Object>> selectAdminCSList(Map<String, Object> map) throws Exception;

	// 고객센터 문의 총 게시글 수
	int selectAdminCSCount(Map<String, Object> map) throws Exception;

	// 고객센터 문의 상세조회
	Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception;

	// 고객센터 문의 댓글 작성
	void insertCSReply(Map<String, Object> map) throws Exception;

	// 고객센터 문의 댓글 상세 조회
	Map<String, Object> selectCSReplyDetail(Map<String, Object> map) throws Exception;

	// 고객센터 문의 댓글 수정
	void updateCSReply(Map<String, Object> map) throws Exception;

	// 고객센터 문의 댓글 삭제
	void deleteCSReply(Map<String, Object> map) throws Exception;

	// 고객센터 문의 삭제 (문의글 작성할 때 첨부했던 첨부파일도 함께 삭제)
	void deleteCS(Map<String, Object> map) throws Exception;

	// 신고 리스트 조회(한페이지 10개)
	List<Map<String, Object>> selectAdminReportList(Map<String, Object> map) throws Exception;

	// 신고글 총 게시글 수
	int selectAdminReportCount(Map<String, Object> map) throws Exception;

	// 신고글 상세보기
	Map<String, Object> selectReportDetail(Map<String, Object> map) throws Exception;

	// 신고글 댓글 작성
	void insertReportReply(Map<String, Object> map) throws Exception;

	// 신고글 댓글 상세보기
	Map<String, Object> selectReportReplyDetail(Map<String, Object> map) throws Exception;

	// 신고글에 작성한 댓글 수정
	void updateReportReply(Map<String, Object> map) throws Exception;

	// 신고글 삭제 (신고글에 작성한 댓글도 함께 삭제해야함)
	void deleteReport(Map<String, Object> map) throws Exception;

	// 신고 댓글 삭제
	void deleteReportReply(Map<String, Object> map) throws Exception;

	// 상품 삭제 (관련 상품 이미지도 함께 삭제해야함)
	void deleteGoods(Map<String, Object> map) throws Exception;

}
