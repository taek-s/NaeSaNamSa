package ns.shop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ns.common.util.FileUtils;
import ns.shop.dao.ShopDAO;

@Service("shopService")
public class ShopServiceImpl implements ShopService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "shopDAO")
	private ShopDAO shopDAO;

	@Resource(name = "fileUtils")
	private FileUtils fileUtils;

	@Override
	public List<Map<String, Object>> selectAllGoodsList(Map<String, Object> map) throws Exception {
		return shopDAO.selectAllGoodsList(map);
	}

	@Override
	public int selectAllGoodsCount(Map<String, Object> map) throws Exception {
		return shopDAO.selectAllGoodsCount(map);
	}

	@Override
	public int insertGoods(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		Map<String, Object> member = (Map<String, Object>) session.getAttribute("session_MEM_INFO");

		int memNum = Integer.parseInt(String.valueOf(member.get("MEM_NUM")));

		map.put("GOODS_SELLER", memNum);
		String ThumbnailSTD = fileUtils.getThumbnailSTD(request);
		map.put("GOODS_THUMBNAIL", ThumbnailSTD); // 썸네일 이름 결정

		String a = (String) map.get("GOODS_PRICE");
		String[] aArr = a.split(",");
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < aArr.length; i++) {
			sb.append(aArr[i]);
		}
		map.put("GOODS_PRICE", sb.toString());

		shopDAO.insertGoods(map);
		List<Map<String, Object>> list = fileUtils.parseInsertGoodsImg(map, request);
		for (int i = 0; i < list.size(); i++) {
			shopDAO.insertGoodsImage(list.get(i));
		}
		int goodsNum = (int) map.get("GOODS_NUM");
		return goodsNum;
	}

	@Override
	public Map<String, Object> selectGoodsDetail(Map<String, Object> map) throws Exception {
		return shopDAO.selectGoodsDetail(map);
	}

	@Override
	public List<Map<String, Object>> selectGoodsImage(Map<String, Object> map) throws Exception {
		return shopDAO.selectGoodsImage(map);
	}

	@Override
	public Map<String, Object> selectGoodsLikeCount(Map<String, Object> map) throws Exception {
		return shopDAO.selectGoodsLikeCount(map);
	}

	@Override
	public void updateHitCnt(Map<String, Object> map) throws Exception {
		shopDAO.updateHitCnt(map);
	}

	@Override
	public void updateGoodsModify(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception {

		List<Map<String, Object>> imgList = shopDAO.selectGoodsImage(map);
		shopDAO.deleteGoodsImage(map);
		List<String> imgFileNum = new ArrayList<>();
		for (Map<String, Object> imgMap : imgList) {
			String imgNum = String.valueOf(imgMap.get("GOODS_IMAGE_NUM"));
			imgFileNum.add(imgNum);
		}

		int goodsNum = Integer.parseInt(String.valueOf(map.get("GOODS_NUM")));
		map.put("GOODS_NUM", goodsNum);

		List<Map<String, Object>> list = fileUtils.parseUpdateGoodsImg(map, request, imgFileNum);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).get("isNew").equals("Y")) {
				shopDAO.insertGoodsImage(list.get(i));
				if (i == 0) {
					map.put("GOODS_THUMBNAIL", list.get(i).get("GOODS_IMAGE_STD"));
				}
			} else if (list.get(i).get("isNew").equals("N")) {
				shopDAO.updateGoodsImageModify(list.get(i));
				if (i == 0) {
					for (int j = 0; j < imgFileNum.size(); j++) {
						if (imgFileNum.get(j).equals((String) list.get(i).get("GOODS_IMAGE_NUM"))) {
							map.put("GOODS_THUMBNAIL", imgList.get(j).get("GOODS_IMAGE_STD"));
						}
					}

				}
			}

		}
		String a = (String) map.get("GOODS_PRICE");
		String[] aArr = a.split(",");
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < aArr.length; i++) {
			sb.append(aArr[i]);
		}
		map.put("GOODS_PRICE", sb.toString());

		shopDAO.updateGoodsModify(map);
	}

	@Override
	public void deleteGoods(Map<String, Object> map) throws Exception {
		shopDAO.deleteGoods(map);
		shopDAO.deleteGoodsImage(map);

	}

	@Override
	public void insertGoodsLike(Map<String, Object> map) throws Exception {
		shopDAO.insertGoodsLike(map);
	}

	@Override
	public void deleteGoodsLike(Map<String, Object> map) throws Exception {
		shopDAO.deleteGoodsLike(map);
	}

	@Override
	public List<Map<String, Object>> selectGoodsLike(Map<String, Object> map) throws Exception {
		return shopDAO.selectGoodsLike(map);
	}

}
