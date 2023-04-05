package ns.report.service;

import java.util.List;
import java.util.Map;

public interface ReportService {

	List<Map<String, Object>> selectReportList(Map<String, Object> map) throws Exception;

	Map<String, Object> selectReportDetail(Map<String, Object> map) throws Exception;

	Map<String, Object> selectReportReply(Map<String, Object> map) throws Exception;

	void deleteReport(Map<String, Object> map) throws Exception;

	void deleteReportReply(Map<String, Object> map) throws Exception;

	void reportWrite(Map<String, Object> map) throws Exception;

	int selectReportCount(Map<String, Object> map) throws Exception;
}