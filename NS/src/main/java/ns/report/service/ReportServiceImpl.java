package ns.report.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import ns.report.dao.ReportDAO;

@Service("reportService")
public class ReportServiceImpl implements ReportService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "reportDAO")
	private ReportDAO reportDAO;

	@Override
	public List<Map<String, Object>> selectReportList(Map<String, Object> map) throws Exception {
		return reportDAO.selectReportList(map);
	}

	@Override
	public Map<String, Object> selectReportDetail(Map<String, Object> map) throws Exception {
		return reportDAO.selectReportDetail(map);
	}

	@Override
	public Map<String, Object> selectReportReply(Map<String, Object> map) throws Exception {
		return reportDAO.selectReportReply(map);
	}

	@Override
	public void deleteReport(Map<String, Object> map) throws Exception {
		reportDAO.deleteReport(map);
	}

	@Override
	public void deleteReportReply(Map<String, Object> map) throws Exception {
		reportDAO.deleteReportReply(map);
	}

	@Override
	public void reportWrite(Map<String, Object> map) throws Exception {
		reportDAO.reportWrite(map);

	}

	@Override
	public int selectReportCount(Map<String, Object> map) throws Exception {
		return reportDAO.selectReportCount(map);
	}

}