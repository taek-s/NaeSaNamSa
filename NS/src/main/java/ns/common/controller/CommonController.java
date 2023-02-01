package ns.common.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ns.common.common.CommandMap;
import ns.common.service.CommonService;

@Controller
public class CommonController {

	@Resource(name = "commonService")
	private CommonService commonService;

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value = "/common/fileDownload")
	public void fileDownload(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		Map<String, Object> map = commonService.selectFileInfo(commandMap.getMap());
		String storedFileName = (String) map.get("FILES_STDNAME");
		String originalFileName = (String) map.get("FILES_ORGNAME");

//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/"); //서버에 업로드
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		byte fileByte[] = FileUtils.readFileToByteArray(new File(filePath_temp + storedFileName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);

		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
}
