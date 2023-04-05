package ns.report.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ns.common.dao.AbstractDAO;

@Repository("reportDAO")
public class ReportDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReportList(Map<String, Object> map) throws Exception {
		System.out.println("selectReportList 파라미터 : " + map);
		return (List<Map<String, Object>>) selectList("report.selectReportList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("report.selectReportDetail", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectReportReply(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("report.selectReportReplyDetail", map);
	}

	public void deleteReport(Map<String, Object> map) throws Exception {
		System.out.println("deleteReport 파라미터 : " + map);
		update("report.deleteReport", map);
	}

	public void deleteReportReply(Map<String, Object> map) throws Exception {
		update("report.deleteReportReply", map);
	}

	public void reportWrite(Map<String, Object> map) {
		System.out.println("reportWrite 파라미터 : " + map);
		insert("report.insertReport", map);
	}

	public int selectReportCount(Map<String, Object> map) throws Exception {
		System.out.println("reportCount 파라미터 : " + map);
		return (int) selectOne("report.selectReportCount", map);
	}

}
