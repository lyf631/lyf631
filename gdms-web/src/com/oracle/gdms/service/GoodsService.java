package com.oracle.gdms.service;

import java.util.List;

import com.oracle.gdms.entity.GoodsEntity;
import com.oracle.gdms.entity.GoodsModel;
import com.oracle.gdms.entity.GoodsTypeEntity;
import com.oracle.gdms.entity.PageModel;

public interface GoodsService {

	/**
	 * 分页显示商品数据
	 * @param pageNumber 当前页码
	 * @param rows 每页多少条记录
	 * @return 
	 */
	PageModel<GoodsModel> findByPage(int pageNumber, int rows);

	
	/**
	 * 推送指定ID的商品
	 * @param goodsid
	 * @return 成功消息为空串，失败为消息内容
	 */
	String pushGoods(int goodsid);


	/**
	 * 增加一条商品记录
	 * @param goods
	 * @return 受影响的行数
	 */
	int add(GoodsEntity goods);


	/**
	 * 根据关键词搜索商品记录，分页显示
	 * @param kw 关键词
	 * @param p 页码
	 * @param rows 每页行数
	 * @return
	 */
	PageModel<GoodsModel> findByKeywords(String kw, int p, int rows);


	/**
	 * 查询数据进行导出成Excel下载
	 * @param kw
	 * @return
	 */
	List<GoodsModel> findByKeywords(String kw);

	
	/**
	 * 删除一组商品数据（更新状态）
	 * @param gid
	 */
	void delete(String[] gid);
	
	/**
	 * 根据商品ID修改一条商品记录
	 * @param goods
	 */
	int update(GoodsEntity goods);

	
	/**
	 * 查询所有商品类型
	 * @return
	 */
	 
	List<GoodsTypeEntity> findAllType();
	
	/**
	 * 更新商品类型
	 * 
	 */

	int updateGoodsType(GoodsEntity goodss);

	/**
	 * 根据商品类别查询该类别下所以商品
	 * @param gtid
	 * @return List<GoodsModel>
	 */
	List<GoodsModel> findByType(Integer gtid);
}
