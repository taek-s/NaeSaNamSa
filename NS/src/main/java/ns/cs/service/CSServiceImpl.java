package ns.cs.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ns.common.util.FileUtils;
import ns.cs.dao.CSDAO;

@Service("csService")
public class CSServiceImpl implements CSService {

	Logger log = Logger.getLogger(getClass());

	@Resource(name = "CSDAO")
	private CSDAO csDAO;

	@Resource(name = "fileUtils")
	private FileUtils fileUtils;

	@Override
	public List<Map<String, Object>> selectCSList(Map<String, Object> map) throws Exception {
		return csDAO.selectCSList(map);
	}

	@Override
	public int selectAllCsCount(Map<String, Object> map) throws Exception {
		return csDAO.selectAllCsCount(map);
	}

	@Override
	public void insertCS(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception {
		csDAO.insertCS(map);
		int csNum = Integer.parseInt(String.valueOf(map.get("CS_NUM")));
		map.put("boardNum", csNum);
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> fileMap = list.get(i);
			csDAO.insertCSFile(fileMap);
		}
	}

	@Override
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception {
		return csDAO.selectCSDetail(map);
	}

	@Override
	public Map<String, Object> selectCSReplyDetail(Map<String, Object> map) throws Exception {
		return csDAO.selectCSReplyDetail(map);
	}

	@Override
	public void deleteCS(Map<String, Object> map) throws Exception {
		csDAO.deleteCS(map);
	}

	@Override
	public void deleteCSReply(Map<String, Object> map) throws Exception {
		csDAO.deleteCSReply(map);
	}

	@Override
	public void deleteCSFile(Map<String, Object> map) throws Exception {
		csDAO.deleteCSFile(map);
	}

	// 파일보기
	@Override
	public List<Map<String, Object>> selectCSFile(Map<String, Object> map) throws Exception {
		return csDAO.selectCSFile(map);
	}
}
