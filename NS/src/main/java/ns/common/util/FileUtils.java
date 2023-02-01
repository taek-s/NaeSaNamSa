package ns.common.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	// private static final String filePath =
	// "/Users/kyy/Documents/YongYeon/sts_jspProgramming/nnS/src/file/";

	public String getThumbnailSTD(MultipartHttpServletRequest request) throws Exception {
		String storedFileName = "";
		try {
			MultiValueMap<String, MultipartFile> files = request.getMultiFileMap();
			for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
				List<MultipartFile> fileList = entry.getValue();
				for (MultipartFile file : fileList) {
					if (file.isEmpty())
						continue;
					String originalFileExtension = file.getOriginalFilename()
							.substring(file.getOriginalFilename().lastIndexOf("."));
					storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					return storedFileName;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return storedFileName;
	}

	public List<Map<String, Object>> parseInsertGoodsImg(Map<String, Object> map, MultipartHttpServletRequest request)
			throws Exception {
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		System.out.println(filePath_temp);

		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String ThumbnailSTD = (String) map.get("GOODS_THUMBNAIL");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;

		int num = 0; // 이미지 순서 결정

		int goodsNum = (int) map.get("GOODS_NUM"); // 상품게시물 번호

		File file = new File(filePath_temp);

		if (file.exists() == false) {
			file.mkdirs();
		}

		List<MultipartFile> multipartFileList = new ArrayList<>();
		try {
			MultiValueMap<String, MultipartFile> files = request.getMultiFileMap();
			for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
				List<MultipartFile> fileList = entry.getValue();
				for (MultipartFile multipartFile : fileList) {
					if (multipartFile.isEmpty())
						continue;
					multipartFileList.add(multipartFile);
				}
			}

			if (multipartFileList.size() > 0) {
				for (MultipartFile multipartFile : multipartFileList) {
					num++;
					originalFileName = multipartFile.getOriginalFilename();
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					if (num == 1) {
						storedFileName = ThumbnailSTD;
					} else {
						storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					}
					file = new File(filePath_temp + storedFileName);
					multipartFile.transferTo(file);
					listMap = new HashMap<String, Object>();
					listMap.put("GOODS_IMAGE_PARENT", goodsNum);
					listMap.put("GOODS_IMAGE_ORG", originalFileName);
					listMap.put("GOODS_IMAGE_STD", storedFileName);
					listMap.put("GOODS_IMAGE_ORDER", num);
					list.add(listMap);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Map<String, Object>> parseUpdateGoodsImg(Map<String, Object> map, MultipartHttpServletRequest request,
			List<String> imgNumList) throws Exception {
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		System.out.println(filePath_temp);

		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;

		int num = 0; // 이미지 순서 결정

		int goodsNum = (int) map.get("GOODS_NUM"); // 상품게시물 번호

		File file = new File(filePath_temp);

		if (file.exists() == false) {
			file.mkdirs();
		}

		List<MultipartFile> multipartFileList = new ArrayList<>();
		try {
			MultiValueMap<String, MultipartFile> files = request.getMultiFileMap();
			for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
				List<MultipartFile> fileList = entry.getValue();
				for (MultipartFile multipartFile : fileList) {
					if (multipartFile.isEmpty())
						continue;
					multipartFileList.add(multipartFile);
				}
			}

			if (multipartFileList.size() > 0) {
				for (MultipartFile multipartFile : multipartFileList) {
					num++;
					originalFileName = multipartFile.getOriginalFilename();

					listMap = new HashMap<String, Object>();

					if (!checkFileNum(originalFileName, imgNumList)) {
						originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
						storedFileName = CommonUtils.getRandomString() + originalFileExtension;
						file = new File(filePath_temp + storedFileName);
						multipartFile.transferTo(file);
						listMap.put("isNew", "Y");
						listMap.put("GOODS_IMAGE_STD", storedFileName);
						listMap.put("GOODS_IMAGE_ORG", originalFileName);
					} else {
						String fileNum = originalFileName.substring(originalFileName.indexOf("_NS") + 3);
						System.out.println("################# fileNum : " + fileNum);
						listMap.put("GOODS_IMAGE_NUM", fileNum);
						listMap.put("isNew", "N");
					}

					listMap.put("GOODS_IMAGE_PARENT", goodsNum);
					listMap.put("GOODS_IMAGE_ORDER", num);
					list.add(listMap);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean checkFileNum(String name, List<String> imgNumList) throws Exception {
		for (int i = 0; i < imgNumList.size(); i++) {
			String fileNum = name.substring(name.indexOf("_NS") + 3);
			if (imgNumList.get(i).equals(fileNum)) {
				return true;
			}
		}
		return false;
	}

	public List<Map<String, Object>> parseInsertFileInfo(Map<String, Object> map, HttpServletRequest request)
			throws Exception {
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		System.out.println(filePath_temp);

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		int boardType = (int) map.get("boardType");
		int boardNum = (int) map.get("boardNum");
		File file = new File(filePath_temp);

		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());

			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;
				file = new File(filePath_temp + storedFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("FILES_BOARD_TYPE", boardType);
				listMap.put("FILES_PARENT", boardNum);
				listMap.put("FILES_ORGNAME", originalFileName);
				listMap.put("FILES_STDNAME", storedFileName);
				listMap.put("FILES_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}

	public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request)
			throws Exception {
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\uploadImage\\"; // 로컬 경로에 업로드

		System.out.println(filePath_temp);

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;

		String boardIdx = (String) map.get("IDX");
		String requestName = null;
		String idx = null;

		while (iterator.hasNext()) {
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());

			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;

				multipartFile.transferTo(new File(filePath_temp + storedFileName));
				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("BOARD_IDX", Integer.parseInt(boardIdx));
				listMap.put("FILES_ORG", originalFileName);
				listMap.put("FILES_STD", storedFileName);
				listMap.put("FILES_SIZE", multipartFile.getSize());
				list.add(listMap);
			} else {
				System.out.println(
						"**********!*!*!*!*!*!*!***********!*!*!*!*!*!*!***********!*!*!*!*!*!*!***********!*!*!*!*!*!*!*");
				requestName = multipartFile.getName();
				idx = "IDX_" + requestName.substring(requestName.indexOf("_") + 1);
				if (map.containsKey(idx) == true && map.get(idx) != null) {
					listMap = new HashMap<String, Object>();
					listMap.put("IS_NEW", "N");
					listMap.put("FILE_IDX", Integer.parseInt((String) map.get(idx)));
					list.add(listMap);
				}
			}
		}
		return list;
	}

}
