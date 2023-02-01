package ns.admin.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ns.admin.dao.AdminBoardDAO;
import ns.common.dao.InformDAO;

//AdminBoardServiceImpl

@Service("adminBoardService")
public class AdminBoardServiceImpl implements AdminBoardService {

	@Resource(name = "informDAO")
	private InformDAO informDAO;

	@Resource(name = "adminBoardDAO")
	private AdminBoardDAO adminBoardDAO;

	// 공지사항 삭제
	@Override
	public void deleteNotice(Map<String, Object> map) throws Exception {

		adminBoardDAO.deleteNotice(map);
	}

	// FAQ 삭제
	@Override
	public void deleteFAQ(Map<String, Object> map) throws Exception {

		adminBoardDAO.deleteFAQ(map);
	}

	// 공지사항 작성 + 새로운 공지사항이 작성되면 알림
	@Override
	public void insertNotice(Map<String, Object> map) throws Exception {

		adminBoardDAO.insertNotice(map);

		// selectAllUser() 메서드에 Map객체 넣어서, 회원 전체 리스트 리턴하고
		List<Map<String, Object>> list = informDAO.selectAllUser(map);

		// 회원 수만큼 반복문 실행
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> member = list.get(i); // 회원 리스트에서 인덱스0부터 하나씩 꺼내서 Map에 저장

			// Map에서 MEM_NUM꺼내서 String으로 변환 후, 다시 Int형으로 바꿔서 memNum 변수에 저장
			int memNum = Integer.parseInt((member.get("MEM_NUM").toString()));

			map.put("MEM_NUM", memNum); // map객체에 회원번호인 MEM_NUM 넣어서, 전체 회원에게 알림 가도록 하기
			map.put("INFORM_TYPE", 2);
			map.put("INFORM_PRONUM", map.get("NOTICE_NUM"));
			informDAO.informInsert(map, "새로운 공지사항이 등록되었습니다.");
		}
	}

	// FAQ 작성
	@Override
	public void insertFAQ(Map<String, Object> map) throws Exception {

		adminBoardDAO.insertFAQ(map);
	}

	// 공지사항 상세보기
	@Override
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectNoticeDetail(map);
	}

	// FQA 상세보기
	@Override
	public Map<String, Object> selectFAQDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectFAQDetail(map);
	}

	// 공지사항 수정
	@Override
	public void updateNoticeModify(Map<String, Object> map) throws Exception {

		adminBoardDAO.updateNoticeModify(map);
	}

	// FAQ 수정
	@Override
	public void updateFAQModify(Map<String, Object> map) throws Exception {

		adminBoardDAO.updateFAQModify(map);
	}

	// 고객센터 문의 리스트 조회(한페이지 10개)
	@Override
	public List<Map<String, Object>> selectAdminCSList(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectAdminCSList(map);
	}

	// 고객센터 문의 총 게시글 수
	@Override
	public int selectAdminCSCount(Map<String, Object> map) throws Exception {
		return adminBoardDAO.selectAdminCSCount(map);
	}

	// 고객센터 문의 상세조회
	@Override
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectCSDetail(map);
	}

	// 고객센터 문의 댓글 작성 + 고객센터 문의에 댓글이 작성되면 알림
	@Override
	public void insertCSReply(Map<String, Object> map) throws Exception {

		adminBoardDAO.insertCSReply(map);
		map.put("INFORM_PRONUM", map.get("CS_NUM"));
		map.put("INFORM_TYPE", 3);
		informDAO.informInsert(map, "문의글에 답변이 작성되었습니다.");
	}

	// 고객센터 문의 댓글 상세 조회
	@Override
	public Map<String, Object> selectCSReplyDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectCSReplyDetail(map);
	}

	// 고객센터 문의 댓글 수정
	@Override
	public void updateCSReply(Map<String, Object> map) throws Exception {

		adminBoardDAO.updateCSReply(map);
	}

	// 고객센터 문의 댓글 삭제 (관리자가 댓글만 삭제할 경우)
	@Override
	public void deleteCSReply(Map<String, Object> map) throws Exception {

		adminBoardDAO.deleteCSReply(map);
	}

	// 고객센터 문의 삭제 + 문의 삭제시, 관련 첨부파일 및 문의에 달린 댓글도 함께 삭제
	@Override
	public void deleteCS(Map<String, Object> map) throws Exception {

		adminBoardDAO.deleteCS(map);
		adminBoardDAO.deleteCSFile(map);
		adminBoardDAO.deleteCSReply(map);
	}

	// 신고 리스트 조회(한페이지 10개)
	@Override
	public List<Map<String, Object>> selectAdminReportList(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectAdminReportList(map);
	}

	// 신고글 총 게시물 수
	@Override
	public int selectAdminReportCount(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectAdminReportCount(map);
	}

	// 신고글 상세보기
	@Override
	public Map<String, Object> selectReportDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectReportDetail(map);
	}

	// 신고글 댓글 작성 + 신고에 댓글이 작성되면 알림
	@Override
	public void insertReportReply(Map<String, Object> map) throws Exception {

		adminBoardDAO.insertReportReply(map);
		map.put("INFORM_PRONUM", map.get("REPORT_NUM"));
		map.put("INFORM_TYPE", 4);
		informDAO.informInsert(map, "신고글에 답변이 작성되었습니다.");
	}

	// 신고글 댓글 상세보기
	@Override
	public Map<String, Object> selectReportReplyDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectReportReplyDetail(map);
	}

	// 신고글에 작성한 댓글 수정
	@Override
	public void updateReportReply(Map<String, Object> map) throws Exception {

		adminBoardDAO.updateReportReply(map);
	}

	// 신고글 삭제 + 신고글에 작성했던 댓글도 함께 삭제
	@Override
	public void deleteReport(Map<String, Object> map) throws Exception {

		adminBoardDAO.deleteReport(map);
		adminBoardDAO.deleteReportReply(map);
	}

	// 신고 댓글 삭제
	@Override
	public void deleteReportReply(Map<String, Object> map) throws Exception {
		adminBoardDAO.deleteReportReply(map);
	}

	// 상품 삭제 + 상품 관련 이미지도 함께 삭제
	@Override
	public void deleteGoods(Map<String, Object> map) throws Exception {

		adminBoardDAO.deleteGoods(map);
		adminBoardDAO.deleteGoodsImage(map);
	}

}
