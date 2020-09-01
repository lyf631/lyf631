package com.oracle.gdms.web.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import com.alibaba.fastjson.JSONObject;
import com.oracle.gdms.entity.GoodsEntity;
import com.oracle.gdms.entity.GoodsModel;
import com.oracle.gdms.entity.GoodsType;
import com.oracle.gdms.entity.ResponseEntity;
import com.oracle.gdms.service.GoodsService;
import com.oracle.gdms.util.Factory;


@Path("/hongyan")

public class HongYan {
	
	@Path("/sing")
	@GET
	public String sing() {
		System.out.println("������");
		return "HELLO";
	}
	
	@Path("/sing/{name}")
	@GET
	public String sing (@PathParam ("name") String name) {
		System.out.println("����=" + name);
		return "OK";
	}
	
	@Path("/sing/ci")  //   rest/hongyan/sing/ci?name=xxxx
	@GET
	public String singOne (@QueryParam ("name") String name) {
		System.out.println("���=" + name);
		return "CI";
	}
	
	@Path("/push/one")
	@POST
	public String push (@FormParam ("name") String name) {
		System.out.println("��Ʒ����+" + name);
		return "form";
	}
	
	@Path("/push/json")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public String pushJson (String jsonparam) {
		System.out.println(jsonparam);
		JSONObject j = JSONObject.parseObject(jsonparam);
		String name = j.getString("name");
		String sex = j.getString("sex");
		String age = j.getString("age");
		System.out.println("name=" + name);
		System.out.println("sex=" + sex);
		System.out.println("age=" + age);
		return "json";
	}
	
	@Path("/goods/update/type")
	@POST
	@Produces(MediaType.APPLICATION_JSON)  //�ͻ��ˣ����ؽ��
	@Consumes(MediaType.APPLICATION_JSON)  //����ˣ��涨���صĽ��Ϊjson����
	public String updateGoodsType(String jsonparam) {
		
		System.out.println("str=" + jsonparam);
		
		JSONObject j = JSONObject.parseObject(jsonparam);
		String goodsid = j.getString("goodsid");
		String gtid = j.getString("gtid");
		//System.out.println("Ҫ�޸ĵ���ƷID=" + goodsid + " Ŀ�����ID=" + gtid);
		
	
		GoodsService service = (GoodsService) Factory.getInsatnce().getObject("goods.service.impl");
		//GoodsService service = (GoodsService) Factory.getInsatnce().getObject("goods.service.impl");
		
		GoodsEntity goodss = new GoodsEntity();
		goodss.setGoodsid(Integer.parseInt(goodsid));
		goodss.setGtid(Integer.parseInt(gtid));
		
		int count = service.updateGoodsType(goodss);
		System.out.println("count="+count);
		
		System.out.println("Ҫ�޸ĵ���ƷID=" + goodss.getGtid() + " Ŀ�����ID=" + goodss.getGoodsid());
		if (count > 0) {
			j.put("code",0);
			j.put("msg","���³ɹ�");
		}else {
			j.put("code",1005);
			j.put("msg","������Ʒʧ��");
		}
		
		return j.toJSONString();
	}
	
	
	//��ѯ������Ʒ�������
	@Path("/push/goods/bytype")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public List<GoodsModel> findByType(GoodsType type) {

		List<GoodsModel> list = null;
		GoodsService s = (GoodsService) Factory.getInsatnce().getObject("goods.service.impl");
		list = s.findByType(type.getGtid());
		System.out.println("size=" +list.size());

		
		return list;
	}
	
	//��ѯ������Ʒ�������
	@Path("/push/goods/one")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ResponseEntity pushGoodsOne(String jsonparam) {
		
ResponseEntity r = new ResponseEntity();
		
		try {
			JSONObject a = JSONObject.parseObject(jsonparam);
			String gs = a.getString("goods");
			GoodsModel goods = JSONObject.parseObject(gs,GoodsModel.class);
			System.out.println("��ƷID="+goods.getGoodsid());
			System.out.println("��Ʒ����="+goods.getName());
			r.setCode(0);
			r.setMessage("���ͳɹ�");
		} catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
			r.setCode(1005);
			r.setMessage("����ʧ��"+jsonparam);
		}
		return r;		
	}

}
